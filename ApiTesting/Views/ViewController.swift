    //
    //  ViewController.swift
    //  ApiTesting
    //
    //  Created by Divay Sharma on 14/04/25.
    //

    import UIKit

    class ViewController: UIViewController {
        
        var categories : [Categories] = []
        var populars : [Populars] = []
        var specials : [Specials] = []
        
        
        let data = DataViewModel()
        
        // heading -- API Data
        private let headingLabel: UILabel = {
            let label = UILabel()
            label.text = "API Data"
            label.font = .systemFont(ofSize: 36, weight: .semibold)
            label.textColor = .gray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        // category
        private let categoryLabel: UILabel = {
            let label = UILabel()
            label.text = "Categories"
            label.font = UIFont.systemFont(ofSize: 24 , weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private lazy var collectioView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 150, height: 150)

            let collection = UICollectionView(frame: .zero , collectionViewLayout: layout)
            collection.tag = 0
            collection.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
            collection.delegate = self
            collection.dataSource = self
            collection.translatesAutoresizingMaskIntoConstraints = false
            return collection
        }()
        
        private lazy var categoryStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(categoryLabel)
            stack.addArrangedSubview(collectioView)
            
            NSLayoutConstraint.activate([
                collectioView.heightAnchor.constraint(equalToConstant: 160),
                collectioView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor , constant: 0)
            ])
            
            return stack
        }()
        
        // populars
        private let popularLabel: UILabel = {
            let label = UILabel()
            label.text = "Populars"
            label.font = UIFont.systemFont(ofSize: 24 , weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private lazy var popularCollectioView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 150, height: 150)

            let collection = UICollectionView(frame: .zero , collectionViewLayout: layout)
            collection.tag = 1
            collection.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
            collection.delegate = self
            collection.dataSource = self
            collection.translatesAutoresizingMaskIntoConstraints = false
            return collection
        }()
        
        private lazy var popularStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.addArrangedSubview(popularLabel)
            stack.addArrangedSubview(popularCollectioView)
            
            NSLayoutConstraint.activate([
                popularCollectioView.heightAnchor.constraint(equalToConstant: 160),
                popularCollectioView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor , constant: 0)
            ])
            
            return stack
        }()
        
        //specials
        private let specialsLabel: UILabel = {
            let label = UILabel()
            label.text = "Specials"
            label.font = UIFont.systemFont(ofSize: 24 , weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private lazy var specialsCollectioView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 150, height: 150)

            let collection = UICollectionView(frame: .zero , collectionViewLayout: layout)
            collection.tag = 2
            collection.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
            collection.delegate = self
            collection.dataSource = self
            collection.translatesAutoresizingMaskIntoConstraints = false
            return collection
        }()
        
        private lazy var specialsStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            stack.addArrangedSubview(specialsLabel)
            stack.addArrangedSubview(specialsCollectioView)
            
            NSLayoutConstraint.activate([
                specialsCollectioView.heightAnchor.constraint(equalToConstant: 160),
                specialsCollectioView.topAnchor.constraint(equalTo: specialsLabel.bottomAnchor , constant: 0)
            ])
            
            return stack
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            
            fetchData()
        }
        
        
        // fetch data from api
        func fetchData(){
            data.fetchData() {
                DispatchQueue.main.async {
                    self.categories = self.data.categories
                    self.populars = self.data.populars
                    self.specials = self.data.specials
                    
                    print(self.categories)
                    self.setupUI()
                }
            }
        }
        
        // setup ui
        func setupUI(){
            view.addSubview(headingLabel)
            view.addSubview(categoryStack)
            view.addSubview(popularStack)
            view.addSubview(specialsStack)
            
            navigationController?.navigationBar.prefersLargeTitles = true
            
            NSLayoutConstraint.activate([
                headingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                headingLabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 60),
                
                categoryStack.topAnchor.constraint(equalTo: headingLabel.bottomAnchor , constant: 8),
                categoryStack.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: 12),
                categoryStack.heightAnchor.constraint(equalToConstant: 204),
                categoryStack.widthAnchor.constraint(equalToConstant: 400),
                
                popularStack.topAnchor.constraint(equalTo: categoryStack.bottomAnchor , constant: 8),
                popularStack.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: 12),
                popularStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                popularStack.heightAnchor.constraint(equalToConstant: 204),
                
                specialsStack.topAnchor.constraint(equalTo: popularStack.bottomAnchor , constant: 8),
                specialsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: 12),
                specialsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                specialsStack.heightAnchor.constraint(equalToConstant: 204),
            ])
        }
    }

    extension ViewController: UICollectionViewDelegate , UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch collectionView.tag {
                    case 0: return categories.count
                    case 1: return populars.count
                    case 2:  return specials.count
                    default: return 0
                    }
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CollectionCell.identifier, for: indexPath
            ) as? CollectionCell else {
                return UICollectionViewCell()
            }
            switch collectionView.tag {
                   case 0:
                       let category = categories[indexPath.item]
                       cell.configure(with: category.title, imageURL: category.image)
                   case 1:
                       let popular = populars[indexPath.item]
                       cell.configure(with: popular.name, imageURL: popular.image)
                   case 2 :
                       let special = specials[indexPath.item]
                       cell.configure(with: special.name, imageURL: special.image)
                   default:
                       break
                   }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            switch collectionView.tag {
            case 0:
                let selectedCategory = categories[indexPath.item]
                let nextScrene = DetailsViewController()
                nextScrene.heading = selectedCategory.title
                nextScrene.image = selectedCategory.image
                
                navigationController?.pushViewController(nextScrene, animated: true)

            case 1:
                let selectedPopular = populars[indexPath.item]
                let nextScrene = DetailsViewController()
                nextScrene.heading = selectedPopular.name
                nextScrene.desc = selectedPopular.description
                nextScrene.image = selectedPopular.image
                nextScrene.calories = selectedPopular.calories
                navigationController?.pushViewController(nextScrene, animated: true)
            case 2:
                let selectedSpecial = specials[indexPath.item]
                let nextScrene = DetailsViewController()
                nextScrene.heading = selectedSpecial.name
                nextScrene.desc = selectedSpecial.description
                nextScrene.image = selectedSpecial.image
                nextScrene.calories = selectedSpecial.calories
                navigationController?.pushViewController(nextScrene, animated: true)
            default:
                break
            }
        }
        
       
    }



#Preview{
    ViewController()
}
