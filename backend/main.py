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
    return crud.create_user(db=db, user=user)


@app.post("/auth/login", response_model=schemas.UserLoginResponse)
def login(user: schemas.UserLogin, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.username == user.username).first()
    if not db_user or not bcrypt.verify(user.password, db_user.password):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    return db_user


# ------------------ Document endpoints ------------------
@app.get("/documents/", response_model=list[schemas.DocumentOut])
def get_documents(db: Session = Depends(get_db)):
    """Fetch all documents from DB"""
    return db.query(models.Document).all()


# ------------------ Document upload ------------------
@app.post("/documents/upload/", response_model=schemas.DocumentOut)
async def upload_document(
    file: UploadFile = File(...),
    filename: str = Form(...),
    owner: str = Form(...),
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

        # Ensure PDF extension for consistent handling in browser
        if not filename.lower().endswith(".pdf"):
            print(f"[UPLOAD INFO] Appending .pdf to filename '{filename}'")
            filename = f"{filename}.pdf"

        # Save the file to disk
        file_path = os.path.join(UPLOAD_FOLDER, filename)
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
            uploaded_at=uploaded_at
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
async def get_document_file(filename: str):
    """Serve the actual file inline from uploads folder so browser renders it.
    Prints errors on failure.
    """
    try:
        file_path = os.path.join(UPLOAD_FOLDER, filename)
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



# ------------------ Health check ------------------
@app.get("/health")
def health():
    return {"status": "ok"}
