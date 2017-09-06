import Foundation
import CBGPromise

protocol NetworkClient {
  func sendRequest(urlRequest: URLRequest) -> Future<NetworkResponse>
}