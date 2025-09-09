from fastapi import FastAPI, Depends, UploadFile, File
from sqlalchemy.orm import Session
from database import SessionLocal, engine, Base
import crud, models, schemas
from fastapi.middleware.cors import CORSMiddleware
from passlib.hash import bcrypt
from fastapi import HTTPException

Base.metadata.create_all(bind=engine)

app = FastAPI()

@app.get("/")
def health():
    return {"status": "ok"}


origins = [
    "http://localhost:8000",  # optional: include your Flutter web origin
    "http://127.0.0.1:8000",
    "*",  # allows all origins for testing, remove * in production
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Dependency for DB
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.post("/users/", response_model=schemas.UserOut)
def register_user(user: schemas.UserCreate, db: Session = Depends(get_db)):
    return crud.create_user(db=db, user=user)

@app.post("/auth/login", response_model=schemas.UserLoginResponse)
def login(user: schemas.UserLogin, db: Session = Depends(get_db)):
    db_user = db.query(models.User).filter(models.User.username == user.username).first()
    if not db_user or not bcrypt.verify(user.password, db_user.password):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    return db_user

@app.post("/documents/", response_model=schemas.DocumentOut)
def upload_document(doc: schemas.DocumentCreate, db: Session = Depends(get_db)):
    return crud.create_document(db=db, doc=doc)

@app.get("/documents/", response_model=list[schemas.DocumentOut])
def get_documents(db: Session = Depends(get_db)):
    return db.query(models.Document).all()