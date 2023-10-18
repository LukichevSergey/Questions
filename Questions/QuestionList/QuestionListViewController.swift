//
//  QuestionListViewController.swift
//  Questions
//
//  Created by Сергей Лукичев on 18.10.2023.
//  
//

import UIKit

// MARK: Protocol - QuestionListPresenterToViewProtocol (Presenter -> View)
protocol QuestionListPresenterToViewProtocol: AnyObject {

}

// MARK: Protocol - QuestionListRouterToViewProtocol (Router -> View)
protocol QuestionListRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class QuestionListViewController: UIViewController {
    
    // MARK: - Property
    var presenter: QuestionListViewToPresenterProtocol!

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
    
    // MARK: - private func
    private func commonInit() {

    }

    private func configureUI() {

    }
}

// MARK: Extension - QuestionListPresenterToViewProtocol 
extension QuestionListViewController: QuestionListPresenterToViewProtocol{
    
}

// MARK: Extension - QuestionListRouterToViewProtocol
extension QuestionListViewController: QuestionListRouterToViewProtocol{
    func presentView(view: UIViewController) {
        present(view, animated: true, completion: nil)
    }

    func pushView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
