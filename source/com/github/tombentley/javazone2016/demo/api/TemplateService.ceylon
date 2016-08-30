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