"Services exposing the [[module linkbait.api]]
 over HTTP using various things..."
native("jvm") module linkbait.server "1.0.0" {
    shared import linkbait.api "1.0.0";
    shared import linkbait.implementation "1.0.0";
    
    // we'll expose the number service using ceylon.net
    import ceylon.net "1.2.1";
    
    // TODO expose the adjective service using vertex
    
    // TODO expose the verb service using openshift
}
