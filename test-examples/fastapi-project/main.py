#!/usr/bin/env python3
"""FastAPI test project"""

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="flash-pkg Test API")

class Item(BaseModel):
    name: str
    price: float

@app.get("/")
def read_root():
    return {"message": "✅ FastAPI working with flash-pkg!"}

@app.get("/test")
def test_endpoint():
    return {
        "status": "success",
        "dependencies": ["fastapi", "uvicorn", "pydantic"],
        "message": "All imports working!"
    }

if __name__ == "__main__":
    print("✅ FastAPI project test passed!")
    print("Run: uvicorn main:app --reload")
