import Foundation

import Blindside

class ClientsModule: BSModule {
  func configure(_ binder: BSBinder) {
    binder.bind(JSONClient.self) { args, injector in
      return JSONClient.init(
              urlSessionClient: injector.getInstance(URLSessionClient.self) as! NetworkClient
      )
    }

    binder.bind(URLSessionClient.self) { args, injector in
      return URLSessionClient.init(
              urlSession: injector.getInstance(URL_SESSION_INJECTOR_KEY) as! URLSession
      )
    }

    binder.bind(URL_SESSION_INJECTOR_KEY) { args, injector in
      return URLSession.shared
    }
  }
}
