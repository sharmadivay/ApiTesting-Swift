//
//  CartViewController.swift
//  ApiTesting
//
//  Created by Divay Sharma on 15/04/25.
//

import UIKit

class CartViewController: UIViewController {
    
    var heading: String = ""
    var image: String = ""
    var price: Int = 10
    private var quantity: Int = 1 {
        didSet {
            quantityLabel.text = "\(quantity)"
            updateTotalPrice()
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .label
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
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "1"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var quantityStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [minusButton, quantityLabel, plusButton])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let payButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
        let image = UIImage(systemName: "checkmark.seal", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitle(" Make Payment", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        titleLabel.text = heading
        priceLabel.text = "Price: $\(price)"
        updateTotalPrice()
        loadImage(from: image)
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(quantityStack)
        view.addSubview(totalLabel)
        view.addSubview(payButton)

        minusButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        
        payButton.addTarget(self, action: #selector(makePayment), for: .touchUpInside)

        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            quantityStack.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 24),
            quantityStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            minusButton.widthAnchor.constraint(equalToConstant: 44),
            plusButton.widthAnchor.constraint(equalToConstant: 44),
            
            totalLabel.topAnchor.constraint(equalTo: quantityStack.bottomAnchor, constant: 24),
            totalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            payButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            payButton.heightAnchor.constraint(equalToConstant: 80),
            payButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func decreaseQuantity() {
        if quantity > 1 {
            quantity -= 1
        }
    }

    @objc private func increaseQuantity() {
        quantity += 1
    }
    
    @objc private func makePayment(){
        let nextScrene = ThankyouViewController()
        navigationController?.pushViewController(nextScrene, animated: true)
    }

    private func updateTotalPrice() {
        totalLabel.text = "Total: $\(price * quantity)"
    }

    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            imageView.image = UIImage(systemName: "photo")
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

#Preview{
    CartViewController()
}
