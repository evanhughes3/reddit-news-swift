import Foundation
import CBGPromise
import SwiftyJSON

protocol JSONClientProtocol {
  func sendRequest(urlRequest: URLRequest) -> Future<JSONResponse>
}

class JSONClient: NSObject, JSONClientProtocol {
  var urlSessionClient: URLSessionClientProtocol

  init(urlSessionClient: URLSessionClientProtocol) {
    self.urlSessionClient = urlSessionClient
    super.init()
  }

  func sendRequest(urlRequest: URLRequest) -> Future<JSONResponse> {
    let promise = Promise<JSONResponse>()
    
    let future = self.urlSessionClient.sendRequest(urlRequest: urlRequest)

    future.then { response in
      switch response {
        case .Success(let data):
          promise.resolve(.Success(JSON(data: data)))
        case .Error(let error):
          promise.resolve(.Error(error))
       }
     }
    
    return promise.future
  }
}