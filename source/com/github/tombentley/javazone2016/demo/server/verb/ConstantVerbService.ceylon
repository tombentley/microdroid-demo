import com.github.tombentley.javazone2016.demo.api {
    ...
}

"Implementation of [[VerbService]] which has some hard-coded verbs"
class ConstantVerbService(NumberService numberService) 
        satisfies VerbService {
    value verbs = [
        Verb("suck"), 
        Verb("rock"), 
        Verb("kill"), 
        Verb{infinitive="win";
            gerund = "winning";
            simplePast="won";
        },
        Verb{infinitive="lose";
            gerund = "losing";
            simplePast="lost";
        },
        Verb("work"), 
        Verb{infinitive="sleep";
            simplePast="slept"; 
        },
        Verb{infinitive="eat";
            simplePast="ate";
        },
        Verb{infinitive="drink";
            simplePast="drank";
        },
        Verb{infinitive="run";
            gerund = "running";
            simplePast="ran";
        },
        Verb("walk"),
        Verb{infinitive="swim";
            gerund = "swimming";
            simplePast="swam";
        },
        Verb{infinitive="program";
            gerund = "programming";
        },
        Verb{infinitive="code";
            gerund = "coding";
        },
        Verb{infinitive="lose weight";
            gerund = "losing weight";
            simplePast="lost weight";
            simplePresent="loses weight";
        },
        Verb{infinitive="get pregnant";
            gerund = "getting pregnant";
            simplePast="got pregnant";
            simplePresent="gets pregnant";
        },
        Verb{infinitive="get sick";
            gerund = "getting sick";
            simplePast="got sick";
            simplePresent="gets sick";
        }
    ];
    
    shared actual Verb randomVerb() {
        assert(exists result = verbs[numberService.number(0, verbs.size-1)]);
        return result;
    }
}