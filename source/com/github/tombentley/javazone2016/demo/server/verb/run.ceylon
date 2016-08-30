import ceylon.json {
    JsonObject
}
import com.github.tombentley.alabama {
    serialize
}
import com.github.tombentley.javazone2016.demo.api{
    VerbService
}
import com.github.tombentley.javazone2016.demo.client {
    RemoteNumberService
}
import io.vertx.ceylon.core {
    newvertx=vertx
}
import io.vertx.ceylon.core.http {
    get
}
import io.vertx.ceylon.web {
    router_=router,
    RoutingContext
}

class HttpVerbService() {
    VerbService vs = ConstantVerbService(RemoteNumberService());
    value vertx = newvertx.vertx();
    value server = vertx.createHttpServer();
    
    value router = router_.router(vertx);
    
    router.route("/verb").method(get).handler((RoutingContext routingContext) {
        
        // This handler will be called for every request
        routingContext.response()
                .putHeader("content-type", "application/json");
    }).blockingHandler((RoutingContext routingContext) {
        value resp = routingContext.response();
        variable String content;
        try {
            content = serialize(vs.randomVerb());
        } catch (Exception e) {
            resp.setStatusCode(400);
            StringBuilder sb = StringBuilder();
            printStackTrace(e, sb.append);
            content = JsonObject{
                "type"-> className(e),
                "message"-> e.message,
                "stackTrace"->sb.string
            }.string;
        }
        resp.end(content);
    });
    
    server.requestHandler(router.accept).listen(8083);
}


"Run the module `com.github.tombentley.javazone2016.demo.server.verb`."
shared void runHttpVerbService() {
    HttpVerbService();
    // Now block until the process gets killed
    while (true) {
        process.readLine();
    }
}