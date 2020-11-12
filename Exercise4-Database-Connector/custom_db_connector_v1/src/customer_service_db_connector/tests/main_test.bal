import ballerina/io;
import ballerina/test;

@test:Config {}
function test1() returns error? {
    Client d = check new ("jdbc:mysql://localhost:3306/test1", "root", "root");
    var result = d->getCustomer("1");
    io:println(result);
}

