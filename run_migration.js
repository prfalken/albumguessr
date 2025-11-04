#!/usr/bin/env node

import { neon } from "@neondatabase/serverless";
import { readFileSync, existsSync } from "fs";
import { fileURLToPath } from "url";
import { dirname, join } from "path";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Try to load .env file if it exists (check root and frontend directory)
const envFiles = [
    join(__dirname, ".env"),
    join(__dirname, "frontend", ".env")
];

envFiles.forEach(envFile => {
    if (existsSync(envFile)) {
        console.log(`📂 Chargement de ${envFile}...`);
        const envContent = readFileSync(envFile, "utf-8");
        envContent.split("\n").forEach(line => {
            const trimmed = line.trim();
            if (trimmed && !trimmed.startsWith("#")) {
                const [key, ...valueParts] = trimmed.split("=");
                if (key && valueParts.length > 0) {
                    const value = valueParts.join("=").replace(/^["']|["']$/g, "");
                    if (!process.env[key]) {
                        process.env[key] = value;
                    }
                }
            }
        });
    }
});

const NETLIFY_DATABASE_URL = process.env.NETLIFY_DATABASE_URL;

if (!NETLIFY_DATABASE_URL) {
    console.error("❌ NETLIFY_DATABASE_URL n'est pas défini.");
    console.error("   Définissez-le avec: export NETLIFY_DATABASE_URL='postgres://...'");
    process.exit(1);
}

console.log("🔧 Exécution de la migration Cover Guess...");

const sql = neon(NETLIFY_DATABASE_URL);

async function runMigration() {
    try {
        const migrationFile = join(__dirname, "sql", "migration_cover_guess.sql");
        const migrationSQL = readFileSync(migrationFile, "utf-8");
        
        // Split by semicolon and execute each statement
        // Remove comments (lines starting with --) and empty lines
        const cleanedSQL = migrationSQL
            .split("\n")
            .map(line => {
                const trimmed = line.trim();
                // Remove inline comments
                const commentIndex = trimmed.indexOf("--");
                if (commentIndex >= 0) {
                    return trimmed.substring(0, commentIndex).trim();
                }
                return trimmed;
            })
            .filter(line => line.length > 0)
            .join("\n");
        
        const statements = cleanedSQL
            .split(";")
            .map(s => s.trim())
            .filter(s => s.length > 0);
        
        console.log(`📝 Exécution de ${statements.length} commande(s) SQL...`);
        
        for (let i = 0; i < statements.length; i++) {
            const statement = statements[i];
            if (statement.trim()) {
                console.log(`   [${i + 1}/${statements.length}] Exécution...`);
                await sql(statement);
            }
        }
        
        console.log("✅ Migration exécutée avec succès!");
        process.exit(0);
    } catch (error) {
        console.error("❌ Erreur lors de l'exécution de la migration:", error.message);
        console.error(error);
        process.exit(1);
    }
}

runMigration();
