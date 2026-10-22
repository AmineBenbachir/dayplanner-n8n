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

- `workflows/`: the three n8n workflows (main bot, city and weather sub-workflow, error alert)
- `docs/`: scoping document and screenshots
- `.env.example`: the keys needed to run the project (no real values)

## Setup

1. Import the three workflows into n8n.
2. Create the credentials listed in `.env.example` (Telegram, OpenRouter, OpenTripMap, Google Sheets).
3. Publish the workflows and send `/day Paris` to the bot.

## Test

Send `/day Paris`, `/tomorrow Rome` or `/history` to the bot.
