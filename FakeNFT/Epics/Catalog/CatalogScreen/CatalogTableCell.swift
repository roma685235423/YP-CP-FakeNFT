//
//  CatalogTableCell.swift
//  FakeNFT
//
//  Created by Богдан Полыгалов on 03.08.2023.
//

import UIKit
import Kingfisher

final class CatalogTableCell: UITableViewCell {
    static let cellReuseIdentifier = "catalogCell"
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyBold
        label.textColor = .ypBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .top
        image.clipsToBounds = true
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
        image.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabel(collectionName: String, collectionCount: Int) {
        label.text = "\(collectionName) (\(collectionCount))"
    }
    
    func setImage(link: String) {
        image.kf.setImage(with: URL(string: link.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""), placeholder: UIImage.mockCollection) { [weak self] _ in
            if let originalImage = self?.image.image {
                let scaledSize = CGSize(width: originalImage.size.width / 4, height: originalImage.size.height / 4)
                
                UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
                originalImage.draw(in: CGRect(origin: .zero, size: scaledSize))
                let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                self?.image.image = scaledImage
            }
        }
    }
    
    private func setView() {
        contentView.backgroundColor = .ypWhite
        contentView.addSubview(image)
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 140),
            
            label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
