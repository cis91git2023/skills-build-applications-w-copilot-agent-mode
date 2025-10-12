# Build Applications with GitHub Copilot Agent Mode

<img src="https://octodex.github.com/images/Professortocat_v2.png" align="right" height="200px" />

Hey cis91git2023!

Mona here. I'm done preparing your exercise. Hope you enjoy! 💚

Remember, it's self-paced so feel free to take a break! ☕️

[![](https://img.shields.io/badge/Go%20to%20Exercise-%E2%86%92-1f883d?style=for-the-badge&logo=github&labelColor=197935)](https://github.com/cis91git2023/skills-build-applications-w-copilot-agent-mode/issues/1)

---

## OctoFit Tracker Application

This repository contains the OctoFit Tracker fitness application built with:
- **Frontend**: React.js
- **Backend**: Django REST Framework
- **Database**: MongoDB

### Quick Start

**For detailed setup instructions, see [STARTUP_GUIDE.md](./STARTUP_GUIDE.md)**

To start all services at once:
```bash
./start-services.sh
```

This will:
1. Start MongoDB
2. Set up and start the Django backend (port 8000)
3. Set up and start the React frontend (port 3000)

### Troubleshooting 502 Bad Gateway Errors

If you're seeing a "502 Bad Gateway" error when trying to access the frontend:

1. **Check if services are running:**
   ```bash
   # Check MongoDB
   ps aux | grep mongod
   
   # Check backend
   curl http://localhost:8000/api/
   
   # Check frontend
   curl http://localhost:3000/
   ```

2. **Start the services:**
   ```bash
   ./start-services.sh
   ```

3. **View logs if there are issues:**
   ```bash
   tail -f /tmp/backend.log
   tail -f /tmp/frontend.log
   tail -f /tmp/mongod.log
   ```

For more troubleshooting help, see [STARTUP_GUIDE.md](./STARTUP_GUIDE.md).

### Accessing the Application

- **Local Development:**
  - Backend API: http://localhost:8000/api/
  - Frontend: http://localhost:3000/

- **GitHub Codespaces:**
  - The application automatically detects Codespace environment
  - URLs will be in the format: `https://YOUR-CODESPACE-NAME-PORT.app.github.dev`

---

&copy; 2025 GitHub &bull; [Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/code_of_conduct.md) &bull; [MIT License](https://gh.io/mit)
