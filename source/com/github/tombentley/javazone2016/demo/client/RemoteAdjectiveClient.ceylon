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

"Client for the [[AdjectiveService]] using ceylon.http.client"
shared class RemoteAdjectiveService(
    adjectiveUrl=parseUri("http://localhost:8082/adjective/adjective"),
    adverbUrl = parseUri("http://localhost:8082/adjective/adverb"))
        satisfies AdjectiveService {

    "The URL for getting an adjective"
    shared Uri adjectiveUrl;

    "The URL for getting an adverb"
    shared Uri adverbUrl;

    "Make a request"
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
