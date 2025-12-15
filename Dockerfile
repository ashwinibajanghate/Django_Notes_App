# ---------- FRONTEND ----------
FROM node:18 AS frontend

WORKDIR /app/frontend

# Install dependencies
COPY mynotes/package*.json ./
RUN npm install

# Copy frontend code
COPY mynotes/ ./

# Build React
RUN npm run build


# ---------- BACKEND ----------
FROM python:3.9

WORKDIR /app/backend

# System dependencies
RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend source
COPY . .

# Copy React build to Django path (VERY IMPORTANT)
COPY --from=frontend /app/frontend/build /app/backend/mynotes/build

EXPOSE 8000

CMD ["gunicorn", "notesapp.wsgi:application", "--bind", "0.0.0.0:8000"]
