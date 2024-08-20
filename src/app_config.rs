use actix_web::web;

use crate::handler;

pub fn config_app(cfg: &mut web::ServiceConfig) {
    // domain includes: /products/{product_id}/parts/{part_id}
    cfg.service(
        web::scope("/api")
            .service(
                web::resource("/helthcheck")
                    .route(web::get().to(handler::helthcheck::controllers::index)),
            )
            .service(web::resource("/tags").route(web::get().to(handler::tags::api::get_tags)))
            .service(
                web::scope("/user")
                    .service(
                        web::resource("")
                            .route(web::post().to(handler::user::api::signup))
                            .route(web::put().to(handler::user::api::me))
                            .route(web::get().to(handler::user::api::user_update)),
                    )
                    .service(
                        web::resource("/login").route(web::post().to(handler::user::api::signin)),
                    ),
            ),
    );
}
