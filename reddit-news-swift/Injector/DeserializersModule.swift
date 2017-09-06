import Blindside

class DeserializerModule: BSModule {
  func configure(_ binder: BSBinder) {
    binder.bind(ArticlesDeserializer.self) { args, injector in 
      return ArticlesDeserializer.init()
    }
  }
}
