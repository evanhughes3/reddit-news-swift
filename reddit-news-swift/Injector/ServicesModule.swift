import Foundation
import Blindside

class ServicesModule: BSModule {
  func configure(_ binder: BSBinder) {
    binder.bind(ArticlesService.self) { args, injector in
      return ArticlesService.init(
              jsonClient: injector.getInstance(JSONClient.self) as! NetworkClient
      )
    }
  }
}
