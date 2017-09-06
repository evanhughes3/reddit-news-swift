import Foundation
import CBGPromise

class URLSessionClient: NSObject, NetworkClient {
  var urlSession: URLSession
  
  init(urlSession: URLSession) {
    self.urlSession = urlSession
    super.init()
  }

  func sendRequest(urlRequest: URLRequest) -> Future<NetworkResponse> {
    let promise = Promise<NetworkResponse>()
    
    let dataTask = self.urlSession.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) -> Void in 
      if let error = error {
        promise.resolve(.Error(error as! NetworkError))
      }
      
      if let data = data {
        promise.resolve(.Success(data))
      }
     }

    dataTask.resume()

    return promise.future
  }
}