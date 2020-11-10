import ballerina/http;
import ballerina/oauth2;
import ballerina/log;
import ballerina/io;

const ACCESS_TOKEN = "";
const CLIENT_ID = "";
const CLIENT_SECRET = "";
const REFRESH_TOKEN = "";
const REFRESH_URL = "";

oauth2:OutboundOAuth2Provider oauth2ProviderDirect = new ({
    accessToken: ACCESS_TOKEN,
    refreshConfig: {
        clientId: CLIENT_ID,
        clientSecret: CLIENT_SECRET,
        refreshToken: REFRESH_TOKEN,
        refreshUrl: REFRESH_URL,
        clientConfig: {
            secureSocket: {
                trustStore: {
                    path: "/Library/Ballerina/distributions/ballerina-slp5/bre/security/ballerinaTruststore.p12",
                    password: "ballerina"
                }
            }
        }
    }
    
});

http:BearerAuthHandler oauth2HandlerDirect = new (oauth2ProviderDirect);

http:Client clientDirect = new ("https://graph.instagram.com", {
    auth: {
        authHandler: oauth2HandlerDirect
    },
     secureSocket: {
        trustStore: {
            path: "/Library/Ballerina/distributions/ballerina-slp5/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
});

public function main() returns error?{
    var responseDirect = clientDirect->get("/me/media?fields=id,caption");
    if (responseDirect is http:Response) {
        var resultDirect = responseDirect.getTextPayload();
        log:printInfo((resultDirect is error) ? "Failed to retrieve payload." : resultDirect);
    } else {
        io:println("Failed to call the endpoint.", responseDirect);
    }
}
