import Blindside

class InjectorProvider {
  class func injector() -> BSInjector & BSBinder {
    return Blindside.injector(withModules: [
      ControllersModule.init(),
      ServicesModule.init(),
      ClientsModule.init()
    ]) as! BSInjector & BSBinder
  } 
}
