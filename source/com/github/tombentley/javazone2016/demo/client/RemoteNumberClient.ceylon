import ceylon.http.client {
    Request
}
import ceylon.uri {
    Parameter,
    parseUri=parse,
    Query
}

import com.github.tombentley.javazone2016.demo.api {
    NumberService
}

"Client for the [[NumberService]] using ceylon.http.client"
shared class RemoteNumberService(String url="http://localhost:8081/numbers/number") 
        satisfies NumberService {
    value base = parseUri(url);
    shared actual Integer number(Integer min, Integer max) {
        value url = base.withQuery(Query(
            Parameter("min", min.string), 
            Parameter("max", max.string)));
        value resp = Request(url).execute();
        if (resp.status != 200) {
            throw Exception("Got status code ``resp.status`` from URL ``url``");
        }
        if (is Integer result=parseInteger(resp.contents)) {
            return result;
        } else {
            throw Exception("Response was not a number, but: ``resp.contents``");
        }
    }
}
shared void runNumberClient() {
    value client = RemoteNumberService();
    while(true) {
        print(client.number(0, 10));
    }
}
