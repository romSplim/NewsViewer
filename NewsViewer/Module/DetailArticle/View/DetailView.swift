//
//  DetailView.swift
//  NewsViewer
//
//  Created by ramil on 23.06.2023.
//

import UIKit
import Kingfisher

final class DetailView: UIView {

    //MARK: - Properties
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGroupedBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let subviews = [authorLabel,
                        articleTitleLabel,
                        dateLabel,
                        descriptionLabel]
        
        let stack = UIStackView(arrangedSubviews: subviews)
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setup(with article: Article) {
        if
            let stringUrl = article.imageURL,
            let url = URL(string: stringUrl) {
            
            articleImageView.kf.setImage(with: url,
                                       options: [.transition(.fade(0.25))])
        }
        
        articleTitleLabel.text = article.title
        authorLabel.text = article.creator?.joined(separator: ",") ?? "Неизвестный источник"
        dateLabel.text = article.pubDate
        descriptionLabel.text = article.content
    }
    
    //MARK: - Private methods
    private func setupSubviews() {
        addSubview(articleImageView)
        addSubview(labelStack)
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: topAnchor),
            articleImageView.widthAnchor.constraint(equalTo: widthAnchor),
            articleImageView.heightAnchor.constraint(equalToConstant: 300),
            
            labelStack.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10),
            labelStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            labelStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
