//
//  MovieListViewController.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 13/04/21.
//

import UIKit
import RxSwift
import RxCocoa

final class MovieListViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    let selectedYear = BehaviorRelay<String>.init(value: "")
    private let disposeBag = DisposeBag()
    private let movieVM: PresentableData
    
    lazy var tableView = UITableView()
    
    
    init(movieViewMode: PresentableData) {
        self.movieVM = movieViewMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupTableView()
        reloadUI()
        monitorAppStatus()
        
    }
    
}

// MARK:- Func Reload UI Data
extension MovieListViewController {
    
    private func reloadUI() {
        
        movieVM.provider.getMoviesData()
        movieVM.moviesData(filter: "")
        
        movieVM.observResultMovies
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: MoviesListTableViewCell.self)){ row, post, cell in
                cell.updateData(model: post)

            }.disposed(by: disposeBag)
    }
    
}

// MARK:- Setup Navigation Controller
extension MovieListViewController {
    private func setupNavigation() {
        let navBar = navigationController!.navigationBar
        navigationItem.title = "Ghibli Movies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .done, target: self, action: #selector(tapForGear))
        navigationItem.rightBarButtonItem?.tintColor = .systemGreen
        navBar.barTintColor = #colorLiteral(red: 0.1335714757, green: 0.5800201893, blue: 0.8241621852, alpha: 1)
        navBar.prefersLargeTitles = true
        
        
        
    }
    
    @objc func tapForGear() {
    
        let vc = FilterSelectViewController(years: movieVM.yearData())
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil )
        
        vc.selectedFilter
            .observe(on: MainScheduler.instance)
            .map { $0 }
            .do(onNext: { self.movieVM.moviesData(filter: $0) })
            .subscribe { (selectedYear) in
                
            }.disposed(by: disposeBag)
    }
    
}

// MARK:- Check app status
extension MovieListViewController {
    private func monitorAppStatus() {
        movieVM.provider.observErrorStatus
            .observe(on: MainScheduler.instance)
            .do { (status) in
                if !status.isEmpty {
                    // Create new Alert
                    let dialogMessage = UIAlertController(title: "\(status)", message: "Make sure your connection is online.", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                    let retry = UIAlertAction(title: "Retry", style: .default, handler: { (action) -> Void in
                        self.movieVM.provider.getMoviesData()
                     })
                    
                    //Add OK button to a dialog message
                    dialogMessage.addAction(retry)

                    // Present Alert to
                    self.present(dialogMessage, animated: true, completion: nil)
                }
                
            }.subscribe().disposed(by: disposeBag)
        
    }
    
}

// MARK:- Setup UI Element Programmatically
extension MovieListViewController {
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UINib(nibName: "MoviesListTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.isScrollEnabled = true
        tableView.allowsSelection = false
        tableView.indicatorStyle = .default
        tableView.separatorStyle = .none
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}
