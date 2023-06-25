//
//  LatestArticleCell.swift
//  NewsViewer
//
//  Created by ramil on 23.06.2023.
//

import UIKit
import Kingfisher

final class LatestArticleCell: UICollectionViewCell {
    
    //MARK: - Properties
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
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let articleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
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
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
    }
    
    //MARK: - Methods
    func configure(with article: Article) {
        if let imageUrl = article.imageURL,
           let url = URL(string: imageUrl) {
            
            articleImageView.kf.setImage(with: url,
                                         options: [.transition(.fade(0.25))])
        } else {
            articleImageView.image = imagePlaceholder
        }
        
        articleTitleLabel.text = article.title
        authorNameLabel.text = article.creator?[0] ?? "Неизвестный источник"
        dateLabel.text = article.pubDate
    }
    
    private func setupSubviews() {
        contentView.addSubview(articleImageView)
        contentView.addSubview(labelsStack)
        
        let imageHeight = articleImageView.heightAnchor.constraint(equalTo: articleImageView.widthAnchor)
        let imageBottom = articleImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        
        imageHeight.priority = .defaultHigh
        imageBottom.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            articleImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),

            imageHeight,
            
            //Adaptive bottom
            imageBottom,

            labelsStack.topAnchor.constraint(equalTo: articleImageView.topAnchor),
            labelsStack.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 10),
            labelsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            //Adaptive bottom
            labelsStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
