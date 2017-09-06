import Blindside

class DeserializerModule: BSModule {
  func configure(_ binder: BSBinder) {
    binder.bind(ArticleDeserializer.self) { args, injector in 
      return ArticleDeserializer.init()
    }
  }
}
