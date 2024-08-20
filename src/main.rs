use std::env;

use actix_web::{middleware, web, App, HttpRequest, HttpServer};
use dotenv::dotenv;
use realworld_rust_backend::app_config::config_app;

async fn index(req: HttpRequest) -> &'static str {
    println!("REQ: {req:?}");
    "Hello world!"
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();
    let port = env::var("PORT")
        .unwrap_or_else(|_| "8080".to_string())
        .parse()
        .expect("PORT must be anumber");

    env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));

    log::info!("starting HTTP server at http://localhost:{}", port);

    HttpServer::new(|| {
        App::new()
            // enable logger
            .wrap(middleware::Logger::default())
            .configure(config_app)
            .service(web::resource("/").to(index))
    })
    .bind(("127.0.0.1", port))?
    .run()
    .await
}

#[cfg(test)]
mod tests {
    use actix_web::{body::to_bytes, dev::Service, http, test, Error};
    use realworld_rust_backend::handler::helthcheck;

    use super::*;

    #[actix_web::test]
    async fn test_index() -> Result<(), Error> {
        let app = App::new().route("/", web::get().to(index));
        let app = test::init_service(app).await;

        let req = test::TestRequest::get().uri("/").to_request();
        let resp = app.call(req).await?;

        assert_eq!(resp.status(), http::StatusCode::OK);

        let response_body = resp.into_body();
        assert_eq!(to_bytes(response_body).await?, r##"Hello world!"##);

        Ok(())
    }
    #[actix_web::test]
    async fn test_helthcheck() -> Result<(), Error> {
        let app = App::new().route(
            "/api/helthcheck",
            web::get().to(helthcheck::controllers::index),
        );
        let app = test::init_service(app).await;

        let req = test::TestRequest::get().uri("/api/helthcheck").to_request();
        let resp = app.call(req).await?;

        assert_eq!(resp.status(), http::StatusCode::OK);

        let response_body = resp.into_body();

        assert_eq!(to_bytes(response_body).await?, "OK");

        Ok(())
    }
}
