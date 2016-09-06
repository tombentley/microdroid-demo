"Implementation of the `VerbService` which can be served over HTTP
 (using Vert.x web)"
native("jvm")
module com.github.tombentley.javazone2016.demo.server.verb "1.0.0" {
    import com.github.tombentley.javazone2016.demo.api "1.0.0";
    import com.github.tombentley.javazone2016.demo.client "1.0.0";
    import io.vertx.ceylon.web "3.3.2";
    import com.github.tombentley.alabama "1.0.0";
}
