"Generates random numbers"
shared interface NumberService {
    "A random number between min and max (inclusive)"
    shared formal Integer number(Integer min=1, Integer max=13);
}