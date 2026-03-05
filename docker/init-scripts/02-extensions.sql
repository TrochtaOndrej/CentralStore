-- ============================================================
-- CentralStore - PostgreSQL rozsireni
-- Aktivace potrebnych extensions pro vsechny databaze
-- ============================================================

-- Helper funkce pro spusteni prikazu na vsech DB
-- PostgreSQL init skripty bezi na POSTGRES_DB (master),
-- takze extensions pro ostatni DB musime aktivovat explicitne.

-- Master DB
\c centralstore
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";      -- generovani UUID
CREATE EXTENSION IF NOT EXISTS "pg_trgm";         -- trigram index pro fulltext

-- Catalog DB
\c centralstore_catalog
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Inventory DB
\c centralstore_inventory
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- POS DB
\c centralstore_pos
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Identity DB
\c centralstore_identity
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Import DB
\c centralstore_import
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

\echo '====================================='
\echo 'PostgreSQL extensions activated OK'
\echo '====================================='
