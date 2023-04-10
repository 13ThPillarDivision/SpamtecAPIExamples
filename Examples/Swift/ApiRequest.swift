import Foundation

print("Enter your input: ", terminator: "")
guard let userInput = readLine() else {
    print("Error reading input.")
    exit(1)
}

let urlString = "https://api.example.com/endpoint?input=\(userInput.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
guard let url = URL(string: urlString) else {
    print("Invalid URL.")
    exit(1)
}

let semaphore = DispatchSemaphore(value: 0)

let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let data = data {
        if let responseString = String(data: data, encoding: .utf8) {
            print("API response:\n\(responseString)")
        } else {
            print("Unable to convert data to text.")
        }
    } else if let error = error {
        print("Error making API request: \(error.localizedDescription)")
    }

    semaphore.signal()
}

task.resume()
semaphore.wait()
