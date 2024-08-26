// Define an environment named "local"
env "local" {
  // Declare where the schema definition resides.
  // Also supported: ["file://multi.hcl", "file://schema.hcl"].
  src = "file://schema/schema.sql"

  // Define the URL of the database which is managed
  // in this environment.
  url = "postgres://postgres:postgres@localhost:5432/app-db?search_path=public&sslmode=disable"

  // Define the URL of the Dev Database for this environment
  // See: https://atlasgo.io/concepts/dev-database
  dev = "postgres://postgres:postgres@localhost:5432/app-db?search_path=public&sslmode=disable"
}

env "dev" {
  // ... a different env
  migration {
        // URL where the migration directory resides.
    dir = "file://migrations"
  }

}



