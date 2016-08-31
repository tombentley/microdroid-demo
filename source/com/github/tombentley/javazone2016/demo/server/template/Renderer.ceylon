import com.github.tombentley.javazone2016.demo.api {
    TemplateService,
    continuous,
    simple,
    Tense,
    NumberService,
    present,
    future_past,
    Aspect,
    AdjectiveService,
    perfect,
    perfect_continuous,
    past,
    VerbService,
    future,
    Subject
}
import ceylon.regex {
    regex
}
import ceylon.collection {
    ArrayList
}



"Using the given services, renders the templates"
shared class Renderer(NumberService numbers,
    AdjectiveService adjectives,
    VerbService verbs,
    TemplateService templates) {
    
    // TODO hook up the subjects to wikidata so we know when a subject is a person
    // or a company etc.
    
    "Parses a tense descriptor into a [[Tense]]"
    Tense parseTenseDescriptor(String descriptor) {
        switch(descriptor.lowercased)
        case ("present") {
            return present;
        }
        case ("past") {
            return past;
        }
        case ("future") {
            return future;
        }
        case ("future_past"|"future-past"|"future past") {
            return future_past;
        }
        case("*") {
            return present;// TODO pick a random one
        } else {
            throw Exception(descriptor);
        }
    }
    
    "Parses an aspect descriptor into an [[Aspect]]"
    Aspect parseAspectDescriptor(String descriptor) {
        switch(descriptor.lowercased)
        case ("simple") {
            return simple;
        }
        case ("continuous") {
            return continuous;
        }
        case ("perfect") {
            return perfect;
        }
        case ("perfect_continuous"|"perfect-continuous"|"perfect continuous") {
            return perfect_continuous;
        }
        case("*") {
            return simple;// TODO pick a random one
        } else {
            throw Exception(descriptor);
        }
    }
    
    "Pick a random element from the given strings"
    function pickFrom(String+ x) {
        assert(exists r = x[numbers.number(0, x.size-1)]);
        return r;
    }
    
    "Get the givne token's replacement, applicable to the given subject"
    function replacement(String token, Subject subject) {
        String result;
        switch (token)
        case ("subject") {
            result = subject.string;
        } 
        case ("num") {
            result = numbers.number().string;
        }
        case ("adjective") {
            result = adjectives.adjective();
        }
        case ("adverb") {
            result = adjectives.adverb();
        }
        case ("verb") {
            result = verbs.randomVerb().apply(past, simple);
        }
        case ("gerund") {
            result = verbs.randomVerb().gerund;
        }
        case ("infinitive") {
            result = verbs.randomVerb().infinitive;
        }
        case ("future-time") {
            result = pickFrom("tonight", "tomorrow", "next week", "next year");
        }
        case ("past-time") {
            result = pickFrom("last night", "yesterday", "last week", "last year");
        }
        case ("time-period") {
            // TODO handle plurals (1 day, 2 days)
            result = pickFrom("hour", "day", "night", "year");
        }
        case ("subject2") {
            result = pickFrom(
                "Lady Gaga", "Beylonce", "Taylor Swift", 
                "Bill Clinton", "Hillary Clinton", "Donald Trump",
                "Angela Merkel", "Jean-Claude Junker",
                "Hollande", "Theresa May",
                "The Queen", "Prince Charles", "Prince William", "Prince George",
                "Prince Harry",
                "Benedict Cumberbatch", "Justin Beiber", 
                "the government", "the NSA", "GCHQ", "the cops", 
                "your wife", "your husband", "your mum", "your boss");
        }
        else {
            if (token.startsWith("verb.")) {
                value descriptors = token.split((ch) => ch== '.').sequence();
                Aspect aspect;
                if (exists aspectDescriptor=descriptors[1]) {
                    aspect = parseAspectDescriptor(aspectDescriptor);
                } else {
                    aspect = simple;
                }
                Tense tense;
                if (exists tenseDescriptor=descriptors[2]) {
                    tense = parseTenseDescriptor(tenseDescriptor);
                } else {
                    tense = present;
                }
                result = verbs.randomVerb().apply(tense, aspect);
            } else if (token.startsWith("num,")) {
                assert(exists min = parseInteger(regex("min=([0-9+])").find(token)?.groups?.get(1) else "1"));
                assert(exists max = parseInteger(regex("max=([0-9+])").find(token)?.groups?.get(1) else "13"));
                result = numbers.number{min=min;max=max;}.string;
            } else {
                throw Exception("Unsupported parameter {``token``}");
            }
        }
        return result;
    }
    
    "Fill in the given template for the given subject"
    function fillIn(String template, Subject subject) {
        value result = StringBuilder();
        variable value ii = 0;
        while (ii < template.size) {
            assert(exists ch = template[ii]);
            if (ch == '{') {
                // start of a token, read until }
                value start = ii;
                variable String? token = null;
                while (exists ch2=template[ii]) {
                    if (ch2 == '}') {
                        token = template[start+1:(ii-(start+1))];
                        break;
                    }
                    ii++;
                }
                if (exists t=token) {
                    result.append(replacement(t, subject));
                }
            } else {
                result.appendCharacter(ch);
            }
            ii++;
        }
        return result.string;
    }
    
    "Return a bunch of sentences for the given subject"
    shared String[] sentences(Subject subject) {
        String[] templates = this.templates.templates();
        value result = ArrayList<String>(templates.size);
        for (template in templates) {
            // s is a template like "why {subject} {verb.simple.present}"
            // I need to tokenize s to figure out what parameters I need to fill
            result.add(fillIn(template, subject));
        }
        return result.sequence();
    }
}