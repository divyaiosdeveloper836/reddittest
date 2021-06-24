//
//  FeedListTableViewCell.swift
//  Reddit
//
//  Created by Divya on 24/06/21.
//

import UIKit

class FeedListTableViewCell: UITableViewCell {
    
    var feedImage = UIImageView()
    var title = UILabel()
    
    var comments = UILabel()
    var score = UILabel()
    var containerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        configureTitle()
        configureImage()
        configureBottomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        feedImage.image = UIImage(named: "placeholder")
    }

    private func setupCell() {
        contentView.addSubview(title)
        contentView.addSubview(feedImage)
        contentView.addSubview(containerView)
    }
    
    private func configureTitle() {
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.numberOfLines = 0
        title.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "sample"
        
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        title.bottomAnchor.constraint(equalTo: feedImage.topAnchor, constant: -20).isActive = true
    }
    
    
    private func configureImage() {
        feedImage.translatesAutoresizingMaskIntoConstraints = false
        feedImage.contentMode = .scaleAspectFill
        feedImage.layer.cornerRadius = 5
        feedImage.clipsToBounds = true
        feedImage.layer.borderWidth = 1.0
        feedImage.image = UIImage(named: "placeholder")
        
        feedImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        feedImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        feedImage.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: -10).isActive = true
    }
    
    private func configureBottomView()  {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        configureComments()
        configureScore()
    }
    
    private func configureComments() {
        containerView.addSubview(comments)
        comments.translatesAutoresizingMaskIntoConstraints = false
        
        comments.text = "100"
        
        comments.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        comments.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        comments.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        comments.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func configureScore() {
        containerView.addSubview(score)
        score.translatesAutoresizingMaskIntoConstraints = false
        
        score.text = "8747"
        
        score.leadingAnchor.constraint(equalTo: comments.trailingAnchor).isActive = true
        score.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        score.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        score.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
