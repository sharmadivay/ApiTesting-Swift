//
//  File.swift
//  ApiTesting
//
//  Created by Divay Sharma on 14/04/25.
//
import Foundation
class DataViewModel {
    
    var categories: [Categories] = []
    var populars: [Populars] = []
    var specials: [Specials] = []
    
 

    func fetchData( completion: @escaping () -> Void ) {
        guard let url = URL(string: "https://yummie.glitch.me/dish-categories") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(ApiResponse.self, from: data)
                
                self?.categories = decoded.data.categories
                self?.populars = decoded.data.populars
                self?.specials = decoded.data.specials
                
                completion()
                
                
            } catch {
                print("Decoding error: \(error)")
            }
        }.resume()
    }
}
