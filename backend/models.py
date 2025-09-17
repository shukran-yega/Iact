from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from database import Base

class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)
    password = Column(String)   # hashed password
    role = Column(String)       # e.g. "employee", "admin"

class Document(Base):
    __tablename__ = "documents"
    id = Column(Integer, primary_key=True, index=True)
    filename = Column(String, nullable=False)
    content = Column(String, nullable=False)   # can be path or base64
    owner = Column(String, nullable=False)     # store username directly
    uploaded_at = Column(String, nullable=False)