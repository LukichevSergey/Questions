//
//  QuestionListTableViewCell.swift
//  Questions
//
//  Created by Сергей Лукичев on 19.10.2023.
//

import UIKit
import SnapKit

protocol QuestionListTableViewCellDelegate: AnyObject {
    func tableViewCellTapped(with question: Question)
}

final class QuestionListTableViewCell: UITableViewCell {
    
    weak var delegate: QuestionListTableViewCellDelegate?
    
    static let reuseIdentifier = String(describing: QuestionListTableViewCell.self)
    
    private var question: Question?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 1
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        logger.log("\(#fileID) -> \(#function)")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        logger.log("\(#fileID) -> \(#function)")
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(viewsLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(viewsLabel.snp.left).offset(16)
        }
        
        viewsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().inset(16)
        }
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTapped)))
    }
}

extension QuestionListTableViewCell: ConfigurableViewProtocol {
    func configure(with model: Question) {
        logger.log("\(#fileID) -> \(#function)")
        question = model
        titleLabel.text = model.question
        viewsLabel.text = "\(model.views)"
    }
    
    typealias ConfigurationModel = Question
}

private extension QuestionListTableViewCell {
    @objc private func cellTapped() {
        logger.log("\(#fileID) -> \(#function)")
        guard let question else { return }
        delegate?.tableViewCellTapped(with: question)
    }
}
