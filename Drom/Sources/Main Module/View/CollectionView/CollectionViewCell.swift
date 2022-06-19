//
//  CollectionViewCell.swift
//  Drom
//
//  Created by Vadim Voronkov on 19.06.2022.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifier = "CollectionViewCell"
    
    public var image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.white.cgColor
        return image
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 3
    }
    
    //MARK: - Methods
    
    public func configureCell(image: UIImage) {
        self.image.image = image
    }
    
    private func createUI() {
        self.contentView.addSubview(self.image)
        NSLayoutConstraint.activate([
            self.image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.image.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.image.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
}
