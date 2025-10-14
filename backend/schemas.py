from pydantic import BaseModel
from typing import List, Optional

class UserCreate(BaseModel):
    staff_id: str
    username: str
    password: str
    email: str
    first_name: str
    last_name: str
    role: str
    accessFile: Optional[List[int]] = []  # List of file IDs the user can access

class UserOut(BaseModel):
    id: int
    staff_id: str
    username: str
    email: str
    first_name: str
    last_name: str
    role: str
    accessFile: Optional[List[int]] = []
    class Config:
        from_attributes = True    

# For login (request only needs email + password)
class UserLogin(BaseModel):
    email: str
    password: str

# For login response (includes role)
class UserLoginResponse(BaseModel):
    id: int
    staff_id: str
    username: str
    email: str
    first_name: str
    last_name: str
    role: str
    accessFile: Optional[List[int]] = []
    class Config:
        from_attributes = True

class UserAccessUpdate(BaseModel):
    accessFile: List[int]    

class UserRoleUpdate(BaseModel):
    role: str
        

from pydantic import BaseModel

class DocumentCreate(BaseModel):
    filename: str
    content: str
    owner: str
    uploaded_at: str  # string to avoid DateTime issues
    folder_id: int

class DocumentOut(BaseModel):
    id: int
    filename: str
    owner: str
    uploaded_at: str
    folder_id: int

    class Config:
        from_attributes = True


class FolderCreate(BaseModel):
    name: str


class FolderOut(BaseModel):
    id: int
    name: str

    class Config:
        from_attributes = True
