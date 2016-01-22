"Implementation of the [[module linkbait.api]]"
native("jvm") module linkbait.implementation "1.0.0" {
    shared import linkbait.api "1.0.0";
    import ceylon.collection "1.2.1";
    import java.base "7";//needed for random only
}

