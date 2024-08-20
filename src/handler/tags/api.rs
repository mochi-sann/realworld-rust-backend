use actix_web::{error, web, Error, HttpResponse, Responder};
use serde::{Deserialize, Serialize};
use sqlx::PgPool;

use super::model::Tag;

#[derive(Debug, Serialize, Deserialize)]
struct Tags {
    tags: Vec<String>,
}
impl Tags {
    pub fn from_vec(tags: Vec<Tag>) -> Self {
        Tags {
            tags: tags.into_iter().map(|tag| tag.name).collect(),
        }
    }
}

pub async fn get_tags(pool: web::Data<PgPool>) -> Result<impl Responder, Error> {
    // TODO: update get the real article todos
    let list = Tag::list(&pool)
        .await
        .map_err(error::ErrorInternalServerError);
    let tags_list = Tags::from_vec(list?);
    Ok(HttpResponse::Ok().json(tags_list))
}
