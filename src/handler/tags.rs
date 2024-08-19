use actix_web::{HttpResponse, Responder};
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
struct Tags {
    tags: Vec<String>,
}

pub async fn get_tags() -> impl Responder {
    let tags: Tags = Tags {
        tags: vec![
            "hoge".to_string(),
            "fuga".to_string(),
            "hoge".to_string(),
            "fuga".to_string(),
            "hoge".to_string(),
            "fuga".to_string(),
        ],
    };

    HttpResponse::Ok().json(tags)
}
