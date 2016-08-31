"Run the module `com.github.tombentley.javazone2016.demo.server.verb`."
shared void run() {
    print("running verb service");
    HttpVerbService();
    // Now block until the process gets killed
    while (true) {
        process.readLine();
    }
}