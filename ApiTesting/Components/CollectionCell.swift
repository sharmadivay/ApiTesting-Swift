
import UIKit

class CollectionCell: UICollectionViewCell {
    
    static let identifier = "CollectionCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(title)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor , constant: 8),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor , constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            title.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with titleText: String, imageURL: String) {
        title.text = titleText
        loadImage(from: imageURL)
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            imageView.image = UIImage(systemName: "photo") // fallback
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let data = data, let image = UIImage(data: data), error == nil {
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "xmark.octagon")
                }
            }
        }.resume()
    }
}
