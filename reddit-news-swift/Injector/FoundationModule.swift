import Foundation
import Blindside

class FoundationModule: BSModule {
  func configure(_ binder: BSBinder) {
    binder.bind(URL_SESSION_INJECTOR_KEY) { args, injector in
      return URLSession.shared
    }

    binder.bind(MAIN_QUEUE_INJECTOR_KEY) { args, injector in
      return OperationQueue.main
    }
  }
}