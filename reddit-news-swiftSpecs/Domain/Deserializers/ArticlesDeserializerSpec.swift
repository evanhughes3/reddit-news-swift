import UIKit
import Quick
import Nimble
import Blindside
import SwiftyJSON
@testable import reddit_news_swift

class ArticlesDeserializerSpec: QuickSpec {
  override func spec() {
    describe("ArticlesDeserializerSpec") {
      var subject: ArticlesDeserializer!

      beforeEach {
        let injector = InjectorProvider.injector()
        
        subject = injector.getInstance(ArticlesDeserializer.self) as! ArticlesDeserializer
      }

      describe("-deserializeArticles") {
        var articles: [Article]!
        var data: Data!
        var json: JSON!
        
        beforeEach {
          if let path = Bundle(for: type(of: self)).path(forResource: "fetch_articles_response", ofType: "json") {
            do {
              let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
              json = JSON(data: data)
              if json != JSON.null {
                print("Got JSON from fetch_articles_response")
              } else {
                print("Could not get json from file, make sure that file contains valid json.")
              }
            } catch let error {
              print(error.localizedDescription)
            }
          } else {
            print("Invalid filename/path.")
          }
          
          articles = subject.deserializeArticles(response: json)
        }

        it("should deserialize") {
          expect(articles.count).to(equal(6));
          
          let article = articles[0];
          expect(article.title).to(equal("Red Cross Exec Doesn't Know What Portion Of Donations Go To Harvey Relief"))
          expect(article.url).to(equal("http://www.npr.org/sections/thetwo-way/2017/08/30/547435136/red-cross-exec-doesn-t-know-what-portion-of-donations-will-go-directly-to-harvey?utm_source=facebook.com&amp;utm_medium=social&amp;utm_campaign=npr&amp;utm_term=nprnews&amp;utm_content=20170831"))
        }
      }
    }
  }
}