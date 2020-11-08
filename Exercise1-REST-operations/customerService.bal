import ballerina/http;
import ballerina/io;

map<json> customerData = {"1": {id: "1", name: "Alex", address: "12, Sea View Road, Colombo", email: "alex@gmail.com"}};

@http:ServiceConfig {
    basePath: "/customer"
}
service customerService on new http:Listener(9090) {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/{customerId}"
    }
    resource function findCustomerById(http:Caller caller, http:Request request, string customerId){
        json? payload = customerData[customerId];
        if (payload == ()) {
            payload = "Customer: " + customerId + " not found";
        }

        http:Response response = new;
        response.setJsonPayload(<@untainted> payload);

        error? result = caller->respond(response);
        if (result is error) {
            io:println("Error sending response", result);
        }
    }

    @http:ResourceConfig {
            methods: ["POST"],
            path: "/"
    }
    resource function addNewCustomer(http:Caller caller, http:Request request){
        var customer = request.getJsonPayload();
        http:Response response = new;

        if (customer is json) {
            string customerId =  customer.id.toString();
            customerData[customerId] = <@untainted> customer;
            json payload = {status: "Customer added", customerId: customerId};
            response.setJsonPayload(<@untainted> payload);
            response.statusCode = 201;
        } else {
            response.statusCode = 400;
            response.setPayload("Invalid payload received");
        }

        error? result = caller->respond(response);
        if (result is error) {
            io:println("Error sending response", result);
        }
    }

    @http:ResourceConfig {
                methods: ["PUT"],
                path: "/"
    }
    resource function updateCustomer(http:Caller caller, http:Request request){
        http:Response response = new;
        var updatedCustomer = request.getJsonPayload();
        if (updatedCustomer is json) {
            string customerId =  updatedCustomer.id.toString();

            if (customerData[customerId]) != () {
                customerData[customerId] = <@untainted> updatedCustomer;
                json payload = {status: "Customer updated", customerId: customerId};
                response.setJsonPayload(<@untainted> payload);
                response.statusCode = 201;
            } else {
                json payload = {status: "Customer not found", customerId: customerId};
                response.setJsonPayload(<@untainted> payload);
            }

        } else {
            response.statusCode = 400;
            response.setPayload("Invalid payload received");
        }

        error? result = caller->respond(response);
        if (result is error) {
            io:println("Error sending response", result);
        }
    }
}
