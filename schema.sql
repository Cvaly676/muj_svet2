-- ============================================================
-- Můj Svět Restaurant — Supabase Schema
-- Spusťte tento SQL v Supabase → SQL Editor → New query
-- ============================================================

-- 1. Tabulka jídel denního menu
CREATE TABLE IF NOT EXISTS daily_menu (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  day         text NOT NULL CHECK (day IN ('Pondělí','Úterý','Středa','Čtvrtek','Pátek','Sobota','Neděle')),
  category    text NOT NULL CHECK (category IN ('Polévka','Hlavní jídlo','Vegetariánské','Speciál dne','Dezert')),
  name        text NOT NULL,
  description text,
  price       integer NOT NULL CHECK (price > 0),
  grams       text,
  active      boolean NOT NULL DEFAULT true,
  created_at  timestamptz DEFAULT now()
);

-- 2. Row Level Security — zapnout
ALTER TABLE daily_menu ENABLE ROW LEVEL SECURITY;

-- 3. Politika: ČTENÍ je veřejné (web vidí všechna jídla)
CREATE POLICY "public_read"
  ON daily_menu FOR SELECT
  USING (true);

-- 4. Politika: ZÁPIS/MAZÁNÍ jen pro přihlášeného admina
--    (Supabase Auth — uživatel musí být přihlášen)
CREATE POLICY "admin_insert"
  ON daily_menu FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "admin_update"
  ON daily_menu FOR UPDATE
  USING (auth.role() = 'authenticated');

CREATE POLICY "admin_delete"
  ON daily_menu FOR DELETE
  USING (auth.role() = 'authenticated');

-- 5. Index pro rychlejší dotazy podle dne
CREATE INDEX IF NOT EXISTS idx_daily_menu_day ON daily_menu (day);

-- ============================================================
-- HOTOVO — nyní vytvořte admin účet v Supabase:
-- Authentication → Users → Invite user
-- Email: vas@email.cz  (majitel)
-- ============================================================
