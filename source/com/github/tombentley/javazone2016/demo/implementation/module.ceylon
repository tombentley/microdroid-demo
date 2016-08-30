"Implementation of the [[module com.github.tombentley.javazone2016.demo.api]]"
native("jvm") module com.github.tombentley.javazone2016.demo.implementation "1.0.0" {
    shared import com.github.tombentley.javazone2016.demo.api "1.0.0";
    shared import com.github.tombentley.javazone2016.demo.client "1.0.0";
    import ceylon.collection "1.2.3";
    import ceylon.regex "1.2.3";
    
}

