//
//  DetailsViewController.swift
//  ApiTesting
//
//  Created by Divay Sharma on 15/04/25.
//

import UIKit

class DetailsViewController: UIViewController {

     var heading: String = ""
     var desc: String = "NO Description Available"
     var image: String = ""
     var calories: Int = 10
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
        let image = UIImage(systemName: "cart.badge.plus", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitle(" Add to Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        view.addSubview(imageView)
        view.addSubview(caloriesLabel)
        view.addSubview(cartButton)
        
        titleLabel.text = heading
        descLabel.text = desc
        caloriesLabel.text = "Price: $\(calories)"
        loadImage(from: image)
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            caloriesLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 4),
            caloriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            cartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cartButton.heightAnchor.constraint(equalToConstant: 80),
            cartButton.widthAnchor.constraint(equalToConstant: 200)
            
            
        ])

        cartButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
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

    @objc func onClick(){
        let nextScrene = CartViewController()
        nextScrene.heading = heading
        nextScrene.image = image
        nextScrene.price = calories
        navigationController?.pushViewController(nextScrene, animated: true)
        
    }

   

}

#Preview{
    DetailsViewController()
}
