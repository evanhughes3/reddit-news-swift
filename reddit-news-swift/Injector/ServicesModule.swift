import Foundation
import Blindside

class ServicesModule: BSModule {
  func configure(_ binder: BSBinder) {
    binder.bind(DefaultArticlesService.self) { args, injector in
      return DefaultArticlesService.init(
              jsonClient: injector.getInstance(DefaultJSONClient.self) as! JSONClient
      )
    }
  }
}
