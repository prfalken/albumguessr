#!/bin/bash

# Script pour exécuter la migration SQL Cover Guess
# Usage: ./run_migration.sh

echo "🔧 Exécution de la migration Cover Guess..."

# Vérifier si NETLIFY_DATABASE_URL est défini
if [ -z "$NETLIFY_DATABASE_URL" ]; then
    echo "❌ NETLIFY_DATABASE_URL n'est pas défini."
    echo "   Définissez-le avec: export NETLIFY_DATABASE_URL='postgres://...'"
    exit 1
fi

# Exécuter la migration avec psql
echo "📝 Exécution de sql/migration_cover_guess.sql..."
psql "$NETLIFY_DATABASE_URL" -f sql/migration_cover_guess.sql

if [ $? -eq 0 ]; then
    echo "✅ Migration exécutée avec succès!"
else
    echo "❌ Erreur lors de l'exécution de la migration."
    exit 1
fi
