"Provides a couple of implementations of 
 [[com.github.tombentley.javazone2016.demo.api::NumberService]]
 and can expose them over HTTP."
native("jvm") module com.github.tombentley.javazone2016.demo.server.number "1.0.0" {
    
    // a couple of random number implementations
    import java.base "8"; 
    import ceylon.random "1.3.1"; 
    
    import com.github.tombentley.javazone2016.demo.api "1.0.0";
    
    // we'll expose the number service using ceylon.http.server
    import ceylon.http.server "1.3.1";
    import ceylon.http.common "1.3.1";
}
