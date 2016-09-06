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

"Find all the controllers in the package, and start an
 Application listening on localhost:8084"
shared void run() {
    Application{
        address="127.0.0.1";
        port=8084;
        controllers = bind(`package`, "/titles");
    }.run();
}

"A controller for serving up rendered templates"
controller class RenderController() {
    Renderer renderer = Renderer {
        numbers = RemoteNumberService();
        adjectives = RemoteAdjectiveService();
        verbs = RemoteVerbService();
    };

    "A route to return the titles (a JSON array of strings) over HTTP."
    shared route("/:subject") void titles(Request req, Response resp, String subject) {
        try {
            resp.addHeader(contentType("application/json", utf8));
            resp.writeString(JsonArray {
                values = renderer.sentences(subject);
            }.pretty);
        } catch (Throwable t) {
            printStackTrace(t);
        }
    }
}

