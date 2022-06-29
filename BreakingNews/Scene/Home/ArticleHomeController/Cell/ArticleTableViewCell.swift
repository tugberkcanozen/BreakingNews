//
//  TableViewCell.swift
//  serviceManagerTest
//
//  Created by Tuğberk Can Özen on 28.06.2022.
//

import UIKit
import Kingfisher
import SnapKit
import SparkUI

final class ArticleTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    private let cellLabel: UILabel = {
        let cellLabel = UILabel()
        cellLabel.homeCellLabel()
        return cellLabel
    }()
    
    private let cellContent: UILabel = {
        let cellContent = UILabel()
        cellContent.homeCellContent()
        return cellContent
    }()
    
    private let cellImage: UIImageView = {
        let cellImage = UIImageView()
        cellImage.homeCellImage()
        return cellImage
    }()
    
    // MARK: - EnumIdentifier
    enum Idetenfier: String {
        case custom = "Cell"
    }
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subView()
        makeCellImage()
        makeCellLabel()
        makeCellContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Functions
    func saveModel(model: Article) {
        cellLabel.text = model.title
        cellContent.text = model.content
        cellImage.setImage(from: model.urlToImage!, indicatorType: .activity)
    }
    
    func searchModel(model: Article) {
        cellLabel.text = model.title
        cellContent.text = model.content
        cellImage.setImage(from: model.urlToImage!, indicatorType: .activity)
    }
    
    func subView() {
        addSubview(cellImage)
        addSubview(cellLabel)
        addSubview(cellContent)
    }
}

// MARK: - Snapkit Extensions
private extension ArticleTableViewCell {
    func makeCellImage() {
        cellImage.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.left.equalToSuperview().offset(260)
            make.height.equalTo(170)
            make.width.equalTo(170)
            make.center.equalToSuperview()
        }
    }
    
    func makeCellLabel() {
        cellLabel.snp.makeConstraints { make in
            make.right.equalTo(cellImage.snp.left).inset(-8)
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(cellImage.snp.top)
        }
    }
    
    func makeCellContent() {
        cellContent.snp.makeConstraints { make in
            make.top.equalTo(cellLabel.snp.top).offset(64)
            make.right.equalTo(cellLabel.snp.right)
            make.left.equalToSuperview().offset(16)
        }
    }
}
