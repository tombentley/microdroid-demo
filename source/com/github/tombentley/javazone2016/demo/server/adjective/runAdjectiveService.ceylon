import com.github.tombentley.javazone2016.demo.api {
    NumberService
}
import io.vertx.ceylon.core {
    newvertx=vertx,
    Future
}
import io.vertx.ceylon.core.http {
    HttpServerRequest,
    HttpServer
}
import com.github.tombentley.javazone2016.demo.client {
    RemoteNumberService
}


"Run the module."
shared void run() {
    // XXX run from command line 
    // cd /home/tom/workspace/javazone-demo
    // ceylon compile
    // ceylon run com.github.tombentley.javazone2016.demo.server.adjective

    NumberService numberService = RemoteNumberService();
    value as = ConstantAdjectiveService(numberService);
    print("Starting server");
    
    
    value port = 8082;
    value address = "127.0.0.1";
    value v = newvertx.vertx();
    v.createHttpServer().requestHandler{
        void handler(HttpServerRequest request) {
            value resp = request.response();
            resp.putHeader("content-type", "text/plain");
            v.executeBlocking(
                // the thing which blocks
                void(Future<String> f) {
                    //print("blocking call");
                    switch (request.uri()) 
                    case ("/adjective/adjective") {
                        f.complete(as.adjective());
                        return;
                    }
                    case ("/adjective/adverb") {
                        f.complete(as.adverb());
                        return;
                    }
                    else {
                        
                    }
                },
                // what to do with the result
                void(String|Throwable? result) {
                    //print("result callback ``result else "null!!"``");
                    switch (result)
                    case (is String) {
                        resp.setStatusCode(200);// OK
                        resp.end(result);
                    }
                    case (is Throwable) {
                        resp.setStatusCode(501);// server error
                        resp.end(result.string);
                    }
                    else {
                        resp.setStatusCode(501);// server error
                        resp.end("null result!");
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