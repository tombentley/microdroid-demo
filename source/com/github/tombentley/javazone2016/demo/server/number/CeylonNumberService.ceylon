import ceylon.random {
    DefaultRandom
}
import com.github.tombentley.javazone2016.demo.api {
    NumberService
}

"An implementation of [[NumberService]] that uses [[DefaultRandom]]."
class CeylonNumberService(Integer num=8)
        satisfies NumberService {
    
    value random = DefaultRandom();
    
    shared actual Integer number(Integer min, Integer max) {
        return min + random.nextInteger(max);
    }
}