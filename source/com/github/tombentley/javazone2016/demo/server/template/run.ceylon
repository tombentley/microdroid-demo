import com.github.tombentley.javazone2016.demo.client {
    RemoteAdjectiveService,
    RemoteNumberService,
    RemoteVerbService
}
import com.github.bjansen.gyokuro.core {
    Application,
    controller,
    route,
    bind
}
import ceylon.http.server {
    Request,
    Response
}
import ceylon.json {
    JsonArray
}
import ceylon.http.common {
    contentType
}
import ceylon.buffer.charset {
    utf8
}
import ceylon.collection {
    ArrayList
}

"A controller for serving up rendered templates"
controller class RenderController(String[] subjects=["Donald Trump", "Hillary Clinton"]) {
    value numbers = RemoteNumberService();

    "Returns the given elements in a suffled order, using a
     Fisher-Yates shuffle"
    function shuffle<T>({T*} elements) {
        ArrayList<T> list = ArrayList<T>{*elements};
        for (i in ((list.size - 1)..1)) {
            value j = numbers.number(0, i);
            assert (exists tmp = list[j],
                exists tmp2 = list[i]);
            list[j] = tmp2;
            list[i] = tmp;
        }
        return list;
    }
    "Use the Renderer to get a bunch of rendered titles"
    function getTitles() {
        Renderer r = Renderer {
            numbers = numbers;
            adjectives = RemoteAdjectiveService();
            verbs = RemoteVerbService();
            templates = ConstantRenderService();
        };
        return shuffle{
            for (subject in subjects)
            for (title in r.sentences(subject))
                title
        };
    }

    "A route to return the titles (a JSON array of strings) over HTTP."
    shared route("/") void titles(Request req, Response resp) {
        try {
            resp.addHeader(contentType("application/json", utf8));
            resp.writeString(JsonArray {
                values = getTitles();
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