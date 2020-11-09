import ballerina/http;
import ballerina/java.jdbc;

jdbc:Client dbClient = check new ("jdbc:mysql://localhost:3306/test1", "root", "root1234");

@http:ServiceConfig {
    basePath: "/customer"
}
service customerService on new http:Listener(9090) {

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/{customerId}"
    }
    resource function findCustomerById(http:Caller caller, http:Request request, string customerId) returns @tainted error? {
        stream<record{}, error> rs = dbClient->query(`SELECT name, email FROM CUSTOMER WHERE customerId = ${<@untainted> customerId}`);
        record {record {} value;}? entry = check rs.next();
        string? name = ();
        string? email = ();
        if entry is record {record {} value;} {
             name = <@untainted> <string> entry.value["name"];
             email = <@untainted> <string> entry.value["email"];
             json customer = {"name": name, "email": email };
             check caller->ok(customer);
        } else {
            check caller->notFound();
        }
    }

    @http:ResourceConfig {
            methods: ["POST"],
            path: "/"
    }
    resource function addNewCustomer(http:Caller caller, http:Request request) returns @tainted error? {
        var customer = request.getJsonPayload();

        if (customer is json) {
            string customerId =  customer.customerId.toString();
            string name =  customer.name.toString();
            string email =  customer.email.toString();
            _ = check dbClient->execute(`INSERT INTO customer (customerId, name, email) VALUES (${<@untainted> customerId}, ${<@untainted> name}, ${<@untainted> email})`); 
            check caller->ok();
        } 
    }

    @http:ResourceConfig {
                methods: ["PUT"],
                path: "/"
    }
    resource function updateCustomer(http:Caller caller, http:Request request) returns @tainted error?{
        var customer = request.getJsonPayload();

        if (customer is json) {
            string customerId =  customer.customerId.toString();
            string name =  customer.name.toString();
            string email =  customer.email.toString();
            _ = check dbClient->execute(`UPDATE test1.customer SET name = ${<@untainted> name}, email = ${<@untainted> email} WHERE customerId = ${<@untainted> customerId}`); 
            check caller->ok();
        } 
    }
}
