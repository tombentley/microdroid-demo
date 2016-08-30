"Services exposing the [[module com.github.tombentley.javazone2016.demo.api]]
 over HTTP using various things..."
native("jvm") module com.github.tombentley.javazone2016.demo.server.number "1.0.0" {
    
    // a couple of random number implementations
    import java.base "8"; 
    import ceylon.random "1.2.3"; 
    
    import com.github.tombentley.javazone2016.demo.api "1.0.0";
    
    // we'll expose the number service using ceylon.http.server
    import ceylon.http.server "1.2.3";
    import ceylon.http.common "1.2.3";
}
