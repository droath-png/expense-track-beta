# Expense Track Beta

Full-stack expense tracking application with Node.js backend and Flutter web frontend.

## 🏗 Architecture

```
┌─────────────────┐     ┌──────────────────┐
│  Flutter Web    │────▶│  Node.js API     │
│  (Port 7777)    │     │  (Port 3000)     │
│                 │◀────│                  │
└─────────────────┘     └────────┬─────────┘
                                 │
                          ┌──────▼──────┐
                          │  SQLite DB  │
                          │  (Prisma)   │
                          └─────────────┘
```

## 📁 Project Structure

```
expense-track-beta/
├── backend/                 # Node.js + Fastify + Prisma
│   ├── src/
│   │   ├── index.ts        # Server entry point
│   │   ├── db.ts           # Database connection
│   │   ├── middleware/
│   │   │   └── auth.ts     # JWT authentication
│   │   └── routes/
│   │       ├── auth.ts     # Register/Login endpoints
│   │       ├── transactions.ts  # CRUD for transactions
│   │       └── categories.ts    # CRUD for categories
│   ├── prisma/
│   │   └── schema.prisma   # Database schema
│   ├── package.json
│   └── README.md
├── frontend/                # Flutter Web
│   ├── lib/
│   │   ├── project/        # Main app code
│   │   ├── services/
│   │   │   └── api_service.dart  # API client
│   │   └── main.dart
│   ├── pubspec.yaml
│   └── build/web/          # Compiled web app
├── README.md               # This file
├── PROJECT_STATUS.md       # Development status & roadmap
└── API_DOCS.md             # API endpoint documentation
```

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ and npm
- Flutter SDK 3.41.5+
- Git

### Backend Setup

```bash
cd backend

# Install dependencies
npm install

# Copy environment example
cp .env.example .env

# Run database migrations
npm run db:migrate

# Start development server
npm run dev
```

Server runs on: **http://localhost:3000**

### Frontend Setup

```bash
cd frontend

# Get dependencies
flutter pub get

# Run web development server
flutter run -d chrome

# Or build for production
flutter build web --release --no-tree-shake-icons
```

Production build serves on: **http://localhost:7777** (via `python3 -m http.server 7777 -d build/web`)

## 🔑 API Authentication

All endpoints except `/api/auth/*` require JWT authentication:

```
Authorization: Bearer <your_jwt_token>
```

Get a token by calling `POST /api/auth/login` or `POST /api/auth/register`.

## 📚 Documentation

- **[PROJECT_STATUS.md](./PROJECT_STATUS.md)** — What's done, what's next, known issues
- **[API_DOCS.md](./API_DOCS.md)** — Complete API reference with examples
- **[backend/README.md](./backend/README.md)** — Backend-specific documentation
- **[frontend/README.md](./frontend/README.md)** — Frontend-specific documentation

## 🛠 Tech Stack

### Backend
- **Runtime:** Node.js 25.8.1
- **Framework:** Fastify 4.25.2
- **Database:** SQLite with Prisma ORM
- **Auth:** JWT + bcrypt
- **Language:** TypeScript

### Frontend
- **Framework:** Flutter 3.41.5
- **Target:** Web (JavaScript/WASM)
- **Design:** Material Design 3
- **Fonts:** Nunito (Google Fonts)
- **Colors:** Soft pastel palette (sky blue, coral pink, soft yellow)

## 📝 Key Features

- ✅ User registration and authentication
- ✅ Income/expense transaction tracking
- ✅ Category management
- ✅ Transaction filtering by date/type
- ✅ Analytics with donut charts
- ✅ Responsive web design
- ✅ Soft pastel UI theme

## 🔜 Next Steps

See **[PROJECT_STATUS.md](./PROJECT_STATUS.md)** for detailed roadmap including:
- API integration in Flutter (replace in-memory DB)
- PostgreSQL migration for production
- Error handling and offline mode
- Testing suite
- Deployment configuration

## 👥 Development Team Handoff

This repository is ready for team development:

1. **Clone the repo**
   ```bash
   git clone https://github.com/SteveOat/expense-track-beta.git
   cd expense-track-beta
   ```

2. **Review PROJECT_STATUS.md** for current state and priorities

3. **Set up your environment** following the Quick Start guide

4. **Start developing!** Pick a task from the roadmap or fix an issue.

## 📞 Support

For questions or issues, contact the project maintainer or open a GitHub issue.

---

**Last Updated:** 2026-03-26  
**Status:** Beta - Functional but under active development
