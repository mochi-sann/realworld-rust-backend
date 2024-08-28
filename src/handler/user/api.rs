use std::fmt::Debug;

use actix_web::{web, HttpResponse, Responder};
use sqlx::PgPool;

use super::{
    handler::{NewUserReq, SignInUserReq},
    model::Users,
};

pub async fn signin(pool: web::Data<PgPool>, form: web::Json<SignInUserReq>) -> impl Responder {
    let user = Users::signin(&pool, form.user.email.clone(), form.user.password.clone()).await;

    match user {
        Ok(value) => HttpResponse::Ok().json(value.add_token(Users::ganarate_token())),
        Err(..) => HttpResponse::UnprocessableEntity().body(""),
    }
}

pub async fn signup(pool: web::Data<PgPool>, form: web::Json<NewUserReq>) -> impl Responder {
    let new_user = Users::signup(
        &pool,
        form.user.username.clone(),
        form.user.password.clone(),
        form.user.email.clone(),
    )
    .await;

    match new_user {
        Ok(value) => HttpResponse::Ok().json(value.add_token(Users::ganarate_token())),
        Err(..) => HttpResponse::UnprocessableEntity().body(""),
    }
}

pub async fn me() -> impl Responder {
    // TODO:
    HttpResponse::Ok().body("users info")
}

pub async fn user_update() -> impl Responder {
    // TODO:
    HttpResponse::Ok().body("updated user")
}
