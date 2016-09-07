import ceylon.http.common{...}
import ceylon.http.server { ... }
import ceylon.http.server.endpoints { ... }
import ceylon.io {
    SocketAddress
}
import com.github.tombentley.javazone2016.demo.api {
    NumberService
}
import ceylon.buffer.charset {
    utf8
}


"Starts an ceylon.http.server HTTP server on localhost:8081
 with the [[numberServiceEndpoint]].
 "
shared void run() {
    newServer{
        numberServiceEndpoint
    }.start(SocketAddress("localhost", 8081));
}

"An endpoint exposing the [[numberService]].
 on the path `/numbers/number?min={min}&max={max}`.
 "
Endpoint numberServiceEndpoint {
    // An implementation we're going to expose over HTTP
    //NumberService numberService = JavaNumberService();
    NumberService numberService = CeylonNumberService();
    return Endpoint {
        acceptMethod={get}; 
        path = startsWith("/numbers/number");
        void service(Request request, Response response) {
            try {
                value min = getParameter(request, "min", parseInteger);
                value max = getParameter(request, "max", parseInteger);
                value result = numberService.number(min, max);
                response.status = 200;
                response.addHeader(contentType("application/json", utf8));
                response.writeString(result.string);
            } catch (Exception e) {
                response.status = 400;
                response.addHeader(contentType("text/plain", utf8));
                response.writeString(e.message);
            }
        }
    };
}

"The given parameter value, or a callable for generating an error response"
Result getParameter<Result>(
        "The request containing the parameter"
        Request request,
        "The name of the parameter to get"
        String name,
        "A callable to parse the result" 
        Result?(String) parse) {
    assert(exists s = request.queryParameter(name));
    assert(exists n = parse(s));
    return n;
}
