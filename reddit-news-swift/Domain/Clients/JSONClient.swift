import Foundation

protocol JSONClient {
  func sendRequest(url: URL)
}

class DefaultJSONClient: JSONClient {
  func sendRequest(url: URL) {
    
  }
}