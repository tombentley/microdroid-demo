import ceylon.json {
    JsonObject
}
import io.vertx.ceylon.web {
    RoutingContext,
    routerFactory=router
}
import com.github.tombentley.alabama {
    serialize
}
import com.github.tombentley.javazone2016.demo.client {
    RemoteNumberService
}
import io.vertx.ceylon.core {
    vertxFactory=vertx
}
import io.vertx.ceylon.core.http {
    get,
    HttpServer
}
import com.github.tombentley.javazone2016.demo.api {
    VerbService
}
"Run the module `com.github.tombentley.javazone2016.demo.server.verb`."
shared void run() {
    VerbService vs = ConstantVerbService {
        numberService = RemoteNumberService();
    };
    value address = "localhost";
    value port = 8083;
    value vertx = vertxFactory.vertx();
    value server = vertx.createHttpServer();
    value router = routerFactory.router(vertx);
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
    server.requestHandler(router.accept).listen(8083, "localhost", 
        (HttpServer|Throwable result) {
            // in vertx even starting the server is async!
            // so provide a callback to know if it went OK
            if (is HttpServer result) {
                print("Bound to ``address``:``port``");
            } else {
                printStackTrace(result);
            }
        }
    );
    // Now block until the process gets killed
    while (true) {
        process.readLine();
    }
}