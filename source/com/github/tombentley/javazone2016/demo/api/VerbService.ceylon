"Enumerates tenses of verbs"
shared abstract class Tense() 
        of present|past|future|future_past {}

shared object present extends Tense() {}
shared object past extends Tense() {}
shared object future extends Tense() {}
shared object future_past extends Tense() {}

shared Tense? parseTense(String tense) 
        => switch (tense) 
case ("present") present 
case ("past") past
case ("future") future
case ("future_past") future_past
else null;

"Enumerates aspects of verbs"
shared abstract class Aspect() 
        of simple|continuous|perfect|perfect_continuous {}
shared object simple extends Aspect() {}
shared object continuous extends Aspect() {}
shared object perfect extends Aspect() {}
shared object perfect_continuous extends Aspect() {}

shared Aspect? parseAspect(String aspect) 
        => switch (aspect) 
case ("simple") simple 
case ("continuous") continuous
case ("perfect") perfect
case ("parfect_continuous") perfect_continuous
else null;


"Models a verb"
serializable
shared class Verb(infinitive,
    gerund = infinitive+"ing",
    simplePresent = infinitive+"s",
    simplePast = infinitive+"ed",
    simpleFuture = "will " + infinitive,
    simpleFuturePast = "would " + infinitive,
    continuousPresent = "am/is/are "+gerund,
    continuousPast = "was/were " + gerund,
    continuousFuture = "will be " + infinitive, 
    continuousFuturePast = "would be " + infinitive,
    
    perfectPresent = "have/has "+simplePast,
    perfectPast = "had " + simplePast,
    perfectFuture = "will have " + simplePast,
    perfectFuturePast = "would have " + simplePast,
    
    perfectContinuousPresent = "have/has been "+gerund,
    perfectContinuousPast = "had been " + gerund,
    perfectContinuousFuture = "will have been " + gerund,
    perfectContinuousFuturePast = "would have been " + gerund) {
    
    shared String infinitive;
    
    shared String gerund;
    shared String simplePresent;
    shared String simplePast;
    shared String simpleFuture;
    shared String simpleFuturePast;
    shared String continuousPresent;
    shared String continuousPast;
    shared String continuousFuture; 
    shared String continuousFuturePast;
    
    shared String perfectPresent;
    shared String perfectPast;
    shared String perfectFuture;
    shared String perfectFuturePast;
    
    shared String perfectContinuousPresent;
    shared String perfectContinuousPast;
    shared String perfectContinuousFuture;
    shared String perfectContinuousFuturePast;
    
    "Apply this verb using the given tense, aspect and subject
     
     See https://en.wikipedia.org/wiki/Grammatical_tense#English"
    shared String apply(Tense tense, Aspect aspect) {
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


"Generates random verbs"
shared interface VerbService {
    "A random verb with the given tense and aspect"
    shared formal Verb randomVerb();
}