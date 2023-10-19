//
//  QuestionViewController.swift
//  Questions
//
//  Created by Сергей Лукичев on 19.10.2023.
//  
//

import UIKit

// MARK: Protocol - QuestionPresenterToViewProtocol (Presenter -> View)
protocol QuestionPresenterToViewProtocol: AnyObject {
    func setData(question: String, answer: String)
    func getData() -> (question: String, answer: String)
}

// MARK: Protocol - QuestionRouterToViewProtocol (Router -> View)
protocol QuestionRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class QuestionViewController: UIViewController {
    
    // MARK: - Property
    var presenter: QuestionViewToPresenterProtocol!
    
    private lazy var questionLabel: UITextView = {
        let label = UITextView()
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 3
        return label
    }()
    
    private lazy var answerLabel: UITextView = {
        let label = UITextView()
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 3
        return label
    }()
    
    private lazy var mainVtack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [questionLabel, answerLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()

    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(mainVtack)
        mainVtack.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    @objc private func saveButtonTapped() {
        logger.log("\(#fileID) -> \(#function)")
        
        presenter.saveButtonTapped()
    }
}

// MARK: Extension - QuestionPresenterToViewProtocol 
extension QuestionViewController: QuestionPresenterToViewProtocol{
    func setData(question: String, answer: String) {
        logger.log("\(#fileID) -> \(#function)")
        
        questionLabel.text = question
        answerLabel.text = answer
    }
    
    func getData() -> (question: String, answer: String) {
        logger.log("\(#fileID) -> \(#function)")
        
        return (questionLabel.text, answerLabel.text)
    }
}

// MARK: Extension - QuestionRouterToViewProtocol
extension QuestionViewController: QuestionRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
