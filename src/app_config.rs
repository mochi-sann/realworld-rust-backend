use actix_web::web;

use crate::handler::{self, tags::get_tags};

pub fn config_app(cfg: &mut web::ServiceConfig) {
    // domain includes: /products/{product_id}/parts/{part_id}
    cfg.service(
        web::scope("/api")
            .service(
                web::resource("/helthcheck")
                    .route(web::get().to(handler::helthcheck::controllers::index)),
            )
            .service(web::resource("/tags").route(web::get().to(get_tags))),
    );
}
