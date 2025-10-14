<div align="center">

# 🎉 Congratulations cis91git2023! 🎉

<img src="https://octodex.github.com/images/welcometocat.png" height="200px" />

### 🌟 You've successfully completed the exercise! 🌟

## 🚀 Share Your Success!

**Show off your new skills and inspire others!**

<a href="https://twitter.com/intent/tweet?text=I%20just%20completed%20the%20%22Build%20Applications%20with%20GitHub%20Copilot%20Agent%20Mode%22%20GitHub%20Skills%20hands-on%20exercise!%20%F0%9F%8E%89%0A%0Ahttps%3A%2F%2Fgithub.com%2Fcis91git2023%2Fskills-build-applications-w-copilot-agent-mode%0A%0A%23GitHubSkills%20%23OpenSource%20%23GitHubLearn" target="_blank" rel="noopener noreferrer">
  <img src="https://img.shields.io/badge/Share%20on%20X-1da1f2?style=for-the-badge&logo=x&logoColor=white" alt="Share on X" />
</a>
<a href="https://bsky.app/intent/compose?text=I%20just%20completed%20the%20%22Build%20Applications%20with%20GitHub%20Copilot%20Agent%20Mode%22%20GitHub%20Skills%20hands-on%20exercise!%20%F0%9F%8E%89%0A%0Ahttps%3A%2F%2Fgithub.com%2Fcis91git2023%2Fskills-build-applications-w-copilot-agent-mode%0A%0A%23GitHubSkills%20%23OpenSource%20%23GitHubLearn" target="_blank" rel="noopener noreferrer">
  <img src="https://img.shields.io/badge/Share%20on%20Bluesky-0085ff?style=for-the-badge&logo=bluesky&logoColor=white" alt="Share on Bluesky" />
</a>
<a href="https://www.linkedin.com/feed/?shareActive=true&text=I%20just%20completed%20the%20%22Build%20Applications%20with%20GitHub%20Copilot%20Agent%20Mode%22%20GitHub%20Skills%20hands-on%20exercise!%20%F0%9F%8E%89%0A%0Ahttps%3A%2F%2Fgithub.com%2Fcis91git2023%2Fskills-build-applications-w-copilot-agent-mode%0A%0A%23GitHubSkills%20%23OpenSource%20%23GitHubLearn" target="_blank" rel="noopener noreferrer">
  <img src="https://img.shields.io/badge/Share%20on%20LinkedIn-0077b5?style=for-the-badge&logo=linkedin&logoColor=white" alt="Share on LinkedIn" />
</a>

### 🎯 What's Next?

**Keep the momentum going!**

[![](https://img.shields.io/badge/Return%20to%20Exercise-%E2%86%92-1f883d?style=for-the-badge&logo=github&labelColor=197935)](https://github.com/cis91git2023/skills-build-applications-w-copilot-agent-mode/issues/1)
[![GitHub Skills](https://img.shields.io/badge/Explore%20GitHub%20Skills-000000?style=for-the-badge&logo=github&logoColor=white)](https://learn.github.com/skills))

*There's no better way to learn than building things!* 🚀

</div>

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
