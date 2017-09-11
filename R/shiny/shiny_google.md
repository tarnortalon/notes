# BigQuery user authentication in Shiny

## Plan

1. In UI, create a link that starts the [OAuth dance][1] with necessary
information.

  * `https://accounts.google.com/o/oauth2/v2/auth` is the Google OAuth 2.0
  endpoint.

  * Necessary parameters

    * `client_id`: The client ID of the calling app.

    * `redirect_uri`: Where the API server should redirect the user after they
    completes the authorization flow.

    * `response_type`: Whether the Google OAuth endpoint returns an
    authorization code. This should be set to `"code"`.

    * `scope`: A space-delimited list of scopes that identify the resources that
    your application could access on the user's behalf.

  * Examples

    * [`gar_shiny_getAuthUrl()`][2] in `googleAuthR`

2. Once user grants permission, they will be directed to the `redirect_uri`
specified in the previous request with a `code` parameter attached.

3. The app then uses the retrieved `code` to exchange for an access token.

  * `https://www.googleapis.com/oauth2/v4/token` is the endpoint.

  * Necessary parameters

    * `code`: The authorization code returned in the previous step.

    * `client_id` and `client_secret`: The client ID and secret of the calling
    app.

    * `redirect_uri`: One of the redirect URIs listed in the project.

    * `grant_type`: `"authorization_code"`.

  * Examples

    * [`gar_shiny_getToken()`][3] in `googleAuthR`

4. Use `bigrquery`'s [`set_access_cred()`][4] to store the received access token
so that it can be used throughout the session.

[1]: https://developers.google.com/identity/protocols/OAuth2WebServer
[2]: https://github.com/MarkEdmondson1234/googleAuthR/blob/master/R/googleAuthR_shiny.R#L185
[3]: https://github.com/MarkEdmondson1234/googleAuthR/blob/master/R/googleAuthR_shiny.R#L258
[4]: https://github.com/rstats-db/bigrquery/blob/master/R/auth.r#L56
