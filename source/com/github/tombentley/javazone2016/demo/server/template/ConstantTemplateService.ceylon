import com.github.tombentley.javazone2016.demo.api {
    TemplateService
}

"Implementation of [[TemplateService]] which has some hard-coded templates"
shared class ConstantRenderService()
        satisfies TemplateService {
    
    shared actual String[] templates(Integer num) => [
        "Why {subject} {verb.simple.present}",
        "Why {subject} {verb.simple.present} {num} times a {time-period}",
        "{num,min=3} reasons why {subject} {verb.simple.*}",
        "{num,min=3} reasons why {subject} {verb.simple.future-past} as president",
        "{num,min=3} reasons why {subject} {verb.simple.past} {adverb} {past-time}",
        "{num,min=3} reasons why {subject} {verb.simple.future} {adverb} {future-time}",
        "{num,min=3} {adjective} uses of/for {subject}",
        "{num,min=2} {adjective} facts about {subject}",
        "{num,min=2} reasons to be addicted to {subject}",
        "{num,min=2} ways {subject} is good/bad for your {gerund}",
        "The secret about {subject} that {subject2} doesn't want you to know about",// TODO depends on plurality of subject2
        "Study shows {subject} can make you richer",
        "{subject2} claims {subject} can make you sick",
        "Court decides {subject} can help you {infinitive}",
        "{num,min=2} ways investing in {subject} can make you a millionaire",
        "How {gerund} with {subject} makes you better at {gerund}",
        "How {gerund} with {subject} makes you fatter",
        "How {gerund} with {subject} makes you better in bed",
        "{num,min=2} things {subject2} has in common with {subject}",
        "I spent {num} {time-period} {gerund} with {subject} and this is what happened...",
        "Why {subject2} wants to stop {subject} from {gerund}",
        "{num} celebrities who {adverb} use {subject} to help them {infinitive}",
        "{subject2}: My {num} {time-period} love affair with {subject}"
    ];
    
    // learn to {verb} in less than {num} {time-period} with {subject}
    // is there a reason why {subject} wants to {verb}?
    // why we know {subject} isn't {gerrund} with {subject2}
    // Help! {subject2} is {gerrund} with {subject}
    // The next time someone claims {subject} is {adjective} show them this.
}