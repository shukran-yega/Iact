import os
import time
from datetime import datetime
from fastapi import FastAPI, Depends, UploadFile, File, Form, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
from sqlalchemy.orm import Session
from passlib.hash import bcrypt
import crud, models, schemas
from database import SessionLocal, engine, Base
import mimetypes



# Create DB tables
Base.metadata.create_all(bind=engine)

# Create admin user if it doesn't exist
def create_admin_user():
    """Create admin user with staff_id=0001 if it doesn't exist"""
    try:
        db = SessionLocal()
        # Check if admin user already exists
        admin_user = db.query(models.User).filter(models.User.staff_id == "0001").first()
        if not admin_user:
            admin_data = schemas.UserCreate(
                staff_id="0001",
                username="Level 1",
                password="welcome2iact",
                email="support@iact.co.tz",
                first_name="Admin",
                last_name="IAct",
                role="admin"
            )
            crud.create_user(db=db, user=admin_data)
            print("[ADMIN USER] Created admin user with staff_id=0001")
        else:
            print("[ADMIN USER] Admin user already exists")
        db.close()
    except Exception as e:
        print(f"[ADMIN USER ERROR] Failed to create admin user: {e}")

        

# Create admin user on startup
create_admin_user()

# Upload folder
UPLOAD_FOLDER = "uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

app = FastAPI()

# CORS setup
origins = [
    "http://localhost:8000",
    "http://127.0.0.1:8000",
    "*",  # ⚠️ remove in production
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Dependency for DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# ------------------ User endpoints ------------------
@app.post("/users/", response_model=schemas.UserOut)
def register_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    """Create a new user with staff_id, name, email, and password"""
    try:
        print(f"[CREATE USER] Creating user: staff_id={user.staff_id}, username={user.username}, email={user.email}")
        return crud.create_user(db=db, user=user)
    except Exception as e:
        print(f"[CREATE USER ERROR] Failed to create user: {e}")
        raise HTTPException(status_code=400, detail=f"Failed to create user: {str(e)}")

@app.get("/users/", response_model=list[schemas.UserOut])
def get_users(db: Session = Depends(get_db)):
    """Get all users"""
    try:
        users = db.query(models.User).all()
        print(f"[GET USERS] Retrieved {len(users)} users")
        return users
    except Exception as e:
        print(f"[GET USERS ERROR] Failed to get users: {e}")
        raise HTTPException(status_code=500, detail=f"Failed to get users: {str(e)}")


# ------------------ User delete endpoint ------------------
from fastapi import status, Response

@app.patch("/users/{user_id}/role")
def update_user_role(user_id: int, role_update: schemas.UserRoleUpdate, db: Session = Depends(get_db)):
    """Update a user's role"""
    try:
        print(f"[UPDATE ROLE] Updating role for user {user_id} to {role_update.role}")
        return crud.update_user_role(db=db, user_id=user_id, new_role=role_update.role)
    except Exception as e:
        print(f"[UPDATE ROLE ERROR] Failed to update role: {e}")
        raise HTTPException(status_code=400, detail=str(e))

@app.delete("/users/{user_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_user(user_id: int, db: Session = Depends(get_db)):
    """Delete a user by ID. Returns 204 if deleted, 404 if not found."""
    try:
        db_user = db.query(models.User).filter(models.User.id == user_id).first()
        if not db_user:
            print(f"[USER DELETE ERROR] User not found: id={user_id}")
            raise HTTPException(status_code=404, detail="User not found")
        db.delete(db_user)
        db.commit()
        return Response(status_code=status.HTTP_204_NO_CONTENT)
    except HTTPException:
        raise
    except Exception as err:
        print(f"[USER DELETE ERROR] Unexpected error for id={user_id}: {err}")
        raise HTTPException(status_code=500, detail="Unexpected server error")


@app.post("/auth/login", response_model=schemas.UserLoginResponse)
def login(user: schemas.UserLogin, db: Session = Depends(get_db)):
    """Login user with email and password"""
    try:
        print(f"[LOGIN] Attempting login for email: {user.email}")
        db_user = db.query(models.User).filter(models.User.email == user.email).first()
        if not db_user:
            print(f"[LOGIN ERROR] User not found for email: {user.email}")
            raise HTTPException(status_code=401, detail="Invalid credentials")
        
        if not bcrypt.verify(user.password, db_user.password):
            print(f"[LOGIN ERROR] Invalid password for email: {user.email}")
            raise HTTPException(status_code=401, detail="Invalid credentials")
        
        print(f"[LOGIN SUCCESS] User logged in: {db_user.first_name} {db_user.last_name} ({db_user.email})")
        return db_user
    except HTTPException:
        raise
    except Exception as e:
        print(f"[LOGIN ERROR] Unexpected error during login: {e}")
        raise HTTPException(status_code=500, detail="Internal server error")


# ------------------ Folder endpoints ------------------
@app.post("/folders/", response_model=schemas.FolderOut)
def create_folder(folder: schemas.FolderCreate, db: Session = Depends(get_db)):
    """Create a new folder by name; prints errors on failure."""
    try:
        print(f"[FOLDER CREATE] name={folder.name}")
        # Create disk directory as well under uploads
        folder_dir = os.path.join(UPLOAD_FOLDER, folder.name)
        try:
            os.makedirs(folder_dir, exist_ok=True)
        except Exception as fs_err:
            print(f"[FOLDER CREATE ERROR] Failed to create dir '{folder_dir}': {fs_err}")
            raise HTTPException(status_code=500, detail="Failed to create folder directory")

        db_folder = crud.create_folder(db=db, folder=folder)
        return db_folder
    except HTTPException:
        raise
    except Exception as e:
        print(f"[FOLDER CREATE ERROR] Unexpected: {e}")
        raise HTTPException(status_code=500, detail="Unexpected server error")


@app.get("/folders/", response_model=list[schemas.FolderOut])
def list_folders(db: Session = Depends(get_db)):
    """List all folders."""
    try:
        folders = crud.list_folders(db=db)
        print(f"[FOLDER LIST] count={len(folders)}")
        return folders
    except Exception as e:
        print(f"[FOLDER LIST ERROR] {e}")
        raise HTTPException(status_code=500, detail="Unexpected server error")


# ------------------ Document endpoints ------------------
@app.get("/documents/", response_model=list[schemas.DocumentOut])
def get_documents(folder_id: int | None = None, db: Session = Depends(get_db)):
    """Fetch documents; optionally filter by folder_id."""
    try:
        query = db.query(models.Document)
        if folder_id is not None:
            query = query.filter(models.Document.folder_id == folder_id)
        docs = query.all()
        print(f"[DOC LIST] folder_id={folder_id} count={len(docs)}")
        return docs
    except Exception as e:
        print(f"[DOC LIST ERROR] {e}")
        raise HTTPException(status_code=500, detail="Unexpected server error")


# ------------------ Document upload ------------------
from fastapi.middleware.trustedhost import TrustedHostMiddleware
from starlette.middleware.base import BaseHTTPMiddleware

class LargeUploadMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        if request.url.path == "/documents/upload/":
            # Increase the body limit for upload endpoint
            request.scope["server"].max_body_size = 1024 * 1024 * 50  # 50MB
        return await call_next(request)

app.add_middleware(LargeUploadMiddleware)

@app.post("/documents/upload/", response_model=schemas.DocumentOut)
async def upload_document(
    file: UploadFile = File(...),
    filename: str = Form(...),
    owner: str = Form(...),
    folder_id: int = Form(...),
    db: Session = Depends(get_db)
):
    """Upload a document, save to disk, and create DB record.
    Prints detailed error info to terminal on failure.
    """
    try:
        # Basic validation for required fields
        if not filename or not owner:
            print(f"[UPLOAD ERROR] Missing fields - filename: '{filename}', owner: '{owner}'")
            raise HTTPException(status_code=400, detail="Missing filename or owner")

        # Validate folder
        folder = db.query(models.Folder).filter(models.Folder.id == folder_id).first()
        if not folder:
            print(f"[UPLOAD ERROR] Invalid folder_id={folder_id}")
            raise HTTPException(status_code=400, detail="Invalid folder")

        # Ensure PDF extension for consistent handling in browser
        if not filename.lower().endswith(".pdf"):
            print(f"[UPLOAD INFO] Appending .pdf to filename '{filename}'")
            filename = f"{filename}.pdf"

        # Save the file to disk inside folder directory
        folder_dir = os.path.join(UPLOAD_FOLDER, folder.name)
        try:
            os.makedirs(folder_dir, exist_ok=True)
        except Exception as mk_err:
            print(f"[UPLOAD ERROR] mkdir '{folder_dir}' failed: {mk_err}")
            raise HTTPException(status_code=500, detail="Failed to prepare folder directory")

        file_path = os.path.join(folder_dir, filename)
        try:
            with open(file_path, "wb") as f:
                f.write(await file.read())
        except Exception as file_err:
            print(f"[UPLOAD ERROR] Failed writing file to '{file_path}': {file_err}")
            raise HTTPException(status_code=500, detail="Failed to save file")

        # Capture upload time as string
        uploaded_at = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

        # Create DB record
        doc_in = schemas.DocumentCreate(
            filename=filename,
            content=file_path,
            owner=owner,
            uploaded_at=uploaded_at,
            folder_id=folder_id
        )
        try:
            db_doc = crud.create_document(db=db, doc=doc_in)
        except Exception as db_err:
            print(f"[UPLOAD ERROR] DB insert failed for '{filename}' owner '{owner}': {db_err}")
            # Best-effort cleanup of the file
            try:
                if os.path.exists(file_path):
                    os.remove(file_path)
            except Exception as cleanup_err:
                print(f"[UPLOAD ERROR] Cleanup failed for '{file_path}': {cleanup_err}")
            raise HTTPException(status_code=500, detail="Database error while creating document")

        return db_doc
    except HTTPException:
        # Already printed and will propagate appropriate status
        raise
    except Exception as err:
        print(f"[UPLOAD ERROR] Unexpected error: {err}")
        raise HTTPException(status_code=500, detail="Unexpected server error")
@app.get("/documents/file/{filename}")
async def get_document_file(filename: str, db: Session = Depends(get_db)):
    """Serve the actual file inline from uploads folder so browser renders it.
    Prints errors on failure.
    """
    try:
        # Look up document to find the saved path (supports subfolders)
        db_doc = db.query(models.Document).filter(models.Document.filename == filename).first()
        if not db_doc:
            print(f"[FILE GET ERROR] DB record not found for filename='{filename}'")
            raise HTTPException(status_code=404, detail="File not found")
        file_path = db_doc.content
        if not os.path.exists(file_path):
            print(f"[FILE GET ERROR] File not found: '{file_path}'")
            raise HTTPException(status_code=404, detail="File not found")

        # Force PDF content type for consistent inline rendering
        media_type = "application/pdf"

        headers = {"Content-Disposition": f"inline; filename=\"{filename}\""}

        return FileResponse(
            file_path,
            media_type=media_type,
            headers=headers,
        )
    except HTTPException:
        raise
    except Exception as err:
        print(f"[FILE GET ERROR] Unexpected error for filename '{filename}': {err}")
        raise HTTPException(status_code=500, detail="Unexpected server error")

from fastapi import status, Response

# ------------------ Document delete endpoint ------------------
@app.delete("/documents/{doc_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_document(doc_id: int, db: Session = Depends(get_db)):
    """Delete a document file and its DB record. Returns 204, prints errors."""
    try:
        # Find the document in the DB
        db_doc = db.query(models.Document).filter(models.Document.id == doc_id).first()
        if not db_doc:
            print(f"[DELETE ERROR] Document not found: id={doc_id}")
            raise HTTPException(status_code=404, detail="Document not found")

        # Delete the file from disk if it exists
        file_path = os.path.join(UPLOAD_FOLDER, db_doc.filename)
        try:
            if os.path.exists(file_path):
                os.remove(file_path)
        except Exception as file_err:
            print(f"[DELETE ERROR] Failed to remove file '{file_path}': {file_err}")
            # Continue to delete DB record even if file deletion fails

        # Delete record from DB
        db.delete(db_doc)
        db.commit()

        # Return empty 204 response
        return Response(status_code=status.HTTP_204_NO_CONTENT)
    except HTTPException:
        raise
    except Exception as err:
        print(f"[DELETE ERROR] Unexpected error for id={doc_id}: {err}")
        raise HTTPException(status_code=500, detail="Unexpected server error")



# ------------------ Folder delete endpoint ------------------
@app.delete("/folders/{folder_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_folder(folder_id: int, db: Session = Depends(get_db)):
    """Delete a folder by its ID and remove associated directory if needed."""
    try:
        crud.delete_folder(db, folder_id)
        # Optionally, remove the folder directory from disk
        folder_path = os.path.join(UPLOAD_FOLDER, str(folder_id))  # Adjust if directory name is different
        if os.path.exists(folder_path):
            import shutil
            shutil.rmtree(folder_path, ignore_errors=True)
        return Response(status_code=status.HTTP_204_NO_CONTENT)
    except HTTPException:
        raise
    except Exception as e:
        print(f"[FOLDER DELETE ERROR] {e}")
        raise HTTPException(status_code=500, detail="Unexpected server error")


# ------------------ Health check ------------------
@app.get("/health")
def health():
    return {"status": "ok"}
if __name__ == "__main__":
    import uvicorn
    port = int(os.environ.get("PORT", 8000))  # Use Render's port if set, else default 8000
    uvicorn.run("main:app", host="0.0.0.0", port=port, reload=True)
