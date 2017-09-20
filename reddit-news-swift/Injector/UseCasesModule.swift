import Foundation
import Blindside

class UseCasesModule: BSModule {
  func configure(_ binder: BSBinder) {
    binder.bind(FetchArticlesUseCase.self) { args, injector in
      return FetchArticlesUseCase.init(
              articlesService: injector.getInstance(ArticlesService.self) as! ArticlesServiceProtocol
      )
    }
  }
}
