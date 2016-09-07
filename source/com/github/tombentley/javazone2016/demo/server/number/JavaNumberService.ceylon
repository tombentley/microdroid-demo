import com.github.tombentley.javazone2016.demo.api {
    NumberService
}
import java.util {
    Random
}

"Implementation of [[NumberService]] which uses `java.util::Random`."
class JavaNumberService()
        satisfies NumberService {
    
    value random = Random();
    
    shared actual Integer number(Integer min, Integer max) {
        return min+random.nextInt(max-min+1);
    }
}

