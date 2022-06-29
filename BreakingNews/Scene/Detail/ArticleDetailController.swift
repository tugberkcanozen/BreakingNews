//
//  ArticleDetailController.swift
//  BreakingNews
//
//  Created by Tuğberk Can Özen on 28.06.2022.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire
import SparkUI
import Layoutless
import Hero

final class ArticleDetailController: UIViewController {
    
    // MARK: - UI Elements
    private let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.detailImageView()
        return imageView
    }()
    
    private let detailTitle: UILabel = {
        let label = UILabel()
        label.detailTitle()
        return label
    }()
    
    private let detailOverView: UILabel = {
        let label = UILabel()
        label.detailOverView()
        return label
    }()
    
    private let detailButton: UIButton = {
        let button = UIButton()
        button.detailButton()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Model & Initilazers
    private let articles: Article
    
    init(article: Article) {
        self.articles = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(share(sender:)))
    }

    override func viewWillAppear(_ animated: Bool) {
        enableHero()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableHero()
    }
}
// MARK: - ArticleDetailController Extensions
private extension ArticleDetailController {
    private func configure() {
        addSubviews()
        makeDetailImage()
        makeTitleLabel()
        makeOverViewLabel()
        makeDetailButton()
        setUpUI()
    }
    
    private func addSubviews() {
        view.addSubview(detailImageView)
        view.addSubview(detailTitle)
        view.addSubview(detailOverView)
        view.addSubview(detailButton)
    }
}

// MARK: - SetUpUI Extensions
private extension ArticleDetailController {
    private func setUpUI() {
        detailTitle.text = articles.title
        detailOverView.text = articles.content
        detailImageView.kf.setImage(with: URL(string: articles.urlToImage!))
    }
}

// MARK: - ObjcFunc Extensions
private extension ArticleDetailController {
    @objc func buttonTapped() {
        guard let url = articles.url else { return }
        guard let openUrl = URL(string: url) else { return }
        UIApplication.shared.open(openUrl)
    }
    
    @objc func share(sender:UIView){
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndImageContext()
        
        let textToShare = "Share the news"
        
        let objectsToShare = [textToShare] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = sender
        self.present(activityVC, animated: true, completion: nil)
    }
}

// MARK: - Constraint Extensions
private extension ArticleDetailController {
    func makeDetailImage() {
        detailImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
            make.width.equalTo(detailImageView.snp.height)
        }
    }
    
    func makeTitleLabel() {
        detailTitle.snp.makeConstraints { make in
            make.top.equalTo(detailImageView.snp.bottom).offset(SnapKitPadding().pd4)
            make.centerX.equalTo(detailImageView)
            make.left.equalToSuperview().offset(SnapKitPadding().pd16)
            make.right.equalToSuperview().inset(SnapKitPadding().pd16)
        }
    }
    
    func makeOverViewLabel() {
        detailOverView.snp.makeConstraints { make in
            make.top.equalTo(detailTitle.snp.bottom).offset(SnapKitPadding().pd12)
            make.right.left.equalTo(detailTitle)
        }
    }
    
    func makeDetailButton() {
        detailButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(SnapKitPadding().pd20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(SnapKitPadding().pd48)
            make.right.equalToSuperview().inset(SnapKitPadding().pd48)
            make.height.equalTo(SnapKitPadding().pd52)
        }
    }
}
