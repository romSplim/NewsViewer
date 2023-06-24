//
//  FavoriteArticleCell.swift
//  NewsViewer
//
//  Created by ramil on 24.06.2023.
//

import UIKit

final class FavoriteArticleCell: UITableViewCell {

    private let imagePlaceholder = UIImage(named: "placeholder")
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGroupedBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TestData.articleTitle
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.text = TestData.authorName
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let articleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
//        label.text = TestData.articleDescription
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = TestData.date
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelsStack: UIStackView = {
        let subviews = [articleTitleLabel,
                        authorNameLabel,
                        articleDescriptionLabel,
                        dateLabel]
        
        let stack = UIStackView(arrangedSubviews: subviews)
        stack.axis = .vertical
        stack.alignment = .leading
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
    }
    
    func configure(with article: Article) {
        if let imageUrl = article.imageURL,
           let url = URL(string: imageUrl) {
            
            articleImageView.kf.setImage(with: url,
                                         options: [.transition(.fade(0.25))])
        } else {
            articleImageView.image = imagePlaceholder
        }
        
        articleTitleLabel.text = article.title
        authorNameLabel.text = "Неизвестный источник"
//        articleDescriptionLabel.text = article.description
        dateLabel.text = article.pubDate
    }
    
    private func setupSubviews() {
        contentView.addSubview(articleImageView)
        contentView.addSubview(labelsStack)
        
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            articleImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            articleImageView.heightAnchor.constraint(equalTo: articleImageView.widthAnchor),
            //Adaptive bottom
            articleImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            
            labelsStack.topAnchor.constraint(equalTo: articleImageView.topAnchor),
            labelsStack.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 10),
            labelsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            //Adaptive bottom
            labelsStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
            
        ])
    }

}
