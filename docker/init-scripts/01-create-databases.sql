-- ============================================================
-- CentralStore - Inicializacni skript pro PostgreSQL
-- Spusti se automaticky pri PRVNIM startu (prazdna DB)
-- ============================================================
-- Master DB (centralstore_master) je vytvorena z POSTGRES_DB env var.
-- Zde vytvarime service-specificke databaze.
-- ============================================================

-- Catalog Service DB
CREATE DATABASE centralstore_catalog
    OWNER centralstore
    ENCODING 'UTF8'
    LC_COLLATE 'en_US.utf8'
    LC_CTYPE 'en_US.utf8';

-- Inventory Service DB
CREATE DATABASE centralstore_inventory
    OWNER centralstore
    ENCODING 'UTF8'
    LC_COLLATE 'en_US.utf8'
    LC_CTYPE 'en_US.utf8';

-- POS Service DB
CREATE DATABASE centralstore_pos
    OWNER centralstore
    ENCODING 'UTF8'
    LC_COLLATE 'en_US.utf8'
    LC_CTYPE 'en_US.utf8';

-- Identity Service DB
CREATE DATABASE centralstore_identity
    OWNER centralstore
    ENCODING 'UTF8'
    LC_COLLATE 'en_US.utf8'
    LC_CTYPE 'en_US.utf8';

-- Import Service DB
CREATE DATABASE centralstore_import
    OWNER centralstore
    ENCODING 'UTF8'
    LC_COLLATE 'en_US.utf8'
    LC_CTYPE 'en_US.utf8';

-- ============================================================
-- Opakovatelna sablona pro nove tenanty:
-- Pro kazdeho noveho tenanta (napr. tenant "abc") se vytvori:
--   CREATE DATABASE cs_abc_catalog OWNER centralstore;
--   CREATE DATABASE cs_abc_inventory OWNER centralstore;
--   CREATE DATABASE cs_abc_identity OWNER centralstore;
--   CREATE DATABASE cs_abc_import OWNER centralstore;
--   (+ cs_abc_pos pokud ma modul POS)
-- Toto bude ridit Tenant Onboarding Service automaticky.
-- ============================================================

-- Potvrzeni
\echo '====================================='
\echo 'CentralStore databases created OK'
\echo '====================================='
\echo 'Databases:'
\echo '  - centralstore_master (platform)'
\echo '  - centralstore_catalog'
\echo '  - centralstore_inventory'
\echo '  - centralstore_pos'
\echo '  - centralstore_identity'
\echo '  - centralstore_import'
\echo '====================================='
