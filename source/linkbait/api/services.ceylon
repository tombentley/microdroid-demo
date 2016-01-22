// TODO these services aren't particularly interesting because
// they only return very simple objects
// to demonstrate serialization we should return more complex objects
// like Verbs and Nouns

"Generates random numbers"
shared interface NumberService {
    "A random number between min and max (inclusive)"
    shared formal Integer number(Integer min=1, Integer max=13);
}

"Generates random adjectives"
shared interface AdjectiveService {
    """Return an adjective, for qualifying a noun. For example "clever"."""
    shared formal String adjective(Boolean good);
    
    """Return an adverb, for qualifying a verb. For example "cleverly"."""
    shared formal String adverb(Boolean good);
}

"Generates random verbs"
shared interface VerbService {
    "A random verb with the given tense and aspect"
    shared formal String verb(Tense tense, Aspect aspect, Subject subject);
    
    """The gerund form of a random verb. For example, "eating" in the sentence
       "eating this cake".
       """
    shared formal String gerund();
    
    shared formal String infinitive();
}

"Enumerates tenses of verbs"
shared abstract class Tense() of present|past|future|future_past {}
shared object present extends Tense() {}
shared object past extends Tense() {}
shared object future extends Tense() {}
shared object future_past extends Tense() {}


"Enumerates aspects of verbs"
shared abstract class Aspect() of simple|continuous|perfect|perfect_continuous {}
shared object simple extends Aspect() {}
shared object continuous extends Aspect() {}
shared object perfect extends Aspect() {}
shared object perfect_continuous extends Aspect() {}

"Describes the subject of a sentence"
shared class Subject(String subject, plural=subject.endsWith("s")) {
    shared Boolean plural;
    shared actual String string=>subject;
}
"me"
shared object i extends Subject("I") {
}

"A service providing templates"
shared interface TemplateService {
    """Returns a sequence of linkbait templates, which will need to be filled in.
       
       For example
       
       > {num} reasons why {subject} sucks
       
       Parameters are enclosed by {}, and include
       
       * `{subject}` -- the subject of the sentence
       * `{subject2}` -- another subject
       * `{num}` -- a number
       * `{adjective}` -- an adjective
       * `{gerund}` -- a gerund (e.g. "working" in "How working...")
       * `{verb}` -- a verb in simple present tense (e.g. "works" in "Fred works...")
       * `{verb.TENSE.ASPECT}` --  a verb with the given `TENSE` and `ASPECT`.
       `TENSE` may be one of:
       * `present`
       * `past`
       * `future`
       * `future-past`
       * `*` (any random tense)
       
       `ASPECT` may be one of:
       * `simple`
       * `continuous`
       * `perfect`
       * `perfect-continuous`
       * `*` (any random aspect)
       * `future-time` -- a time in the future (e.g. "tomorrow")
       * `past-time` -- a time in the future (e.g. "yeserday")
       * `time-period` -- a time period (e.g. "day", "night", "week" etc)
       """
    shared formal String[] templates(Integer num=10);
}


