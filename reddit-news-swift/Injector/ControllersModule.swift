import Blindside

class ControllersModule: BSModule {
  func configure(_ binder: BSBinder) {
    binder.bind(ArticlesController.self) { args, injector in 
      return ArticlesController.init(
              fetchArticlesUseCase: injector.getInstance(FetchArticlesUseCase.self) as! FetchArticlesUseCaseProtocol
      )
    }
  }
}
