use serde::{Deserialize, Serialize};

#[derive(Default, Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct NewUserReq {
    pub user: SignUpUser,
}

#[derive(Default, Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct SignUpUser {
    pub email: String,
    pub password: String,
    pub username: String,
}

#[derive(Default, Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct SignInUserReq {
    pub user: SignInUser,
}

#[derive(Default, Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct SignInUser {
    pub email: String,
    pub password: String,
}

#[derive(Default, Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ReturnUser {
    pub user: SignUpUserRes,
}

#[derive(Default, Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct SignUpUserRes {
    pub email: String,
    pub token: String,
    pub username: String,
    pub bio: String,
    pub image: String,
}

#[derive(Default, Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct NewrUserInfo {
    pub email: String,
    pub username: String,
    pub bio: Option<String>,
    pub image: Option<String>,
}
impl NewrUserInfo {
    pub fn add_token(&self, token: String) -> SignUpUserRes {
        SignUpUserRes {
            email: self.email.clone(),
            token: token.clone(),
            username: self.username.clone(),
            bio: self.bio.clone().unwrap_or("".to_string()),
            image: self.image.clone().unwrap_or("".to_string()),
        }
    }
}
