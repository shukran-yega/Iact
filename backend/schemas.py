from pydantic import BaseModel

class UserCreate(BaseModel):
    username: str
    password: str
    role: str

class UserOut(BaseModel):
    id: int
    username: str
    role: str
    class Config:
        orm_mode = True

# For login (request only needs username + password)
class UserLogin(BaseModel):
    username: str
    password: str

# For login response (includes role)
class UserLoginResponse(BaseModel):
    id: int
    username: str
    role: str
    class Config:
        orm_mode = True
        

from pydantic import BaseModel

class DocumentCreate(BaseModel):
    filename: str
    content: str
    owner: str
    uploaded_at: str  # string to avoid DateTime issues

class DocumentOut(BaseModel):
    id: int
    filename: str
    owner: str
    uploaded_at: str

    class Config:
        orm_mode = True
