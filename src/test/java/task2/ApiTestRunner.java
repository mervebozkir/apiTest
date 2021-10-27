package task2;

import com.intuit.karate.junit5.Karate;

class ApiTestRunner {

    @Karate.Test
    Karate testSample() {
        return Karate.run("reqRes").relativeTo(getClass());
    }

    @Karate.Test
    Karate testTags() {
        return Karate.run("reqRes").tags("@test").relativeTo(getClass());
    }
}