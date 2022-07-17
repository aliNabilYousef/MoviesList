//
//  MovieDetailsViewController.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    //MARK: UIElements
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let containerView: UIView = UIView()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Dimensions.defaultCornerRadius.rawValue
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: Dimensions.titleFontSize.rawValue)
        label.textColor = Colors.blackTextColor
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = Colors.fadedTextColor
        return label
    }()
    
    private let overviewTextView: UITextView = {
        let textView = UITextView()
        textView.showsVerticalScrollIndicator = false
        textView.isUserInteractionEnabled = false
        textView.font = UIFont.boldSystemFont(ofSize: Dimensions.titleFontSize.rawValue)
        return textView
    }()
    
    //MARK: Class Variables
    private var viewModel: MovieDetailsViewModel?
    
    //MARK: Class Functions
    func bindToViewModel(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        movieImageView.kf.setImage(with: viewModel.image)
        titleLabel.text = viewModel.title
        yearLabel.text = viewModel.releaseDate
        overviewTextView.text = viewModel.overview
        self.title = viewModel.title
    }
    
    func setupViews() {
        containerView.addSubview(movieImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(yearLabel)
        containerView.addSubview(overviewTextView)
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        
        layoutViews()
    }
    
    func layoutViews() {
        scrollView.snp.makeConstraints {[weak self] make in
            guard let self = self else { return }
            make.top.equalTo((self.navigationController?.navigationBar.bounds.height ?? 0) + (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) + Dimensions.narrowPadding.rawValue)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {[weak self] make in
            guard let self = self else { return }
            make.top.equalTo((self.navigationController?.navigationBar.bounds.height ?? 0) + (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) + Dimensions.narrowPadding.rawValue)
            make.leading.trailing.bottom.equalTo(self.view)
        }
        
        movieImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(Dimensions.defaultPadding.rawValue)
            make.trailing.equalToSuperview().offset(-Dimensions.defaultPadding.rawValue)
        }
        
        titleLabel.snp.makeConstraints {[weak self] make in
            guard let self = self else { return }
            make.top.equalTo(self.movieImageView.snp.bottom).offset(Dimensions.defaultPadding.rawValue)
            make.leading.trailing.equalTo(self.movieImageView)
        }
        
        yearLabel.snp.makeConstraints {[weak self] make in
            guard let self = self else { return }
            make.top.equalTo(self.titleLabel.snp.bottom).offset(Dimensions.narrowPadding.rawValue)
            make.leading.trailing.equalTo(self.titleLabel)
        }
        
        overviewTextView.snp.makeConstraints {[weak self] make in
            guard let self = self else { return }
            make.top.equalTo(self.yearLabel.snp.bottom).offset(Dimensions.defaultPadding.rawValue)
            make.leading.trailing.equalTo(self.yearLabel)
            make.bottom.equalToSuperview().offset(-Dimensions.defaultPadding.rawValue)
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
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
