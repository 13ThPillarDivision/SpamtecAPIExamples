// scalac ApiRequest.scala
// scala ApiRequest
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL

object ApiRequest extends App {
  print("Enter your input: ")
  val userInput = scala.io.StdIn.readLine()

  try {
    val urlString = s"https://endpoint.spamtec.cc/v1/tool?key=key&input=${java.net.URLEncoder.encode(userInput, "UTF-8")}"
    val url = new URL(urlString)
    val connection = url.openConnection().asInstanceOf[HttpURLConnection]
    connection.setRequestMethod("GET")

    val responseCode = connection.getResponseCode()
    if (responseCode == HttpURLConnection.HTTP_OK) {
      val reader = new BufferedReader(new InputStreamReader(connection.getInputStream))
      val response = new StringBuilder
      var line: String = null
      while ({line = reader.readLine(); line != null}) {
        response.append(line)
      }
      reader.close()

      println(s"API response: $response")
    } else {
      println(s"Error making API request: $responseCode")
    }
    connection.disconnect()
  } catch {
    case e: Exception => println(s"Error: ${e.getMessage}")
  }
}
