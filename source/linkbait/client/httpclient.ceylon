import linkbait.api {
    ...
}
import ceylon.net.http.client { ... }
import ceylon.net.uri {
    parseUri=parse,
    Query,
    Parameter,
    Path,
    Uri,
    PathSegment
}
// RESTful HTTP clients for the services

"Client for the [[NumberService]] using ceylon.net"
class RestfulNumberService(String url="http://localhost:8080/numbers") 
        satisfies NumberService {
    value base = parseUri(url);
    shared actual Integer number(Integer min, Integer max) {
        // TODO add Uri.appendPath()
        value url = base.withPath(Path(true, *base.path.segments.withTrailing(PathSegment("number")))).withQuery(Query(
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
    value client = RestfulNumberService();
    while(true) {
        print(client.number(0, 10));
    }
}

class RestfulAdjectiveService(
    String url="http://localhost:8080/adjectives/adverb?good=true") 
        satisfies AdjectiveService {
    shared actual String adjective(Boolean good) => nothing;
    
    shared actual String adverb(Boolean good) => nothing;
}

class RestfulVerbService(String url="http://localhost:8080/verbs/?good=true") 
        satisfies VerbService {
    shared actual String gerund() => nothing;
    
    shared actual String infinitive() => nothing;
    
    shared actual String verb(Tense tense, Aspect aspect, Subject subject) => nothing;
}

class RestfulTemplateService(String url="http://localhost:8080/templates/template") 
        satisfies TemplateService {
    shared actual String[] templates(Integer num) => nothing;
}