"Implementation of [[com.github.tombentley.javazone2016.demo.api::AdjectiveService]]
 with the facility to serve adjectives over HTTP. 
 
 Demonstrates using [Vert.x](http://vertx.io)."
native("jvm")
module com.github.tombentley.javazone2016.demo.server.adjective "1.0.0" {
    import com.github.tombentley.javazone2016.demo.api "1.0.0";
    import com.github.tombentley.javazone2016.demo.client "1.0.0";
    import io.vertx.ceylon.core "3.3.2";
}
