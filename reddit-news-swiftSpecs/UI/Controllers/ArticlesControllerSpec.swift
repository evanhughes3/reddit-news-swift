import UIKit
import Quick
import Nimble
import Blindside
@testable import reddit_news_swift

class ArticlesControllerSpec: QuickSpec {
  override func spec() {
    describe("ArticlesController") {
      var fetchArticlesUseCase: FetchArticlesUseCaseMock!
      var subject: ArticlesController!
      let articles = [Article(title: "Article 1", url: "www.google.com"),
                      Article(title: "Article 2", url: "www.example.com"),
                      Article(title: "Article 3", url: "www.website.com")]

      beforeEach {
        let injector = InjectorProvider.injector()
        
        fetchArticlesUseCase = FetchArticlesUseCaseMock()
        injector.bind(FetchArticlesUseCase.self, toInstance: fetchArticlesUseCase)

        subject = injector.getInstance(ArticlesController.self) as! ArticlesController
        subject.loadViewIfNeeded()
      }

      describe("loading the view") {
        it("should display the correct header title") {
          expect(subject.articlesHeaderLabel.text).to(equal("Articles"))
        }

        it("should fetch the articles") {
          expect(fetchArticlesUseCase.didCallFetchArticles).to(equal(true))
          expect(fetchArticlesUseCase.incomingObserver).to(beIdenticalTo(subject))
        }
        
        it("should set itself as a UITableViewDelegate and UITableViewDataSource") {
          expect(subject.articlesTableView.dataSource).to(beIdenticalTo(subject));
          expect(subject.articlesTableView.delegate).to(beIdenticalTo(subject));
        }
      }

      describe("as a <FetchArticlesUseCaseObserver>") {
        describe("-fetchArticlesUseCase(_, didFailWithError:)") {
          let title = "My Title"
          let description = "My special error description"
          let code = 404
          
          beforeEach {
            let error = NetworkError(localizedTitle: title, localizedDescription:description, code:code );
            subject.fetchArticlesUseCase(fetchArticlesUseCase, didFailWithError: error)
          }
          
          it("should show an alert popup") {
            expect(subject.presentedViewController).toNot(beNil());
            expect(subject.presentedViewController).to(beAnInstanceOf(UIAlertController))
          }
          
          it("should display the network error in the alert") {
            let alertController = subject.presentedViewController as! UIAlertController
            expect(alertController.title).to(equal(title));
            expect(alertController.message).to(equal(description));
            expect(alertController.preferredStyle).to(equal(UIAlertControllerStyle.alert));
            expect(alertController.actions.count).to(equal(1))
          }
          
          it("should add an action to dismiss the alert") {
            let alertController = subject.presentedViewController as! UIAlertController
            let alertAction = alertController.actions.first as! UIAlertAction
            expect(alertAction.title).to(equal("Ok"));
            expect(alertAction.style) == UIAlertActionStyle.cancel
          }
        }

        describe("-fetchArticlesUseCase(_:, didFetchArticles:)") {
          beforeEach {
            subject.fetchArticlesUseCase(fetchArticlesUseCase, didFetchArticles: articles)
          }
          
          it("should re-display table view") {
            expect(subject.articlesTableView.visibleCells.count).to(equal(3)) 
          }
        }
      }

      describe("as a <UITableViewDataSource>") {
        beforeEach {
          subject.fetchArticlesUseCase(fetchArticlesUseCase, didFetchArticles: articles)
        }

        describe("-tableView(_:, numberOfRowsInSection:") {
          var rows: Int!

          beforeEach {
            rows = subject.tableView(subject.articlesTableView, numberOfRowsInSection: 0)
          }

          it("should display the number of articles fetched") {
            expect(rows).to(equal(3));
          }
        }

        describe("-tableView(_:, cellForRowAtIndexPath:)") {
          var firstCell: UITableViewCell!

          beforeEach {
            firstCell = subject.tableView(subject.articlesTableView, cellForRowAt: IndexPath(row: 0, section: 0))
          }

          it("should set the text label to the article title") {
            expect(firstCell.textLabel?.text).to(equal("Article 1"));
          }

          it("should set the correct reuse identifier") {
            expect(firstCell.reuseIdentifier).to(equal(NSStringFromClass(UITableViewCell)))
          }
        }
      }
    }
  }
}