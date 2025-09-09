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
        

class DocumentCreate(BaseModel):
    filename: str
    content: str
    owner_id: int

class DocumentOut(BaseModel):
    id: int
    filename: str
    owner_id: int
    class Config:
        orm_mode = True
