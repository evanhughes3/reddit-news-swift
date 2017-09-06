import Blindside

class ControllersModule: BSModule {
  func configure(_ binder: BSBinder) {
    binder.bind(ArticlesController.self) { args, injector in 
      return ArticlesController.init(
              articlesService: injector.getInstance(ArticlesService.self) as! ArticlesServiceProtocol
      )
    }
  }
}
