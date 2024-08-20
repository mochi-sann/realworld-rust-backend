use actix_web::{web, HttpResponse, Responder};
use sqlx::{pool, PgPool};

use super::handler::NewUser;

pub async fn signin() -> impl Responder {
    // TODO:
    HttpResponse::Ok().body("users signin")
}

pub async fn signup(pool: web::Data<PgPool>, form: web::Json<NewUser>) -> impl Responder {
    println!("{:?}", form);
    // TODO:
    HttpResponse::Ok().body("users signup")
}

pub async fn me() -> impl Responder {
    // TODO:
    HttpResponse::Ok().body("users info")
}

pub async fn user_update() -> impl Responder {
    // TODO:
    HttpResponse::Ok().body("updated user")
}
