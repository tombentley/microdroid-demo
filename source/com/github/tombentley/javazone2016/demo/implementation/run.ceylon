import com.github.tombentley.javazone2016.demo.api {
    Subject
}
import com.github.tombentley.javazone2016.demo.client {
    RemoteNumberService,
    RemoteAdjectiveService,
    RemoteVerbService
}

"Runs the renderer generating linkbait to standard output."
shared void run() {
    value numbers = RemoteNumberService(); 
    Renderer r = Renderer { 
        numbers = numbers; 
        adjectives = RemoteAdjectiveService(); 
        verbs = RemoteVerbService(); 
        templates = ConstantTemplateService(); 
    };
    // TODO shuffle into a random order
    for (subject in !process.arguments.empty then process.arguments else ["Donald Trump", "Hillary Clinton"]) { 
        for (s in r.sentences(Subject(subject))) {
            print(s);
        }
    }
}