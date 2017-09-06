import Foundation

protocol NetworkClient {
  func sendRequest(urlRequest: URLRequest)
}