# API Documentation — Expense Track Beta

**Base URL:** `http://localhost:3000/api`  
**Authentication:** JWT Bearer token (required for all endpoints except `/auth/*`)

---

## Authentication

### Register New User

**POST** `/auth/register`

Create a new user account.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securepassword123"
}
```

**Response (200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "cmV4YW1wbGUxMjM0NTY3ODkw",
    "email": "user@example.com"
  }
}
```

**Errors:**
- `400 Bad Request` — Invalid email format or password too short
- `409 Conflict` — Email already registered

---

### Login

**POST** `/auth/login`

Authenticate user and receive JWT token.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securepassword123"
}
```

**Response (200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "cmV4YW1wbGUxMjM0NTY3ODkw",
    "email": "user@example.com"
  }
}
```

**Errors:**
- `401 Unauthorized` — Invalid email or password

---

## Transactions

### Get All Transactions

**GET** `/transactions`

Retrieve all transactions for the authenticated user.

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

**Response (200 OK):**
```json
{
  "transactions": [
    {
      "id": "dHh4YW1wbGUxMjM0NTY3ODkw",
      "userId": "cmV4YW1wbGUxMjM0NTY3ODkw",
      "type": "expense",
      "amount": 50.00,
      "category": "Food",
      "description": "Lunch at restaurant",
      "date": "2026-03-26",
      "time": "12:30",
      "createdAt": "2026-03-26T12:30:00.000Z",
      "updatedAt": "2026-03-26T12:30:00.000Z"
    },
    {
      "id": "dHh4YW1wbGUwOTg3NjU0MzIx",
      "userId": "cmV4YW1wbGUxMjM0NTY3ODkw",
      "type": "income",
      "amount": 3000.00,
      "category": "Salary",
      "description": "Monthly salary",
      "date": "2026-03-01",
      "time": "09:00",
      "createdAt": "2026-03-01T09:00:00.000Z",
      "updatedAt": "2026-03-01T09:00:00.000Z"
    }
  ]
}
```

**Query Parameters (Optional):**
- `type` — Filter by type: `income` or `expense`
- `startDate` — Filter by start date (YYYY-MM-DD)
- `endDate` — Filter by end date (YYYY-MM-DD)
- `category` — Filter by category name

**Example with filters:**
```
GET /transactions?type=expense&startDate=2026-03-01&endDate=2026-03-31
```

---

### Create Transaction

**POST** `/transactions`

Create a new transaction.

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

**Request Body:**
```json
{
  "type": "expense",
  "amount": 50.00,
  "category": "Food",
  "description": "Lunch at restaurant",
  "date": "2026-03-26",
  "time": "12:30"
}
```

**Response (200 OK):**
```json
{
  "transaction": {
    "id": "dHh4YW1wbGUxMjM0NTY3ODkw",
    "userId": "cmV4YW1wbGUxMjM0NTY3ODkw",
    "type": "expense",
    "amount": 50.00,
    "category": "Food",
    "description": "Lunch at restaurant",
    "date": "2026-03-26",
    "time": "12:30",
    "createdAt": "2026-03-26T12:30:00.000Z",
    "updatedAt": "2026-03-26T12:30:00.000Z"
  }
}
```

**Errors:**
- `400 Bad Request` — Invalid data (missing required fields, invalid amount, etc.)
- `401 Unauthorized` — Invalid or missing token

**Validation Rules:**
- `type` — Required, must be `"income"` or `"expense"`
- `amount` — Required, must be positive number
- `category` — Required, string
- `description` — Optional, string (max 500 chars)
- `date` — Required, format YYYY-MM-DD
- `time` — Required, format HH:MM

---

### Update Transaction

**PUT** `/transactions/:id`

Update an existing transaction. User can only update their own transactions.

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

**URL Parameters:**
- `id` — Transaction ID

**Request Body (all fields optional):**
```json
{
  "type": "expense",
  "amount": 75.00,
  "category": "Food",
  "description": "Dinner at restaurant",
  "date": "2026-03-26",
  "time": "19:00"
}
```

**Response (200 OK):**
```json
{
  "transaction": {
    "id": "dHh4YW1wbGUxMjM0NTY3ODkw",
    "userId": "cmV4YW1wbGUxMjM0NTY3ODkw",
    "type": "expense",
    "amount": 75.00,
    "category": "Food",
    "description": "Dinner at restaurant",
    "date": "2026-03-26",
    "time": "19:00",
    "createdAt": "2026-03-26T12:30:00.000Z",
    "updatedAt": "2026-03-26T19:00:00.000Z"
  }
}
```

**Errors:**
- `404 Not Found` — Transaction not found
- `403 Forbidden` — Transaction belongs to another user
- `400 Bad Request` — Invalid data

---

### Delete Transaction

**DELETE** `/transactions/:id`

Delete a transaction. User can only delete their own transactions.

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

**URL Parameters:**
- `id` — Transaction ID

**Response (200 OK):**
```json
{
  "message": "Transaction deleted successfully"
}
```

**Errors:**
- `404 Not Found` — Transaction not found
- `403 Forbidden` — Transaction belongs to another user

---

### Delete All Transactions

**DELETE** `/transactions`

Delete all transactions for the authenticated user.

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

**Response (200 OK):**
```json
{
  "message": "All transactions deleted successfully"
}
```

---

## Categories

### Get All Categories

**GET** `/categories`

Retrieve all categories for the authenticated user.

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

**Response (200 OK):**
```json
{
  "categories": [
    {
      "id": "Y2F0ZXhhbXBsZTEyMzQ1Njc4OTA=",
      "userId": "cmV4YW1wbGUxMjM0NTY3ODkw",
      "name": "Food",
      "type": "expense",
      "iconCodePoint": 59616,
      "iconFontFamily": "MaterialIcons",
      "color": "#FF6B6B",
      "createdAt": "2026-03-26T10:00:00.000Z",
      "updatedAt": "2026-03-26T10:00:00.000Z"
    },
    {
      "id": "Y2F0ZXhhbXBsZTA5ODc2NTQzMjE=",
      "userId": "cmV4YW1wbGUxMjM0NTY3ODkw",
      "name": "Salary",
      "type": "income",
      "iconCodePoint": 59617,
      "iconFontFamily": "MaterialIcons",
      "color": "#87CEEB",
      "createdAt": "2026-03-26T10:00:00.000Z",
      "updatedAt": "2026-03-26T10:00:00.000Z"
    }
  ]
}
```

---

### Create Category

**POST** `/categories`

Create a new category.

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

**Request Body:**
```json
{
  "name": "Food",
  "type": "expense",
  "iconCodePoint": 59616,
  "iconFontFamily": "MaterialIcons",
  "color": "#FF6B6B"
}
```

**Response (200 OK):**
```json
{
  "category": {
    "id": "Y2F0ZXhhbXBsZTEyMzQ1Njc4OTA=",
    "userId": "cmV4YW1wbGUxMjM0NTY3ODkw",
    "name": "Food",
    "type": "expense",
    "iconCodePoint": 59616,
    "iconFontFamily": "MaterialIcons",
    "color": "#FF6B6B",
    "createdAt": "2026-03-26T10:00:00.000Z",
    "updatedAt": "2026-03-26T10:00:00.000Z"
  }
}
```

**Errors:**
- `400 Bad Request` — Invalid data (missing required fields)
- `409 Conflict` — Category with same name already exists for user

**Validation Rules:**
- `name` — Required, string (max 100 chars)
- `type` — Required, must be `"income"` or `"expense"`
- `iconCodePoint` — Optional, integer (Unicode code point for icon)
- `iconFontFamily` — Optional, string (e.g., `"MaterialIcons"`)
- `color` — Optional, string (hex color code)

---

### Update Category

**PUT** `/categories/:id`

Update an existing category. User can only update their own categories.

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

**URL Parameters:**
- `id` — Category ID

**Request Body (all fields optional):**
```json
{
  "name": "Dining",
  "color": "#FFB6C1"
}
```

**Response (200 OK):**
```json
{
  "category": {
    "id": "Y2F0ZXhhbXBsZTEyMzQ1Njc4OTA=",
    "userId": "cmV4YW1wbGUxMjM0NTY3ODkw",
    "name": "Dining",
    "type": "expense",
    "iconCodePoint": 59616,
    "iconFontFamily": "MaterialIcons",
    "color": "#FFB6C1",
    "createdAt": "2026-03-26T10:00:00.000Z",
    "updatedAt": "2026-03-26T12:00:00.000Z"
  }
}
```

**Errors:**
- `404 Not Found` — Category not found
- `403 Forbidden` — Category belongs to another user
- `400 Bad Request` — Invalid data
- `409 Conflict` — New name conflicts with existing category

---

### Delete Category

**DELETE** `/categories/:id`

Delete a category. User can only delete their own categories.

**Headers:**
```
Authorization: Bearer <your_jwt_token>
```

**URL Parameters:**
- `id` — Category ID

**Response (200 OK):**
```json
{
  "message": "Category deleted successfully"
}
```

**Errors:**
- `404 Not Found` — Category not found
- `403 Forbidden` — Category belongs to another user

---

## Health Check

**GET** `/health`

Check if the server is running. No authentication required.

**Response (200 OK):**
```json
{
  "status": "ok",
  "timestamp": "2026-03-26T05:41:12.720Z"
}
```

---

## Error Response Format

All errors follow this format:

```json
{
  "error": "Error message describing what went wrong"
}
```

**Common HTTP Status Codes:**

| Code | Meaning | Common Causes |
|------|---------|---------------|
| 200 | OK | Request succeeded |
| 400 | Bad Request | Invalid input data, validation failed |
| 401 | Unauthorized | Missing or invalid JWT token |
| 403 | Forbidden | User doesn't have permission for this resource |
| 404 | Not Found | Resource doesn't exist |
| 409 | Conflict | Duplicate email or category name |
| 500 | Internal Server Error | Server-side error |

---

## Example: Complete Flow

### 1. Register and Login

```bash
# Register
curl -X POST http://localhost:3000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"password123"}'

# Login (save the token)
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"password123"}'
```

### 2. Create a Transaction

```bash
TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."

curl -X POST http://localhost:3000/api/transactions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "type": "expense",
    "amount": 50.00,
    "category": "Food",
    "description": "Lunch",
    "date": "2026-03-26",
    "time": "12:30"
  }'
```

### 3. Get All Transactions

```bash
curl -X GET http://localhost:3000/api/transactions \
  -H "Authorization: Bearer $TOKEN"
```

### 4. Update Transaction

```bash
curl -X PUT http://localhost:3000/api/transactions/dHh4YW1wbGUxMjM0NTY3ODkw \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"amount": 75.00}'
```

### 5. Delete Transaction

```bash
curl -X DELETE http://localhost:3000/api/transactions/dHh4YW1wbGUxMjM0NTY3ODkw \
  -H "Authorization: Bearer $TOKEN"
```

---

## Testing with Postman/Insomnia

1. Create a new request collection
2. Add base URL: `http://localhost:3000/api`
3. Create an environment variable `token`
4. After login, save the token to the variable
5. Add authorization header to all requests: `Bearer {{token}}`

---

**Questions?** Open a GitHub issue or check `PROJECT_STATUS.md` for known issues.
