from sqlalchemy.orm import Session
from models import User, Document, Folder
from schemas import UserCreate, DocumentCreate, FolderCreate
from passlib.hash import bcrypt

def create_user(db: Session, user: UserCreate):
    password = user.password[:72] if len(user.password.encode()) > 72 else user.password
    hashed_pw = bcrypt.hash(password)

    access_file = [] if user.role == 'Level 1' else user.accessFile

    db_user = User(
        staff_id=user.staff_id,
        username=user.username, 
        password=hashed_pw, 
        email=user.email,
        first_name=user.first_name,
        last_name=user.last_name,
        role=user.role,
        accessFile=access_file
        
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def get_user(db: Session, username: str):
    return db.query(User).filter(User.username == username).first()

def create_document(db: Session, doc: DocumentCreate):
    db_doc = Document(**doc.dict())
    db.add(db_doc)
    db.commit()
    db.refresh(db_doc)
    return db_doc

def create_folder(db: Session, folder: FolderCreate):
    db_folder = Folder(name=folder.name)
    db.add(db_folder)
    db.commit()
    db.refresh(db_folder)
    return db_folder

def list_folders(db: Session):
    return db.query(Folder).all()

def delete_folder(db: Session, folder_id: int):
    folder = db.query(Folder).filter(Folder.id == folder_id).first()
    if not folder:
        raise Exception("Folder not found")
    db.delete(folder)
    db.commit()

def update_user_role(db: Session, user_id: int, new_role: str):
    db_user = db.query(User).filter(User.id == user_id).first()
    if not db_user:
        raise Exception("User not found")
    db_user.role = new_role
    db.commit()
    db.refresh(db_user)
    return db_user

def can_access_file(user: User, file_id: int) -> bool:
    if user.role == 'Level 1':
        return True
    return file_id in user.accessFile


def update_user_access(db: Session, user_id: int, new_access: list[int]):
    db_user = db.query(User).filter(User.id == user_id).first()
    if not db_user:
        raise Exception("User not found")
    
    # Skip update for Level 1 users
    if db_user.role == 'Level 1':
        return db_user

    db_user.accessFile = new_access
    db.commit()
    db.refresh(db_user)
    return db_user
