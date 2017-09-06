import Foundation
import CBGPromise

class JSONClient: NSObject, NetworkClient {
  var urlSessionClient: NetworkClient

  init(urlSessionClient: NetworkClient) {
    self.urlSessionClient = urlSessionClient
    super.init()
  }

  func sendRequest(urlRequest: URLRequest) -> Future<NetworkResponse> {
    return self.urlSessionClient.sendRequest(urlRequest: urlRequest)
  }
}