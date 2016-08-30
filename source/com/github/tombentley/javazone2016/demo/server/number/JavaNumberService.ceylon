import com.github.tombentley.javazone2016.demo.api {
    NumberService
}
import java.util {
    JRandom=Random
}

"Implementation of [[NumberService]] which uses `java.util::Random`."
class JavaNumberService(Integer num=8)
        satisfies NumberService {
    
    value random = JRandom();
    
    shared actual Integer number(Integer min, Integer max) {
        return min+random.nextInt(max-min+1);
    }
}

