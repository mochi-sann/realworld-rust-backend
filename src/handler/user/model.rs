use std::f32::consts::E;

use bcrypt::{hash, DEFAULT_COST};
use chrono::{DateTime, Utc};
use jsonwebtoken::{EncodingKey, Header};
use serde::{Deserialize, Serialize};
use sqlx::{postgres::PgQueryResult, PgPool};

use crate::handler::user::handler::NewrUserInfo;

use super::handler::SignUpUserRes;

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

#[derive(Deserialize, Serialize)]
pub struct TokenPayload {
    // issued at
    pub iat: i64,
    // expiration
    pub exp: i64,
}

static KEY: [u8; 32] = *include_bytes!("../../../secret.key"); // TODO:
static ONE_DAY: i64 = 60 * 60 * 24; // in seconds
                                    //
impl Users {
    pub async fn signup(
        pool: &PgPool,
        username: String,
        password: String,
        email: String,
    ) -> Result<NewrUserInfo, sqlx::Error> {
        let hashed_password = hash(password, DEFAULT_COST).expect("could not hash password.");

        let new_user = sqlx::query_as!(
            NewrUserInfo,
            r#"
            INSERT INTO users
            (username, email, "password", bio, image)
            VALUES($1, $2, $3, '', '')
            RETURNING email , username , bio , image;
            "#,
            username,
            email,
            hashed_password
        )
        .fetch_one(pool)
        .await;

        Ok(new_user?)
    }
    pub fn ganarate_token() -> String {
        let now = Utc::now().timestamp(); // nanosecond -> second
        let payload = TokenPayload {
            iat: now,
            exp: now + ONE_DAY,
        };

        jsonwebtoken::encode(
            &Header::default(),
            &payload,
            &EncodingKey::from_secret(&KEY),
        )
        .unwrap()
    }
}
