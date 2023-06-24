//
//  TopArticleCell.swift
//  NewsViewer
//
//  Created by ramil on 22.06.2023.
//

import UIKit

final class TopArticleCell: UICollectionViewCell {

    //MARK: - Properties
    private let gradientLayer = CAGradientLayer()
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .systemGroupedBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = TestData.articleTitle
        label.font = .boldSystemFont(ofSize: 21)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.text = TestData.authorName
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = TestData.date
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .white.withAlphaComponent(0.6)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelsStack: UIStackView = {
        let subviews = [articleTitleLabel,
                        authorNameLabel,
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
        addGradient()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 8.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        articleImageView.layoutIfNeeded()
        gradientLayer.frame = articleImageView.bounds
    }
    
    //MARK: - Methods
    func configure(with article: Article) {
        if let imageUrl = article.imageURL,
           let url = URL(string: imageUrl) {
            
            articleImageView.kf.setImage(with: url,
                                         options: [.transition(.fade(0.25))])
        }
        articleTitleLabel.text = article.title
        authorNameLabel.text = article.creator?[0] ?? "Неизвестный источник"
        dateLabel.text = article.pubDate
    }
    
    //MARK: - Private methods
    private func addGradient() {
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.black.cgColor]
        gradientLayer.locations = [0, 1]
        articleImageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupSubviews() {
        contentView.addSubview(articleImageView)
        contentView.addSubview(labelsStack)
        
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            articleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            labelsStack.leadingAnchor.constraint(equalTo: articleImageView.leadingAnchor, constant: 16),
            labelsStack.trailingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: -16),
            labelsStack.bottomAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: -16),
        ])
    }
}
