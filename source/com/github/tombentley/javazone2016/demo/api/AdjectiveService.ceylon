"Generates random adjectives"
shared interface AdjectiveService {
    "Return an adjective, for qualifying a noun. For example 'clever'."
    shared formal String adjective();
    
    "Return an adverb, for qualifying a verb. For example 'cleverly'."
    shared formal String adverb();
}