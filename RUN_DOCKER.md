Run the backend and PostgreSQL using Docker Compose

Build and start services:

```powershell
docker-compose up --build
```

The `db` service uses a Docker volume `db_data` so database files persist across restarts.

To verify persistence:

1. Start with `docker-compose up --build`.
2. Register a user via POST /auth/register.
3. Stop containers: `docker-compose down`.
4. Start again: `docker-compose up` and fetch the user from the database or call the endpoint to verify data remains.
