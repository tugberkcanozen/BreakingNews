//
//  ViewController.swift
//  serviceManagerTest
//
//  Created by Tuğberk Can Özen on 28.06.2022.
//

import UIKit.UIViewController
import SnapKit
import Lottie

// MARK: - Protocols
protocol ArticleOutPut {
    func selectedArticles(article: Article)
}

final class ArticleHomeController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var searchController: UISearchController = {
        let search = UISearchController()
        return search
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - Properties
    var viewModel: ArticleViewModelProtocol
    private let newsAnimationView = AnimationView()
    
    init(viewModel: ArticleViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let _ = Timer.scheduledTimer(timeInterval: 1.8, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disableHero()
    }
}

// MARK: - ArticleHomeController Extensions
extension ArticleHomeController {
    
    func configure() {
        drawDesign()
        makeTableView()
        fetchData()
        configureSearchController()
        setUpAnimation()
        makeAnimation()
    }
    
    func drawDesign() {
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.Idetenfier.custom.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(newsAnimationView)
        view.backgroundColor = .systemBackground
        title = "NEWS"
    }
}

// MARK: - TableView Extensions
extension ArticleHomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        230
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.isSearch ? viewModel.searchData.count : viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.Idetenfier.custom.rawValue) as? ArticleTableViewCell else { return  UITableViewCell() }
        
        viewModel.isSearch ? cell.saveModel(model: viewModel.searchData[indexPath.row])
        : cell.saveModel(model: viewModel.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if viewModel.isSearch {
            selectedArticles(article: viewModel.searchData[indexPath.row])
        } else {
            selectedArticles(article: viewModel.articles[indexPath.row])
        }
    }
}

// MARK: - Constraints Extensions
extension ArticleHomeController {
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(view.snp.top).inset(350)
        }
    }
    
    private func makeAnimation() {
        newsAnimationView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    func reMakeTableView() {
        tableView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Service Extension
private extension ArticleHomeController {
    private func fetchData() {
        viewModel.fetchArticles { [weak self] data in
            guard let data = data?.articles else { return }
            self?.viewModel.articles = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        } onError: { error in
            print(error)
        }
    }
}

// MARK: - SearchBar Extension
extension ArticleHomeController: UISearchControllerDelegate, UISearchResultsUpdating {
    private func configureSearchController() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchControllerUI()
        navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.searchedTitle(searchText: searchText)
        if searchText.count > 2 {
            viewModel.isSearch = true && viewModel.searchData.isEmpty == false
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }else {
            viewModel.isSearch = false
            tableView.reloadData()
        }
    }
}

// MARK: - Lottie Animation Extension
private extension ArticleHomeController {
    func setUpAnimation() {
        newsAnimationView.animation = Animation.named("breakingnews")
        newsAnimationView.backgroundColor = .clear
        newsAnimationView.contentMode = .scaleAspectFit
        newsAnimationView.loopMode = .playOnce
        newsAnimationView.play()
    }
    
    @objc func fireTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.newsAnimationView.isHidden = true
            self.reMakeTableView()
        }
    }
}

// MARK: - Selected Article & Output Extension
extension ArticleHomeController: ArticleOutPut {
    func selectedArticles(article: Article) {
        ///        navigationController?.pushViewController(ArticleDetailController(article: article), animated: true)
        showHero(ArticleDetailController(article: article))
    }
}
