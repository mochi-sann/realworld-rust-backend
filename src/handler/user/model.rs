use bcrypt::{hash, DEFAULT_COST};
use chrono::{DateTime, Utc};
use sqlx::{postgres::PgQueryResult, PgPool};

pub struct Users {
    pub id: i32,
    pub username: String,
    pub email: String,
    pub password: String,
    pub bio: String,
    pub image: String,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
}

impl Users {
    pub async fn signup(
        pool: &PgPool,
        username: String,
        password: String,
        email: String,
    ) -> Result<PgQueryResult, sqlx::Error> {
        let hashed_password = hash(password, DEFAULT_COST).expect("could not hash password.");
        sqlx::query!(
            r#"
            INSERT INTO users
            (username, email, "password", bio, image)
            VALUES($1, $2, $3, '', '');
            "#,
            username,
            email,
            hashed_password
        )
        .execute(pool)
        .await
    }
}
