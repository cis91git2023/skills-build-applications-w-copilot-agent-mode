# OctoFit Tracker Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                    GitHub Codespace Environment                  │
│                                                                   │
│  ┌────────────────────┐         ┌───────────────────────────┐  │
│  │   React Frontend   │         │    Django Backend         │  │
│  │   (Port 3000)      │◄───────►│    (Port 8000)           │  │
│  │                    │         │                           │  │
│  │ • Activities       │  HTTP   │ • REST API               │  │
│  │ • Leaderboard      │  Fetch  │ • ViewSets               │  │
│  │ • Teams            │         │ • Serializers            │  │
│  │ • Users            │         │ • CORS Enabled           │  │
│  │ • Workouts         │         │                           │  │
│  └────────────────────┘         └───────────────┬───────────┘  │
│           │                                      │               │
│           │                                      │               │
│           │                                      ▼               │
│           │                          ┌──────────────────────┐   │
│           │                          │   MongoDB Database   │   │
│           │                          │   (Port 27017)       │   │
│           │                          │                      │   │
│           │                          │ • octofit_db         │   │
│           │                          │ • Collections:       │   │
│           │                          │   - users            │   │
│           │                          │   - teams            │   │
│           │                          │   - activities       │   │
│           │                          │   - workouts         │   │
│           │                          │   - leaderboard      │   │
│           │                          └──────────────────────┘   │
│           │                                                      │
└───────────┼──────────────────────────────────────────────────────┘
            │
            │ HTTPS
            ▼
┌───────────────────────────────────────┐
│        External Access URLs           │
│                                       │
│  Frontend:                            │
│  https://CODESPACE-3000.app.github.dev│
│                                       │
│  Backend API:                         │
│  https://CODESPACE-8000.app.github.dev│
└───────────────────────────────────────┘
```

## Data Flow

### 1. User Accesses Frontend
```
User Browser → Frontend URL (port 3000) → React App Loads
```

### 2. Frontend Fetches Data
```
React Component
  ↓
API URL Detection (via config/api.js)
  ↓
Determines Environment:
  • Codespace: https://{CODESPACE_NAME}-8000.app.github.dev/api/
  • Local: http://localhost:8000/api/
  ↓
HTTP Fetch Request
  ↓
Django REST API
```

### 3. Backend Processes Request
```
Django URL Router
  ↓
REST Framework ViewSet
  ↓
Djongo ORM (MongoDB adapter)
  ↓
MongoDB Query
  ↓
Serializer (converts data to JSON)
  ↓
HTTP Response with CORS Headers
  ↓
Frontend Receives Data
```

## Component Details

### Frontend Components
```
src/
├── App.js              # Main app with routing
├── components/
│   ├── Activities.js   # Display activities
│   ├── Leaderboard.js  # Display rankings
│   ├── Teams.js        # Display teams
│   ├── Users.js        # Display users
│   └── Workouts.js     # Display workouts
└── config/
    └── api.js          # API URL configuration
```

### Backend Structure
```
octofit_tracker/
├── models.py           # User, Team, Activity, etc.
├── serializers.py      # JSON serializers
├── views.py            # API ViewSets
├── urls.py             # URL routing
└── management/
    └── commands/
        └── populate_db.py  # Test data generator
```

### Database Collections

#### Users Collection
```javascript
{
  _id: ObjectId,
  username: String,
  email: String,
  team: String (reference to Team),
  created_at: DateTime
}
```

#### Teams Collection
```javascript
{
  _id: ObjectId,
  name: String,
  created_at: DateTime
}
```

#### Activities Collection
```javascript
{
  _id: ObjectId,
  user: ObjectId (reference),
  type: String,      // "running", "walking", "strength"
  duration: Number,  // minutes
  distance: Number,  // kilometers
  timestamp: DateTime
}
```

#### Workouts Collection
```javascript
{
  _id: ObjectId,
  name: String,
  description: String,
  timestamp: DateTime
}
```

#### Leaderboard Collection
```javascript
{
  _id: ObjectId,
  user: String,
  points: Number
}
```

## API Endpoints

All endpoints are prefixed with `/api/`

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/` | GET | API root with available endpoints |
| `/api/users/` | GET, POST | List/create users |
| `/api/users/{id}/` | GET, PUT, DELETE | User detail operations |
| `/api/teams/` | GET, POST | List/create teams |
| `/api/teams/{id}/` | GET, PUT, DELETE | Team detail operations |
| `/api/activities/` | GET, POST | List/create activities |
| `/api/activities/{id}/` | GET, PUT, DELETE | Activity detail operations |
| `/api/workouts/` | GET, POST | List/create workouts |
| `/api/workouts/{id}/` | GET, PUT, DELETE | Workout detail operations |
| `/api/leaderboard/` | GET | View leaderboard |

## Startup Process

1. **MongoDB Starts**
   - Process: `mongod --dbpath /data/db`
   - Creates database collections if they don't exist

2. **Backend Starts**
   - Virtual environment activated
   - Dependencies installed
   - Migrations applied
   - Test data populated (optional)
   - Django dev server runs on 0.0.0.0:8000

3. **Frontend Starts**
   - Node modules installed
   - Environment variables set
   - React dev server runs on port 3000
   - Detects and uses correct API URL

## Configuration Files

### Backend Configuration
- `settings.py`: Django settings, CORS, database config
- `requirements.txt`: Python dependencies
- `.env`: Environment variables (not tracked)

### Frontend Configuration
- `package.json`: Node dependencies and scripts
- `.env`: Environment variables (CODESPACE_NAME)
- `.env.example`: Template for environment variables

## Troubleshooting Flow

```
502 Bad Gateway Error
        ↓
    Check Services
        ↓
   ./check-services.sh
        ↓
    ┌───┴────┐
    │Service │
    │Status? │
    └─┬───┬──┘
      │   │
   No │   │ Yes
      │   │
      ↓   └──→ Check Logs (/tmp/*.log)
Start Service           ↓
      ↓            Fix Configuration
./start-services.sh     ↓
                   Restart Service
```

## Security Considerations

### Development Environment (Current)
- CORS: Allows all origins (CORS_ALLOW_ALL_ORIGINS = True)
- Debug mode: Enabled (DEBUG = True)
- Secret key: Hardcoded (for development only)

### Production Recommendations (Future)
- [ ] Restrict CORS to specific origins
- [ ] Disable debug mode
- [ ] Use environment variables for secrets
- [ ] Add authentication/authorization
- [ ] Use HTTPS only
- [ ] Add rate limiting
- [ ] Implement proper logging
- [ ] Use production-grade database hosting

## Performance Notes

- **Frontend**: React development server (not optimized)
- **Backend**: Django development server (single-threaded)
- **Database**: MongoDB (local instance)

For production, consider:
- Frontend: Build and serve static files via CDN
- Backend: Use Gunicorn/uWSGI with multiple workers
- Database: MongoDB Atlas or managed service
