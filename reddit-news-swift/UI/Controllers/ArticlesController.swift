import UIKit

class ArticlesController: UIViewController, FetchArticlesUseCaseObserver, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var articlesHeaderLabel: UILabel!
  @IBOutlet weak var articlesTableView: UITableView!

  let fetchArticlesUseCase: FetchArticlesUseCaseProtocol
  var articles: [Article]?

  public init(fetchArticlesUseCase: FetchArticlesUseCaseProtocol) {
    self.fetchArticlesUseCase = fetchArticlesUseCase;
    articles = nil;

    super.init(nibName: "ArticlesController", bundle: nil)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.articlesTableView.delegate = self;
    self.articlesTableView.dataSource = self;
    
    self.articlesTableView.register(UITableViewCell, forCellReuseIdentifier: NSStringFromClass(UITableViewCell))
    
    self.fetchArticlesUseCase.fetchArticlesWithObserver(self);
  }
  
  // MARK <FetchArticlesUseCaseObserver>

  func fetchArticlesUseCase(_ fetchArticlesUseCase: FetchArticlesUseCaseProtocol, didFetchArticles articles: [Article]) {
    self.articles = articles;

    self.articlesTableView.reloadData()
  }

  func fetchArticlesUseCase(_ fetchArticlesUseCase: FetchArticlesUseCaseProtocol, didFailWithError error: NetworkError) {
    let alertController = UIAlertController(
            title: error.localizedTitle, 
            message: error.localizedDescription, 
            preferredStyle: UIAlertControllerStyle.alert
    )
    
    let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel)
    alertController.addAction(cancelAction)
    
    self.present(alertController, animated: true, completion: nil)
  }

  // MARK: <UITableViewDataSource>
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let articles = self.articles {
      return articles.count;
    }
    return 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell), for: indexPath) as? UITableViewCell  else {
      fatalError("The dequeued cell is not an instance of UITableViewCell.")
    }
    
    let article = self.articles?[indexPath.row]
    cell.textLabel?.text = article?.title

    return cell;
  }
}
