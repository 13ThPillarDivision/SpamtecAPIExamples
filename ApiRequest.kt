//Save the script as ApiRequest.kt and compile it using the following command:
//kotlinc ApiRequest.kt -include-runtime -d ApiRequest.jar
//java -jar ApiRequest.jar

import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL

fun main() {
    print("Enter your input: ")
    val userInput = readLine()

    val apiURL = "https://endpoint.spamtec.cc/v1/tool?key=key&input=$userInput"
    val url = URL(apiURL)
    val connection = url.openConnection() as HttpURLConnection

    try {
        connection.requestMethod = "GET"
        val inputStream = BufferedReader(InputStreamReader(connection.inputStream))
        val response = inputStream.readText()
        inputStream.close()

        println("API response:")
        println(response)
    } catch (e: Exception) {
        println("Error making API request: $e")
    } finally {
        connection.disconnect()
    }
}
