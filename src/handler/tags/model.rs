use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use sqlx::PgPool;

#[derive(Debug, Deserialize, Serialize)]
pub struct Tag {
    pub id: i32,
    pub name: String,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
}
impl Tag {
    pub async fn list(pool: &PgPool) -> Result<Vec<Tag>, sqlx::Error> {
        let tags = sqlx::query_as!(
            Tag,
            r#"
            SELECT * FROM tags order by id ;
            "#,
        )
        .fetch_all(pool)
        .await?;

        Ok(tags)
    }
}
