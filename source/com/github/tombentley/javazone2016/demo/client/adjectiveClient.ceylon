import ceylon.http.client {
    Request
}
import ceylon.uri {
    parseUri=parse,
    Uri
}

import com.github.tombentley.javazone2016.demo.api {
    AdjectiveService
}

"Client for the [[AdjectiveService]] using ceylon.net"
shared class RemoteAdjectiveService(
    adjectiveUrl=parseUri("http://localhost:8082/adjective/adjective"),
    adverbUrl = parseUri("http://localhost:8082/adjective/adverb"))
        satisfies AdjectiveService {
    
    shared Uri adjectiveUrl;
    
    shared Uri adverbUrl;
    
    String makeRequest(Uri uri) {
        value resp = Request(uri).execute();
        if (resp.status != 200) {
            print(resp);
            throw Exception("Got status code ``resp.status`` from URL ``uri``");
        }
        return resp.contents;
    }
    
    shared actual String adjective() => makeRequest(adjectiveUrl);
    
    shared actual String adverb() => makeRequest(adverbUrl);
    
}
shared void runAdjectiveClient() {
    value client = RemoteAdjectiveService();
    while(true) {
        print(client.adverb());
        print(client.adjective());
    }
}
