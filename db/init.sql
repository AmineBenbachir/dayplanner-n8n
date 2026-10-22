-- Runs once, on the first start of the Postgres container.
-- Table used to log every plan request (same columns as the original log sheet).
CREATE TABLE IF NOT EXISTS requests (
  id           SERIAL PRIMARY KEY,
  timestamp    TIMESTAMPTZ NOT NULL DEFAULT now(),
  update_id    BIGINT UNIQUE,
  chat_id      BIGINT NOT NULL,
  city         TEXT,
  country      TEXT,
  weather      TEXT,
  tmax         NUMERIC,
  rain_prob    NUMERIC,
  places_count INTEGER,
  plan         TEXT,
  status       TEXT
);
