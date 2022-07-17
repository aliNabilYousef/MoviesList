//
//  MovieEntryTableCell.swift
//  MovieList
//
//  Created by Ali Youssef on 16/07/2022.
//

import UIKit
import Kingfisher

class MovieEntryTableCell: UITableViewCell {
    //MARK: UIElements
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
    
    //MARK: Class Variables
    var viewModel: MovieEntryTableViewModel?
    
    //MARK: Class Functions
    func bind(toViewModel viewModel: MovieEntryTableViewModel?) {
        self.viewModel = viewModel
        setupViews()
    }
    
    func setupViews() {
        addSubview(movieImageView)
        addSubview(titleLabel)
        addSubview(yearLabel)
        
        movieImageView.kf.setImage(with: viewModel?.image)
        titleLabel.text = viewModel?.title
        yearLabel.text = viewModel?.releaseDate
        layoutViews()
    }
    
    func layoutViews() {
        movieImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.height.equalTo(90)
            make.width.equalTo(UIScreen.main.bounds.width/3)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Dimensions.narrowPadding.rawValue)
            make.leading.equalTo(movieImageView.snp.trailing).offset(Dimensions.narrowPadding.rawValue)
            make.trailing.equalToSuperview().offset(-Dimensions.narrowPadding.rawValue)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(Dimensions.narrowPadding.rawValue)
            
        }
    }
}
