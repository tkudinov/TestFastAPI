IB Gateway Container with FastAPI REST API

This project containerizes IB Gateway in headless mode, automates login using IB Controller (IBC), and provides a simple FastAPI REST API for fetching account data.

 Setup Instructions

1. Clone Repository
bash:

   git clone <repository_url>
   cd <repository_folder>
2. Build Docker image and run container via Docker-compose:

   sudo docker-compose up -d

3. Test REST API:

   curl http://localhost:8000/account


---

Summary
 - Dockerfile for IB Gateway, IBC, and FastAPI
 - Automated login via IB Controller
 - REST API using FastAPI (`GET /account`)
 - Docker Compose support
 - README.txt for easy setup