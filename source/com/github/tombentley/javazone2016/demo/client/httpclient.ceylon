import ceylon.http.client {
    ...
}

import com.github.tombentley.javazone2016.demo.api {
    ...
}

shared class RemoteVerbService(String url="http://localhost:8080/verbs/?good=true") 
        satisfies VerbService {

            shared actual Verb randomVerb() => nothing;
            
}

class RestfulTemplateService(String url="http://localhost:8080/templates/template") 
        satisfies TemplateService {
    shared actual String[] templates(Integer num) => nothing;
}