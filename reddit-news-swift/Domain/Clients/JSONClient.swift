import Foundation

class JSONClient: NSObject, NetworkClient {
  var urlSessionClient: NetworkClient

  init(urlSessionClient: NetworkClient) {
    self.urlSessionClient = urlSessionClient
    super.init()
  }

  func sendRequest(urlRequest: URLRequest) {
    self.urlSessionClient.sendRequest(urlRequest: urlRequest)
  }
}