import com.github.tombentley.javazone2016.demo.api {
    NumberService,
    AdjectiveService
}

"Implementation of [[AdjectiveService]] which has some hard-coded adjectives.
 Uses the given [[NumberService]] to pick a random adjective from the ons available."
class ConstantAdjectiveService(NumberService numberService)
        satisfies AdjectiveService {
    
    "A sequence of (adjective,adverb) pairs"
    value a = [
        "dead"->"deadly", 
        "boring"->"boringly",
        "incredible"->"incredibly",
        "amazing"->"amazingly",
        "unusual"->"unusually",
        "disgusting"->"disgustingly",
        "awesome"->"awesomly",
        "awful"->"awfully",
        "hateful"->"hatefully",
        "suspicious"->"suspiciously",
        "secret"->"secretly",
        "strange"->"strangely",
        "beautiful"->"beautifully",
        "elegant"->"eleganty",
        "crazy"->"crazily",
        "blatant"->"blatantly",
        "smooth"->"smoothly",
        "dreadful"->"dreadfully",
        "amusing"->"amusingly",
        "disturbing"->"distubingly",
        "peculiar"->"peculiarly",
        "embarrassing"->"embarrassingly",
        "apologetic"->"apologetically",
        "unapologetic"->"unapologetically",
        "blatant"->"blatantly",
        "furtive"->"furtively",
        "shameful"->"shamefully",
        "graceful"->"gracefully",
        "illegal"->"illegally"
    ];
    
    shared actual String adjective() {
        assert(exists result = a[numberService.number(0, a.size-1)]);
        return result.key;
    }
    
    shared actual String adverb() {
        assert(exists result = a[numberService.number(0, a.size-1)]);
        return result.item;
    }
}