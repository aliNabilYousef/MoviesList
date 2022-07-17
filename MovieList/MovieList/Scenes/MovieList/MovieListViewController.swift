//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MovieListViewController: UIViewController {
    
    //MARK: UIElements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(MovieEntryTableCell.self, forCellReuseIdentifier: "MovieCell")
        return tableView
    }()
    
    //MARK: Class Variables
    private var viewModel: MovieListViewModel?
    private let disposeBag = DisposeBag()
    
    //MARK: Class Functions
    func bindToViewModel(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        viewModel.moviesList.bind(to: tableView.rx.items(cellIdentifier: "MovieCell", cellType: MovieEntryTableCell.self)){ index, element, cell in
            let cellViewModel = MovieEntryTableViewModel(withMovie: element)
            cell.bind(toViewModel: cellViewModel)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: {[weak self] indexPath in
            viewModel.goToMovieDetails(index: indexPath.row)
        }).disposed(by: disposeBag)
    }
    
    func setupViews() {
        view.addSubview(tableView)
        layoutViews()
    }
    
    func layoutViews() {
        tableView.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-Dimensions.defaultPadding.rawValue)
            make.leading.equalToSuperview().offset(Dimensions.defaultPadding.rawValue)
            make.top.equalTo((UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) + Dimensions.narrowPadding.rawValue)
        }
    }
    
    //MARK: UIViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.defaultBackgroundColor
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
