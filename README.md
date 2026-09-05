# 🚀 kprsnt.in — Shuttle.rs Edition (Option A: 100% Free & Persistent Rust)

Always-on, **0ms cold start** deployment of [kprsnt.in](https://kprsnt.in) powered by **Rust (1.80+)**, **Axum (0.7)**, and **Shuttle.rs** cloud infrastructure.

---

## 🎯 Key Metrics vs Python Serverless

| Metric | Python (Flask on Vercel) | Rust (Axum on Shuttle.rs) | Impact |
| :--- | :--- | :--- | :--- |
| **Cold Start Latency** | 1,800ms – 3,500ms | **0ms (Always Warm)** | **Zero cold starts** |
| **Execution Model** | Ephemeral serverless function | **Persistent running service** | Reliable SSE streams |
| **RAM Footprint** | ~180MB | **~18MB** | Minimal host resource drain |
| **Templates** | 20 Jinja2 HTML templates | **Same 20 templates via Minijinja** | **0 lines of template rewrites** |
| **Cost** | $0/mo | **$0/mo (Community Tier)** | 100% Free |

---

## 🏗️ Architecture & How It Works

```mermaid
graph TD
    A[GitHub Actions Python Pipelines] -->|Emits JSON| B[job_data/ & blog_data/]
    B --> C[Rust Engine: Axum + Tokio]
    D[data/portfolio.json] --> C
    C -->|Zero Cold Start SSR| E[templates/*.html via Minijinja]
    C -->|Persistent SSE Streams| F[Model Context Protocol /api/mcp]
    C -->|In-Memory JSON APIs| G[/api/jobs/data, /api/brand/data, /api/pharma/data]
    C -->|Static Files| H[static/ Assets]
```

1. **Persistent Service (No Sleep / No Cold Starts):**
   Unlike AWS Lambda or Vercel Serverless which freeze execution and spin down containers when idle, Shuttle runs your compiled Axum binary as an always-on service in AWS `eu-central-1` / `us-east-2`.
2. **First-Class Model Context Protocol (MCP):**
   Because the Axum process is continuous, Server-Sent Events (SSE) connections at `/api/mcp` and messages at `/api/mcp` remain synchronized in memory. No session drops between requests.
3. **Template Compatibility:**
   `minijinja` compiles and renders your existing 20 Jinja2 templates (`about.html`, `projects.html`, `resume.html`, `jobs.html`, etc.) in native Rust with sub-millisecond render times.

---

## 📁 Repository Layout

```
kprsnt-shuttle/
├── src/
│   └── main.rs          # Axum router + Shuttle runtime entrypoint
├── templates/           # All 20 Jinja2 HTML templates (100% preserved)
├── static/              # CSS stylesheets, images, banners, favicon
├── data/
│   └── portfolio.json   # Exported master portfolio data (projects, skills, roles)
├── job_data/            # Daily pipeline data (telemetry, brand, pharma, jobs)
├── blog_data/           # Dynamic blog post JSON documents
├── AI_Eco_Blogs/        # Autonomous multi-agent markdown dev logs
├── Cargo.toml           # Optimized Rust & Shuttle dependencies
├── Shuttle.toml         # Shuttle project name configuration
├── .github/workflows/
│   └── deploy.yml       # Automated CI/CD deployment on every git push
└── .gitignore           # Ignores target/, Cargo.lock, .env
```

---

## 💻 Local Setup & Development Walkthrough

### 1. Prerequisites
If you don't have Rust or Cargo installed:
```powershell
# In PowerShell:
winget install Rustlang.Rustup
# Or visit https://rustup.rs
```

Install the Shuttle CLI:
```bash
cargo install cargo-shuttle
```

### 2. Run Locally with Shuttle
Navigate to this folder and start the local Shuttle runtime:
```bash
cd kprsnt-shuttle
cargo shuttle run
```
You will see:
```text
🚀 Service started on http://127.0.0.1:8000
```

### 3. Verify Endpoints in Browser
* **Homepage (About):** `http://127.0.0.1:8000/`
* **Skills Matrix:** `http://127.0.0.1:8000/skills`
* **Projects Showcase:** `http://127.0.0.1:8000/projects`
* **Interactive Resume:** `http://127.0.0.1:8000/resume`
* **Jobs Intelligence Dashboard:** `http://127.0.0.1:8000/jobs`
* **Pharma Discovery Dashboard:** `http://127.0.0.1:8000/pharma`
* **AI Eco Swarm Dashboard:** `http://127.0.0.1:8000/ecosystem`
* **Model Context Protocol (MCP):** `http://127.0.0.1:8000/api/mcp`

---

## 🚀 Push Code to GitHub & Deploy to Shuttle Cloud

### Step 1: Initialize Git and Push to Remote
Run these commands inside the `kprsnt-shuttle` directory:

```bash
git init
git add .
git commit -m "feat: Initial commit of kprsnt.in Shuttle Rust edition"
git branch -M main
git remote add origin https://github.com/kprsnt2/kprsnt-shuttle.git
git push -u origin main
```

*(Note: If the GitHub repository already contains files, run `git push -u origin main --force` on initial upload).*

### Step 2: Deploy to Shuttle Cloud (2 Options)

#### Method A: Automated via GitHub Actions (Zero Local Tooling)
1. Go to [shuttle.dev](https://www.shuttle.dev) and log in with your GitHub account.
2. Open your account settings / dashboard and copy your **Shuttle API Key**.
3. In your GitHub repository (`https://github.com/kprsnt2/kprsnt-shuttle`), go to:
   `Settings > Secrets and variables > Actions > New repository secret`
4. Name the secret `SHUTTLE_API_KEY` and paste your key.
5. That's it! Every time you push to `main`, `.github/workflows/deploy.yml` builds and deploys to Shuttle automatically.

#### Method B: Direct CLI Deployment
If you have the `cargo-shuttle` CLI installed locally:
```bash
cargo shuttle login
# (Follow browser prompt or paste API key)

cargo shuttle project start
cargo shuttle deploy
```
Your service will be live at:
`https://kprsnt-in.shuttleapp.rs` (custom domain `kprsnt.in` can be linked in project settings).
