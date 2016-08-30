import ceylon.http.common{get}
import ceylon.http.server { ... }
import ceylon.http.server.endpoints { ... }
import ceylon.io {
    SocketAddress
}
import com.github.tombentley.javazone2016.demo.api {
    NumberService
}
// An implementation we're going to expose over HTTP
//NumberService numberService = JavaNumberService();
NumberService numberService = CeylonNumberService();

"An endpoint exposing the [[numberService]].
 on the path `/numbers/number?min={min}&max={max}`.
 "
Endpoint numberServiceEndpoint = Endpoint {
    acceptMethod={get}; 
    path = startsWith("/numbers/number");
    service = void (request, response) {
        value min = getParameter(request, "min", parseInteger);
        if (is Integer min) {
            value max = getParameter(request, "max", parseInteger);
            if (is Integer max) {
                value result = numberService.number(min, max);
                response.writeString(result.string);
            } else {
                // max is Anything(Response);
                max(response);
            }
        } else {
            // min is Anything(Response)
            min(response);
        }
    };
};

"The given parameter value, or a callable for generating an error response"
Result|Anything(Response) getParameter<Result>(
        "The request containing the parameter"
        Request request,
        "The name of the parameter to get"
        String name,
        "A callable to parse the result" 
        Result?(String) parse) {
    
    if (exists s = request.queryParameter(name)) {
        if (exists n = parse(s)) {
            return n;
        } else {
            return (Response response) {
                response.status = 400;//bad request
                response.writeString("query parameter ``name`` was invalid");
            };
        }
    } else {
        return (Response response) {
            response.status = 400;//bad request
            response.writeString("missing required query parameter ``name``");
        };
    }
}


"Starts an ceylon.http.server HTTP server on localhost:8081
 with the [[numberServiceEndpoint]].
"
shared void runNumberService() {
    Integer port = 8081;
    
    newServer{
        numberServiceEndpoint
    }.start(SocketAddress("localhost", port));
}