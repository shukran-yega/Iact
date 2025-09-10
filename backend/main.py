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


@app.post("/documents/upload/", response_model=schemas.DocumentOut)
async def upload_document(
    file: UploadFile = File(...),
    owner_id: int = Form(...),
    db: Session = Depends(get_db)
):
    # Append timestamp to avoid overwriting
    timestamp = datetime.now().strftime("%Y%m%d%H%M%S")
    filename = f"{timestamp}_{file.filename}"
    file_path = os.path.join(UPLOAD_FOLDER, filename)

    # Save the file to disk
    with open(file_path, "wb") as f:
        f.write(await file.read())

    # Use the file path as 'content' or just leave some placeholder if needed
    content = file_path  # you can also store None or actual text if you extract text

    # Create a DB record
    doc_in = schemas.DocumentCreate(
        filename=filename,
        content=content,
        owner_id=owner_id
    )
    db_doc = crud.create_document(db=db, doc=doc_in)

    return db_doc


@app.get("/documents/file/{filename}")
async def get_document_file(filename: str):
    """Serve the actual file from uploads folder"""
    file_path = os.path.join(UPLOAD_FOLDER, filename)
    if not os.path.exists(file_path):
        raise HTTPException(status_code=404, detail="File not found")
    return FileResponse(file_path, filename=filename)

from fastapi import status

# ------------------ Document delete endpoint ------------------
@app.delete("/documents/{doc_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_document(doc_id: int, db: Session = Depends(get_db)):
    """Delete a document file and its DB record"""
    # Find the document in the DB
    db_doc = db.query(models.Document).filter(models.Document.id == doc_id).first()
    if not db_doc:
        raise HTTPException(status_code=404, detail="Document not found")

    # Delete the file from disk if it exists
    file_path = os.path.join(UPLOAD_FOLDER, db_doc.filename)
    if os.path.exists(file_path):
        os.remove(file_path)

    # Delete record from DB
    db.delete(db_doc)
    db.commit()

    return {"detail": f"Document {doc_id} deleted successfully"}



# ------------------ Health check ------------------
@app.get("/")
def health():
    return {"status": "ok"}
