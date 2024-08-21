use actix_web::{web, HttpResponse, Responder};
use sqlx::{pool, PgPool};

use super::{handler::NewUser, model::Users};

pub async fn signin() -> impl Responder {
    // TODO:
    HttpResponse::Ok().body("users signin")
}

pub async fn signup(pool: web::Data<PgPool>, form: web::Json<NewUser>) -> impl Responder {
    Users::signup(
        &pool,
        form.user.username.clone(),
        form.user.password.clone(),
        form.user.email.clone(),
    )
    .await;
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
