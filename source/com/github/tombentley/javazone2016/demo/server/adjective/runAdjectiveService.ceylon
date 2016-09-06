import com.github.tombentley.javazone2016.demo.client {
    RemoteNumberService
}

import io.vertx.ceylon.core {
    newvertx=vertx,
    Future
}
import io.vertx.ceylon.core.http {
    HttpServerRequest,
    HttpServer
}


"Run the module."
shared void run() {
    value as = ConstantAdjectiveService { 
        numberService = RemoteNumberService(); 
    };
    print("Starting server");

    value port = 8082;
    value address = "127.0.0.1";
    value vertx = newvertx.vertx();
    vertx.createHttpServer().requestHandler{
        void handler(HttpServerRequest request) {
            value resp = request.response();
            resp.putHeader("content-type", "text/plain");
            vertx.executeBlocking(
                // the thing which blocks
                void(Future<String?> f) {
                    f.complete(switch (request.uri()) 
                        case ("/adjective/adjective") 
                            as.adjective()
                        case ("/adjective/adverb") 
                            as.adverb()
                        else 
                            null
                    );
                },
                // what to do with the result
                void(String|Throwable? result) {
                    switch (result)
                    case (is String) {
                        resp.setStatusCode(200);// OK
                        resp.end(result);
                    }
                    else {// Throwable|Null
                        resp.setStatusCode(501);// server error
                        resp.end(result?.string else "null result!");
                    }
                }
            );
        }
    }.listen(port, address, (HttpServer|Throwable bindResult) {
        // in vertx even starting the server is async!
        // so provide a callback to know if it went OK
        if (is HttpServer bindResult) {
            print("Bound to ``address``:``port``");
        } else {
            printStackTrace(bindResult);
        }
    });
    // Now block until the process gets killed
    while (true) {
        process.readLine();
    }
}