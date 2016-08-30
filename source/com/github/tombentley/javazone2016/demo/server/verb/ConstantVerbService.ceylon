import com.github.tombentley.javazone2016.demo.api {
    ...
}


// TODO adverbs

"Implementation of [[VerbService]] which has some hard-coded verbs"
class ConstantVerbService(NumberService ns) satisfies VerbService {
    
    "Models a verb"
    shared class Verb(shared String base) {
        shared default String infinitive=>base; 
        shared default String gerund => base+"ing";
        
        shared default String simplePresent => base+"s";
        shared default String simplePast => base+"ed";
        shared default String simpleFuture => "will " + base;
        shared default String simpleFuturePast => "would " + base;
        
        shared default String continuousPresent => "am/is/are "+gerund;
        shared default String continuousPast => "was/were " + gerund;
        shared default String continuousFuture => "will be " + base;
        shared default String continuousFuturePast => "would be " + base;
        
        shared default String perfectPresent => "have/has "+simplePast;
        shared default String perfectPast => "had " + simplePast;
        shared default String perfectFuture => "will have " + simplePast;
        shared default String perfectFuturePast => "would have " + simplePast;
        
        shared default String perfectContinuousPresent => "have/has been "+gerund;
        shared default String perfectContinuousPast => "had been " + gerund;
        shared default String perfectContinuousFuture => "will have been " + gerund;
        shared default String perfectContinuousFuturePast => "would have been " + gerund;
        
        "Apply this tempply using the given tense, aspect and subject
         
         See https://en.wikipedia.org/wiki/Grammatical_tense#English"
        shared String apply(Tense tense, Aspect aspect, Subject subject) {
            switch (aspect)
            case (simple) {
                return switch (tense)
                case (present) simplePresent 
                case (past) simplePast
                case (future) simpleFuture
                case (future_past) simpleFuturePast;
            }
            case (continuous) {
                return switch (tense)
                case (present) continuousPresent
                case (past) continuousPast
                case (future) continuousFuture
                case (future_past) continuousFuturePast;
            }
            case (perfect) {
                return switch (tense)
                case (present) perfectPresent
                case (past) perfectPast
                case (future) perfectFuture
                case (future_past) perfectFuturePast;
            }
            case (perfect_continuous) {
                return switch (tense)
                case (present) perfectContinuousPresent
                case (past) perfectContinuousPast
                case (future) perfectContinuousFuture
                case (future_past) perfectContinuousFuturePast;
            }
            
        }
    }    
    value vs = [
        Verb("suck"), 
        Verb("rock"), 
        Verb("kill"), 
        object extends Verb("win") {
            gerund = "winning";
            simplePast="won";
        },
        object extends Verb("lose") {
            gerund = "losing";
            simplePast="lost";
        },
        Verb("work"), 
        object extends Verb("sleep") {
            simplePast="slept"; 
        },
        object extends Verb("eat") {
            simplePast="ate";
        },
        object extends Verb("drink") {
            simplePast="drank";
        },
        object extends Verb("run") {
            gerund = "running";
            simplePast="ran";
        },
        Verb("walk"),
        object extends Verb("swim") {
            gerund = "swimming";
            simplePast="swam";
        },
        object extends Verb("program") {
            gerund = "programming";
        },
        object extends Verb("code") {
            gerund = "coding";
        },
        object extends Verb("lose weight") {
            gerund = "losing weight";
            simplePast="lost weight";
        },
        object extends Verb("get pregnant") {
            gerund = "getting pregnant";
            simplePast="got pregnant";
        },
        object extends Verb("get sick") {
            gerund = "getting sick";
            simplePast="got sick  ";
        }
    ];
    
    shared actual String verb(Tense tense, Aspect aspect, Subject subject) {
        assert(exists result = vs[ns.number(0, vs.size-1)]);
        return result.apply(tense, aspect, subject);
    }
    
    shared actual String gerund() {
        assert(exists result = vs[ns.number(0, vs.size-1)]);
        return result.gerund;
    }
    
    shared actual String infinitive() {
        assert(exists result = vs[ns.number(0, vs.size-1)]);
        return result.infinitive;
    }
}
