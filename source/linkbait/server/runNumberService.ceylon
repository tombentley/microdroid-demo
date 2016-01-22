import ceylon.net.http{get}
import ceylon.net.http.server { ... }
import ceylon.net.http.server.endpoints { ... }
import ceylon.io {
    SocketAddress
}
import linkbait.implementation {
    ConstantNumberService
}

"Runs an ceylon.net HTTP server exposing the [[ConstantNumberService]]."
shared void runNumberService(Integer port=8080) {
    
    value numberService = ConstantNumberService();
    // create an endpoint serving requests to the 
    // path /numbers/number?min={min}&max={max}
    value numberServiceEndpoint = Endpoint {
        acceptMethod={get}; 
        path = startsWith("/numbers/number");
        service = void (request, response) {
            Integer min;
            if (exists mins=request.parameter("min"), 
                exists m = parseInteger(mins)) {
                min = m;
            } else {
                response.responseStatus = 501;
                response.writeString("missing or malformed min query parameter");
                return;
            }
            Integer max;
            if (exists maxs=request.parameter("max"), 
                exists mx = parseInteger(maxs)) {
                max = mx;
            } else {
                response.responseStatus = 501;
                response.writeString("missing or malformed max query parameter");
                return;
            }
            value result = numberService.number(min, max);
            response.writeString(result.string);
        };
    };
    
    newServer{
        endpoints=[numberServiceEndpoint];
    }.start(SocketAddress("localhost", port));
}