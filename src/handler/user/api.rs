use actix_web::{HttpResponse, Responder};

pub async fn signin() -> impl Responder {
    // TODO:
    HttpResponse::Ok().body("users signin")
}

pub async fn signup() -> impl Responder {
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
