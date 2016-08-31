import ceylon.http.client {
    ...
}

import com.github.tombentley.javazone2016.demo.api {
    ...
}
import ceylon.uri {
    Uri,
    parseUri=parse
}
import com.github.tombentley.alabama {
    deserialize
}

"Client for the [[VerbService]] using ceylon.http.client"
shared class RemoteVerbService(verbUrl=parseUri("http://localhost:8083/verb"))
        satisfies VerbService {

    shared Uri verbUrl;

    Verb makeRequest(Uri uri) {
        value resp = Request(uri).execute();
        if (resp.status != 200) {
            print(resp);
            throw Exception("Got status code ``resp.status`` from URL ``uri``");
        }
        value json = resp.contents;
        return deserialize<Verb>(json);
    }

    shared actual Verb randomVerb() => makeRequest(verbUrl);

}
"Repeatedly call `randomVerb()` via the remote client, for testing purposes."
shared void runVerbClient() {
    value client = RemoteVerbService();
    while(true) {
        print(client.randomVerb());
    }
}
