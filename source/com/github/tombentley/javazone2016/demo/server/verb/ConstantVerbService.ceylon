import com.github.tombentley.javazone2016.demo.api {
    ...
}


// TODO adverbs

"Implementation of [[VerbService]] which has some hard-coded verbs"
class ConstantVerbService(NumberService numberService) satisfies VerbService {
    value vs = [
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
    },
    Verb{infinitive="get pregnant";
        gerund = "getting pregnant";
        simplePast="got pregnant";
    },
    Verb{infinitive="get sick";
        gerund = "getting sick";
        simplePast="got sick  ";
    }
    ];
    
    shared actual Verb randomVerb() {
        assert(exists result = vs[numberService.number(0, vs.size-1)]);
        return result;
    }
}