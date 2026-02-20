-- ============================================
-- Digital Ace — TikTok Growth Tracker
-- Execute este SQL no Supabase SQL Editor
-- ============================================

-- Países
CREATE TABLE countries (
  code TEXT PRIMARY KEY,
  label TEXT NOT NULL,
  flag TEXT DEFAULT '🏳️',
  color TEXT DEFAULT '#888888',
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Contas
CREATE TABLE accounts (
  id TEXT NOT NULL,
  country TEXT NOT NULL REFERENCES countries(code) ON DELETE CASCADE,
  niche TEXT DEFAULT '',
  status TEXT DEFAULT 'active',
  created_at DATE DEFAULT CURRENT_DATE,
  PRIMARY KEY (id, country)
);

-- Dados diários de followers
CREATE TABLE daily_data (
  account_id TEXT NOT NULL,
  account_country TEXT NOT NULL,
  date DATE NOT NULL,
  followers INTEGER NOT NULL DEFAULT 0,
  updated_at TIMESTAMPTZ DEFAULT now(),
  PRIMARY KEY (account_id, account_country, date),
  FOREIGN KEY (account_id, account_country) REFERENCES accounts(id, country) ON DELETE CASCADE
);

-- Vídeos postados
CREATE TABLE videos (
  id BIGSERIAL PRIMARY KEY,
  account_id TEXT NOT NULL,
  account_country TEXT NOT NULL,
  date DATE NOT NULL,
  time TEXT DEFAULT '',
  niche TEXT DEFAULT '',
  notes TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT now(),
  FOREIGN KEY (account_id, account_country) REFERENCES accounts(id, country) ON DELETE CASCADE
);

-- Mudanças de nicho
CREATE TABLE niche_changes (
  id BIGSERIAL PRIMARY KEY,
  account_id TEXT NOT NULL,
  account_country TEXT NOT NULL,
  date DATE NOT NULL,
  niche_from TEXT DEFAULT '',
  niche_to TEXT NOT NULL,
  reason TEXT DEFAULT '',
  created_at TIMESTAMPTZ DEFAULT now(),
  FOREIGN KEY (account_id, account_country) REFERENCES accounts(id, country) ON DELETE CASCADE
);

-- ============================================
-- Habilitar acesso público (sem login)
-- ============================================
ALTER TABLE countries ENABLE ROW LEVEL SECURITY;
ALTER TABLE accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE daily_data ENABLE ROW LEVEL SECURITY;
ALTER TABLE videos ENABLE ROW LEVEL SECURITY;
ALTER TABLE niche_changes ENABLE ROW LEVEL SECURITY;

-- Políticas: qualquer um pode ler e escrever
CREATE POLICY "public_read_countries" ON countries FOR SELECT USING (true);
CREATE POLICY "public_write_countries" ON countries FOR INSERT WITH CHECK (true);
CREATE POLICY "public_update_countries" ON countries FOR UPDATE USING (true);
CREATE POLICY "public_delete_countries" ON countries FOR DELETE USING (true);

CREATE POLICY "public_read_accounts" ON accounts FOR SELECT USING (true);
CREATE POLICY "public_write_accounts" ON accounts FOR INSERT WITH CHECK (true);
CREATE POLICY "public_update_accounts" ON accounts FOR UPDATE USING (true);
CREATE POLICY "public_delete_accounts" ON accounts FOR DELETE USING (true);

CREATE POLICY "public_read_daily" ON daily_data FOR SELECT USING (true);
CREATE POLICY "public_write_daily" ON daily_data FOR INSERT WITH CHECK (true);
CREATE POLICY "public_update_daily" ON daily_data FOR UPDATE USING (true);
CREATE POLICY "public_delete_daily" ON daily_data FOR DELETE USING (true);

CREATE POLICY "public_read_videos" ON videos FOR SELECT USING (true);
CREATE POLICY "public_write_videos" ON videos FOR INSERT WITH CHECK (true);
CREATE POLICY "public_delete_videos" ON videos FOR DELETE USING (true);

CREATE POLICY "public_read_niche" ON niche_changes FOR SELECT USING (true);
CREATE POLICY "public_write_niche" ON niche_changes FOR INSERT WITH CHECK (true);
CREATE POLICY "public_delete_niche" ON niche_changes FOR DELETE USING (true);

-- ============================================
-- Dados iniciais
-- ============================================
INSERT INTO countries (code, label, flag, color) VALUES
  ('US', 'US', '🇺🇸', '#C23B3B'),
  ('UK', 'UK', '🇬🇧', '#2BC5B4'),
  ('IND', 'IND', '🇮🇩', '#FBBF24'),
  ('PHI', 'PHI', '🇵🇭', '#A78BFA');

INSERT INTO accounts (id, country, niche) VALUES
  ('96','US',''), ('52','US',''), ('56','US',''), ('58','US',''),
  ('59','US',''), ('61','US',''), ('66','US',''), ('85','US',''),
  ('86','US',''), ('87','US',''),
  ('83','UK',''), ('84','UK',''),
  ('77','IND',''), ('78','IND',''), ('79','IND',''),
  ('80','PHI',''), ('81','PHI',''), ('82','PHI','');

INSERT INTO daily_data (account_id, account_country, date, followers) VALUES
  ('96','US','2026-02-19',1381), ('52','US','2026-02-19',1321),
  ('56','US','2026-02-19',1313), ('58','US','2026-02-19',1307),
  ('59','US','2026-02-19',2144), ('61','US','2026-02-19',1774),
  ('66','US','2026-02-19',1902), ('85','US','2026-02-19',0),
  ('86','US','2026-02-19',0), ('87','US','2026-02-19',0),
  ('83','UK','2026-02-19',0), ('84','UK','2026-02-19',0),
  ('77','IND','2026-02-19',5), ('78','IND','2026-02-19',3),
  ('79','IND','2026-02-19',0),
  ('80','PHI','2026-02-19',0), ('81','PHI','2026-02-19',3),
  ('82','PHI','2026-02-19',0);

-- ============================================
-- Habilitar Realtime (atualizações ao vivo)
-- ============================================
ALTER PUBLICATION supabase_realtime ADD TABLE daily_data;
ALTER PUBLICATION supabase_realtime ADD TABLE accounts;
ALTER PUBLICATION supabase_realtime ADD TABLE countries;
ALTER PUBLICATION supabase_realtime ADD TABLE videos;
ALTER PUBLICATION supabase_realtime ADD TABLE niche_changes;
