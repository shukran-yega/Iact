from sqlalchemy import Column, Integer, String, ForeignKey, JSON
from sqlalchemy.orm import relationship
from database import Base

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    staff_id = Column(String, unique=True, index=True)  # Staff ID like "0001"
    username = Column(String, unique=True, index=True)
    password = Column(String)   # hashed password
    email = Column(String, unique=True, index=True)  # Email address
    first_name = Column(String)  # First name
    last_name = Column(String)   # Last name
    role = Column(String)       # e.g. "employee", "admin"
    accessFile = Column(JSON, default=[])

class Document(Base):
    __tablename__ = "documents"
    id = Column(Integer, primary_key=True, index=True)
    filename = Column(String, nullable=False)
    content = Column(String, nullable=False)   # can be path or base64
    owner = Column(String, nullable=False)     # store username directly
    uploaded_at = Column(String, nullable=False)
    folder_id = Column(Integer, ForeignKey("folders.id"), nullable=False)


class Folder(Base):
    __tablename__ = "folders"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True, index=True, nullable=False)