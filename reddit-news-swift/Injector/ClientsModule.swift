import Foundation

import Blindside

class ClientsModule: BSModule {
  func configure(_ binder: BSBinder) {
    binder.bind(DefaultJSONClient.self) { args, injector in
      return DefaultJSONClient.init()
    }
  }
}
