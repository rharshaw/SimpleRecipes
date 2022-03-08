//
//  NetworkService.swift
//  SimpleRecipes
//
//  Created by Rian Harshaw on 3/6/22.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    func fetchCategories(completion: @escaping(Categories) -> Void) {
        
        let urlString = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")
        guard let url = urlString else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
            print("DEBUG: Error \(error.localizedDescription)")
        }
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(Categories.self, from: data)
                completion(result)
            } catch {
                print("DEBUG: Error \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    func fetch(category: String, completion: @escaping(Meals) -> Void) {
        
        let urlString = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)")
        
        guard let url = urlString else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
            print("DEBUG: Error \(error.localizedDescription)")
        }
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(Meals.self, from: data)
                completion(result)
            } catch {
                print("DEBUG: Error \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    func fetchMealDetail(mealId: String, completion: @escaping(MealDetails) -> Void) {
        
        let urlString = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)")
        
        guard let url = urlString else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
            print("DEBUG: Error \(error.localizedDescription)")
        }
            guard let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(MealDetails.self, from: data)
                completion(result)
            } catch {
                print("DEBUG: Error \(error.localizedDescription)")
            }
        })
        task.resume()
    }
}
