# DayPlanner

DayPlanner is a Telegram bot built with n8n. You send it a city, and it replies with a one-day plan (morning, afternoon, evening) adapted to the weather forecast.

## How it works

1. The user sends `/day <city>` or `/tomorrow <city>` on Telegram.
2. n8n finds the city and gets the weather forecast (Open-Meteo).
3. Depending on the weather (rain, heat or nice weather), it looks for suitable real places nearby (OpenTripMap).
4. An AI model (via OpenRouter) picks the best places and writes the plan.
5. The plan is sent back on Telegram and saved in a log.

## Commands

- `/day <city>`: plan for today
- `/tomorrow <city>`: plan for tomorrow
- `/history`: your last plans
- `/help`: list of commands

## Repository

- `docker-compose.yml`: self-hosted n8n with a Postgres database
- `db/init.sql`: creates the `requests` log table on the first start
- `workflows/`: the three n8n workflows (main bot, city and weather sub-workflow, error alert)
- `docs/`: scoping document and screenshots
- `.env.example`: the variables needed to run the project (no real values)

## Run it with Docker

Requirements: Docker Desktop.

1. Clone the repository and create your `.env`:
   ```
   git clone https://github.com/AmineBenbachir/dayplanner-n8n.git
   cd dayplanner-n8n
   cp .env.example .env
   ```
2. Fill in `.env`: a database password and an encryption key (`openssl rand -hex 32`).
3. Start everything:
   ```
   docker compose up -d
   ```
   Postgres starts first; n8n waits until the database healthcheck is green.
4. Open http://localhost:5678, create the owner account, then import the three files from `workflows/` (sub-workflow and error workflow first).
5. Create the credentials (Telegram, OpenRouter, OpenTripMap, Google Sheets) and publish the workflows.

Data survives restarts thanks to the named volumes `n8n_data` and `postgres_data`:
```
docker compose down
docker compose up -d
```

Telegram needs a public HTTPS address to reach n8n: start a tunnel (for example `cloudflared tunnel --url http://localhost:5678`) and put its address in `WEBHOOK_URL`.

## Test

Send `/day Paris`, `/tomorrow Rome` or `/history` to the bot.
