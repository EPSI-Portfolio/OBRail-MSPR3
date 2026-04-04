"""
seed_db.py
==========
Verifies that the database has been seeded correctly by checking
row counts in each table. Run this after docker compose up -d
to confirm the init scripts executed successfully.

Usage:
    cd backend
    python ../scripts/seed_db.py

Requires the .env file to be present in the backend folder.
"""

import os
import sys
from dotenv import load_dotenv
import psycopg2

# Load environment variables from backend/.env
env_path = os.path.join(os.path.dirname(__file__), '..', '.env')
load_dotenv(env_path)

DB_CONFIG = {
    "host":     os.getenv("POSTGRES_HOST"),
    "port":     int(os.getenv("POSTGRES_PORT", 5432)),
    "dbname":   os.getenv("POSTGRES_DB"),
    "user":     os.getenv("POSTGRES_USER"),
    "password": os.getenv("POSTGRES_PASSWORD"),
}

# Fail early if any required variable is missing.
missing = [k for k, v in DB_CONFIG.items() if v is None]
if missing:
    print(f"❌ Missing environment variables: {', '.join(missing)}")
    print("   Make sure .env is present at the project root.")
    sys.exit(1)
    
# Expected minimum row counts for each table.
EXPECTED_COUNTS = {
    "dim_countries":       33,
    "dim_transport_modes": 8,
    "dim_train_types":     2,
    "fact_routes":         100,
}

def check_table(cursor, table: str, min_count: int) -> bool:
    """Returns True if the table has at least min_count rows."""
    cursor.execute(f"SELECT COUNT(*) FROM {table};")
    count = cursor.fetchone()[0]
    status = "✅" if count >= min_count else "❌"
    print(f"  {status} {table}: {count} rows (expected >= {min_count})")
    return count >= min_count

def main():
    print("🌱 ObRail Database Seed Verification")
    print("=====================================")

    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cursor = conn.cursor()
        print(f"Connected to {DB_CONFIG['dbname']} on {DB_CONFIG['host']}:{DB_CONFIG['port']}\n")
    except Exception as e:
        print(f"❌ Could not connect to database: {e}")
        sys.exit(1)

    all_passed = True
    for table, min_count in EXPECTED_COUNTS.items():
        passed = check_table(cursor, table, min_count)
        if not passed:
            all_passed = False

    cursor.close()
    conn.close()

    print()
    if all_passed:
        print("✅ All tables seeded correctly.")
    else:
        print("❌ Some tables are missing data. Run: docker compose down -v && docker compose up -d")
        sys.exit(1)

if __name__ == "__main__":
    main()