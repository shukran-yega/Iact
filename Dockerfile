# Start from Python slim (we will install nginx here too)
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    nginx supervisor gcc libpq-dev && \
    pip install --no-cache-dir fastapi uvicorn[standard] sqlalchemy passlib==1.7.4 bcrypt==4.0.1 python-multipart psycopg2-binary python-jose[cryptography] && \
    mkdir -p /app/backend/uploads /var/log/supervisor

# Create and set permissions for uploads directory
RUN mkdir -p /app/backend/uploads && \
    chmod 777 /app/backend/uploads

# Copy backend
COPY backend/ ./backend/

# Copy Flutter web build
COPY build_web/web /usr/share/nginx/html
COPY assets /usr/share/nginx/html/assets
COPY test.html /usr/share/nginx/html/test.html

# Create nginx log directory
RUN mkdir -p /var/log/nginx

# Set proper permissions
RUN chown -R www-data:www-data /usr/share/nginx/html
RUN chmod -R 755 /usr/share/nginx/html

# Copy and set up Nginx config
COPY nginx.conf /etc/nginx/nginx.conf
RUN ln -sf /etc/nginx/nginx.conf /etc/nginx/sites-enabled/default

# Copy supervisord config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports
EXPOSE 80

# Start supervisor
CMD ["/usr/bin/supervisord", "-n"]
