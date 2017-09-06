import Foundation
import CBGPromise

protocol URLSessionClientProtocol {
  func sendRequest(urlRequest: URLRequest) -> Future<NetworkResponse>
}

class URLSessionClient: NSObject, URLSessionClientProtocol {
  var urlSession: URLSession
  var queue: OperationQueue
  
  init(urlSession: URLSession, queue: OperationQueue) {
    self.urlSession = urlSession
    self.queue = queue
    super.init()
  }

  func sendRequest(urlRequest: URLRequest) -> Future<NetworkResponse> {
    let promise = Promise<NetworkResponse>()

    let dataTask = self.urlSession.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) -> Void in 
      if let error = error {
        self.queue.addOperation {
          promise.resolve(.Error(error as! NetworkError))
        }
        
        return
      }

      if let data = data {
        self.queue.addOperation {
          promise.resolve(.Success(data))
        }
        
        return
      }

      let unknownError = NetworkError(localizedTitle: "Error", localizedDescription: "Something went wrong :(, try again later", code: 500)
      self.queue.addOperation {
        promise.resolve(.Error(unknownError))
      }
     }

    dataTask.resume()

    return promise.future
  }
}