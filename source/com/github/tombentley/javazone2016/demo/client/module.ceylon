"A simple set of clients for the [[module com.github.tombentley.javazone2016.demo.api]]
 which use plain ceylon.net to access RESTful 
 service implementations."
native("jvm") 
module com.github.tombentley.javazone2016.demo.client "1.0.0" {
    shared import com.github.tombentley.javazone2016.demo.api "1.0.0";
    import ceylon.http.client "1.2.3";
    import ceylon.http.common "1.2.3";
    shared import ceylon.uri "1.2.3";
}
