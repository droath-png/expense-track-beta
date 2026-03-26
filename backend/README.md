# Expense Tracker Backend

Node.js + Fastify + Prisma backend for MMAS Expense Tracker.

## Setup

```bash
# Install dependencies
npm install

# Copy environment file
cp .env.example .env

# Run migrations
npm run db:migrate

# Start development server
npm run dev
```

## API Endpoints

### Auth
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user

### Transactions
- `GET /api/transactions` - Get all transactions
- `GET /api/transactions/:id` - Get single transaction
- `POST /api/transactions` - Create transaction
- `PUT /api/transactions/:id` - Update transaction
- `DELETE /api/transactions/:id` - Delete transaction
- `DELETE /api/transactions` - Delete all transactions

### Categories
- `GET /api/categories` - Get all categories
- `POST /api/categories` - Create category
- `PUT /api/categories/:id` - Update category
- `DELETE /api/categories/:id` - Delete category

## Authentication

All endpoints (except `/api/auth/*`) require JWT token in Authorization header:

```
Authorization: Bearer <token>
```

## Database

Uses SQLite for development. Switch to PostgreSQL for production by changing `schema.prisma`:

```prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}
```
