
import scala.concurrent.duration._

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import io.gatling.jdbc.Predef._

class RecordedSimulation extends Simulation {

	val httpProtocol = http
		.baseURL("http://web.service.consul:8080")
		.inferHtmlResources()
		.acceptHeader("""text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8""")
		.acceptEncodingHeader("""gzip,deflate,sdch""")
		.acceptLanguageHeader("""ja,en-US;q=0.8,en;q=0.6""")
		.userAgentHeader("""Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36""")

        val uri1 = """http://web.service.consul:8080/javaee-simple-tester"""
	val scn = scenario("RecordedSimulation")
                .repeat(10) {
		   exec(http("request_0").get("""/javaee-simple-tester/"""))
		   .pause(1)
		   .exec(http("request_1").get("""/javaee-simple-tester/resources/accounts"""))
                }
	setUp(scn.inject(atOnceUsers(1))).protocols(httpProtocol)
}
