import ceylon.buffer.charset {
    utf8
}
import ceylon.http.common {
    contentType
}
import ceylon.http.server {
    Request,
    Response
}
import ceylon.json {
    JsonArray
}
import com.github.bjansen.gyokuro.core {
    Application,
    controller,
    route,
    bind
}
import com.github.tombentley.javazone2016.demo.client {
    RemoteAdjectiveService,
    RemoteNumberService,
    RemoteVerbService
}

"A controller for serving up rendered templates"
controller class RenderController() {
    
    value numbers = RemoteNumberService();
    
    "Use the Renderer to get a bunch of rendered titles"
    function getTitles(String subject) {
        Renderer r = Renderer {
            numbers = numbers;
            adjectives = RemoteAdjectiveService();
            verbs = RemoteVerbService();
        };
        return {
            for (title in r.sentences(subject))
                title
        };
    }

    "A route to return the titles (a JSON array of strings) over HTTP."
    shared route("/:subject") void titles(Request req, Response resp, String subject) {
        try {
            resp.addHeader(contentType("application/json", utf8));
            resp.writeString(JsonArray {
                values = getTitles(subject);
            }.pretty);
        } catch (Throwable t) {
            printStackTrace(t);
        }
    }
}

"Find all the controllers in the package, and start an
 Application listening on localhost:8084"
shared void run() {
    Application{
        address="127.0.0.1";
        port=8084;
        controllers = bind(`package`, "/titles");
    }.run();
}