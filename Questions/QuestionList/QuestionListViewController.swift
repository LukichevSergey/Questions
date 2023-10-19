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
    func setData(_ data: [Question])
}

// MARK: Protocol - QuestionListRouterToViewProtocol (Router -> View)
protocol QuestionListRouterToViewProtocol: AnyObject {
    func presentView(view: UIViewController)
    func pushView(view: UIViewController)
}

final class QuestionListViewController: UIViewController {
    
    private enum Section {
        case main
    }
    
    // MARK: - Property
    var presenter: QuestionListViewToPresenterProtocol!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(QuestionListTableViewCell.self, forCellReuseIdentifier: QuestionListTableViewCell.reuseIdentifier)
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white

        return tableView
    }()
    
    private lazy var dataSource = UITableViewDiffableDataSource<Section, Question>(tableView: tableView) { [weak self] tableView, indexPath, item in
        
        guard let self,
              let cell = tableView.dequeueReusableCell(withIdentifier: QuestionListTableViewCell.reuseIdentifier, for: indexPath) as? QuestionListTableViewCell
        else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        cell.configure(with: item)
        cell.delegate = self
        return cell
    }

    // MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.backgroundColor = .white
        title = "Questions"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    // MARK: - private func
    private func configureUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(16)
        }
    }
    
    @objc private func addButtonTapped() {
        logger.log("\(#fileID) -> \(#function)")
        presenter.addButtonTapped()
    }
}

// MARK: Extension - QuestionListPresenterToViewProtocol 
extension QuestionListViewController: QuestionListPresenterToViewProtocol{
    func setData(_ data: [Question]) {
        logger.log("\(#fileID) -> \(#function)")
        var snapshot = NSDiffableDataSourceSnapshot<Section, Question>()
        
        snapshot.appendSections([Section.main])
        snapshot.appendItems(data, toSection: Section.main)
        
        dataSource.apply(snapshot)
    }
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

// MARK: Extension - QuestionListTableViewCellDelegate
extension QuestionListViewController: QuestionListTableViewCellDelegate {
    func tableViewCellTapped(with question: Question) {
        logger.log("\(#fileID) -> \(#function)")
        
        presenter.tableViewCellTapped(with: question)
    }
}
