// Define an environment named "local"
env "local" {
  // Declare where the schema definition resides.
  // Also supported: ["file://multi.hcl", "file://schema.hcl"].
  src = "file://schema.hcl"

  // Define the URL of the database which is managed
  // in this environment.
  url = "postgres://postgres:postgres@localhost:5432/app-db?search_path=public&sslmode=disable"

  // Define the URL of the Dev Database for this environment
  // See: https://atlasgo.io/concepts/dev-database
  dev = "docker://postgres/14/app-db?search_path=public&sslmode=disable"
  exclude = [ "atlas_schema_revisions.*", "*.atlas_schema_revisions"  , "atlas_schema_revision" ]
  migration {
    // URL where the migration directory resides.
    dir = "file://migrations"
  }

}

env "dev" {
  // ... a different env
  src = "file://schema.hcl"

  // Define the URL of the database which is managed
  // in this environment.
  url = "postgres://postgres:postgres@localhost:5432/app-db?search_path=public&sslmode=disable"

  // Define the URL of the Dev Database for this environment
  // See: https://atlasgo.io/concepts/dev-database
  dev = "docker://postgres/14/app-db?search_path=public&sslmode=disable"
  exclude = [ "atlas_schema_revisions" , "atlas_schema_revisions.*", "*.atlas_schema_revisions" ]
  schemas = ["public"]


  migration {
    // URL where the migration directory resides.
    dir = "file://migrations"
  }

  format {
    migrate {
      diff = "{{ sql . \"  \" }}"
    }
  }

}



