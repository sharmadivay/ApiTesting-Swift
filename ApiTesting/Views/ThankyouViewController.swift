//
//  ThankyouViewController.swift
//  ApiTesting
//
//  Created by Divay Sharma on 15/04/25.
//

import UIKit

class ThankyouViewController: UIViewController {
    
    private let thankYouImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = .systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let thankYouLabel: UILabel = {
        let label = UILabel()
        label.text = "Thank you!"
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var thankYouStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [thankYouImageView, thankYouLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(thankYouStack)

        NSLayoutConstraint.activate([
            thankYouStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thankYouStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            thankYouImageView.heightAnchor.constraint(equalToConstant: 40),
            thankYouImageView.widthAnchor.constraint(equalToConstant: 40),
        ])
    }

    

  

}

#Preview{
    ThankyouViewController()
}
