import Foundation

protocol JSONClient {
  func sendRequest(url: URL)
}

class DefaultJSONClient: NSObject, JSONClient {
  func sendRequest(url: URL) {
    
  }
}