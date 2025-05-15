from fastapi import FastAPI
import os
import requests

app = FastAPI()

IB_GATEWAY_HOST = os.getenv("IB_GATEWAY_HOST", "localhost")
IB_PORT = os.getenv("IB_PORT", "4001")
BASE_URL = f"http://{IB_GATEWAY_HOST}:{IB_PORT}"

@app.get("/account")
def get_account_summary():
    try:
        response = requests.get(f"{BASE_URL}/account")
        response.raise_for_status()
        return response.json()
    except Exception as e:
        return {"error": str(e)}
