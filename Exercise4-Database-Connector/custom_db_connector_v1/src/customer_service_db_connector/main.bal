import ballerina/java.jdbc;

public client class Client{
    private jdbc:Client dbc;

    public function init(string url, string username, string password) returns error? {
        self.dbc = check new (url, username, password);
    }
    
    public remote function getCustomer(string customerId) returns @tainted json|error? {
        stream<record{}, error> rs = self.dbc->query(`SELECT name, email FROM CUSTOMER WHERE customerId = ${<@untainted> customerId}`);
        record {record {} value;}? entry = check rs.next();
        string? name = ();
        string? email = ();

        if entry is record {record {} value;} {
             name = <@untainted> <string> entry.value["name"];
             email = <@untainted> <string> entry.value["email"];
             json customer = {"name": name, "email": email };
             return customer;
        }
    }

    public remote function addCustomer(string customerId, string name, string email) returns error? {
        _ = check self.dbc->execute(`INSERT INTO customer (customerId, name, email) VALUES (${<@untainted> customerId}, ${<@untainted> name}, ${<@untainted> email})`);
    }

    public remote function updateCustomer(string customerId, string name, string email) returns error? {
        _ = check self.dbc->execute(`UPDATE customer SET name = ${<@untainted> name}, email = ${<@untainted> email} WHERE customerId = ${<@untainted> customerId}`);
    }
}
