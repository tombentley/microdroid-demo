import java.util {
    Random
}
import ceylon.collection {
    ArrayList
}
import linkbait.api {
    ...
}

"Implementation of [[NumberService]] which uses `java.util::Random`."
shared class ConstantNumberService(Integer num=8)
        satisfies NumberService {
    
    value random = Random();
    
    shared actual Integer number(Integer min, Integer max) {
        return min+random.nextInt(max-min+1);
    }
}

"Implementation of [[AdjectiveService]] which has some hard-coded adjectives"
shared class ConstantAdjectiveService(NumberService n = ConstantNumberService())
        satisfies AdjectiveService {
    
    value a = ["dead"->"deadly", 
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
    "smooth"->"smoothly"
    ];
    
    shared actual String adjective(Boolean good) {
        assert(exists result = a[n.number(0, a.size-1)]);
        return result.key;
    }
    
    shared actual String adverb(Boolean good) {
        assert(exists result = a[n.number(0, a.size-1)]);
        return result.item;
    }
}

// TODO adverbs

"Implementation of [[TemplateService]] which has some hard-coded templates"
shared class ConstantTemplateService() 
        satisfies TemplateService {
    
    shared actual String[] templates(Integer num) =>
            [
    "Why {subject} {verb.simple.present}",
    "Why {subject} {verb.simple.present} {num} times a {time-period}",
    "{num} reasons why {subject} {verb.simple.*}",
    "{num} reasons why {subject} {verb.simple.future-past} as president",
    "{num} reasons why {subject} {verb.simple.past} {adverb} {past-time}",
    "{num} reasons why {subject} {verb.simple.future} {adverb} {future-time}",
    "{num} {adjective} uses of/for {subject}",
    "{num} {adjective} facts about {subject}",
    "{num} reasons to be addicted to {subject}",
    "{num} ways {subject} is good/bad for your {gerund}",
    "The secret about {subject} that {subject2} doesn't want you to know about",// TODO depends on plurality of subject2
    "Study shows {subject} can make you richer",
    "{subject2} claims {subject} can make you sick",
    "Court decides {subject} can help you lose weight",
    "{num} ways investing in {subject} can make you a millionaire",
    "How {gerund} with {subject} makes you better at {gerund}",
    "How {gerund} with {subject} makes you fatter",
    "How {gerund} with {subject} makes you better in bed",
    "{num} things {subject2} has in common with {subject}",
    "I spent {num} {time-period} {gerund} with {subject} and this is what happened...",
    "Why {subject2} wants to stop {subject} from {gerund}",
    "{num} celebriies who {adverb} use {subject} to help them {infinitive}"];
    
    // learn to {verb} in less than {num} {time-period} with {subject}
    // is there a reason why {subject} wants to {verb}?
    // why we know {subject} isn't {gerrund} with {subject2}
    // Help! {subject2} is {gerrund} with {subject}
    // The next time someone claims {subject} is {adjective} show them this.
}

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

"Implementation of [[VerbService]] which has some hard-coded verbs"
shared class ConstantVerbService(NumberService ns = ConstantNumberService()) satisfies VerbService {
    
    Verb("do");
    Verb("want");
    Verb("make");
    
    value vs = [Verb("suck"), 
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
            result = adjectives.adjective(true);
        }
        case ("adverb") {
            result = adjectives.adverb(true);
        }
        case ("verb") {
            result = verbs.verb(past, simple, subject);
        }
        case ("gerund") {
            result = verbs.gerund();
        }
        case ("infinitive") {
            result = verbs.infinitive();
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
                "Lady Gaga", "Bill Clinton", "Benedict Cumberbatch", "Justin Beiber",
                "the government", "the NSA", "the cops", 
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
                result = verbs.verb(tense, aspect, subject);
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

shared void run() {
    Renderer r = Renderer(ConstantNumberService(), ConstantAdjectiveService(), ConstantVerbService(), ConstantTemplateService());
    // TODO shuffle into a random order
    for (s in r.sentences(Subject("Will Smith"))) {
        print(s);
    }
}