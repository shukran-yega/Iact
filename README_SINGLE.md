Single-container image running Postgres + FastAPI + Nginx (Flutter web)

Build

# from project root
docker build -f Dockerfile.single -t iact-single:latest .

Run (with a named volume for Postgres persistence)

# create a named volume and run
docker volume create iact_pgdata

docker run -it --rm -p 80:80 -p 8000:8000 -p 5432:5432 \
  -v iact_pgdata:/var/lib/postgresql/data \
  --name iact_single iact-single:latest

Notes on persistence

- The Postgres data directory inside the container is `/var/lib/postgresql/data`.
- By mounting a named Docker volume (`iact_pgdata`) to that path you ensure that the database files survive container restarts or image upgrades.
- To inspect the data volume:
  - list: `docker volume ls`
  - mountpoint depends on Docker host; under Linux you can `sudo ls /var/lib/docker/volumes/iact_pgdata/_data`

API paths

- Backend serves API under `/api/*`, for example `/api/auth/login`.
- Nginx serves the Flutter app at `/` and proxies `/api/` to the backend.

Security

- This single-container approach is intended for demo or small deployments. For production, prefer splitting services into separate containers and restrict CORS and network access.
