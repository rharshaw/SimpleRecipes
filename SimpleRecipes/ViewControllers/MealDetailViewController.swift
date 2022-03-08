//
//  MealDetailViewController.swift
//  SimpleRecipes
//
//  Created by Rian Harshaw on 3/6/22.
//

import Foundation
import UIKit


class MealDetailViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        return ingredientsLabel
    }()
    
    let measurementsLabel: UILabel = {
        let measurementsLabel = UILabel()
        return measurementsLabel
    }()
    
    let instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        return instructionsLabel
    }()
    
    
    var mealId: String?
    var mealDetails = [Details]()
    var imageURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMealDetail()
        
//        configureUI()

    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        let scrollView = UIScrollView(frame: view.bounds)
//        scrollView.backgroundColor = UIColor.green
//        view.addSubview(scrollView)
//    }
    
    func fetchMealDetail() {
        guard let mealId = mealId else { return }
// API Call
        NetworkService.shared.fetchMealDetail(mealId: mealId) { details in

// Using compactMap to filter out nil values
            self.mealDetails = details.meals.compactMap { $0 }
            self.configureData(mealDetails: details.meals)
            print("DEBUG: \(details.meals[0].getIngredients())")
            }

        }
    
    func configureUI() {
        
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        
        let stack = UIStackView(arrangedSubviews: [imageView, ingredientsLabel, measurementsLabel, instructionsLabel])
        imageView.setDimensions(width: 200, height: 200)
        ingredientsLabel.setDimensions(width: 200, height: .infinity)
        measurementsLabel.setDimensions(width: 200, height: .infinity)
        instructionsLabel.setDimensions(width: 300, height: .infinity)
        stack.axis = .vertical
        scrollView.addSubview(stack)
      
    }
    
    func configureData(mealDetails: [Details]) {
        DispatchQueue.main.async {
            let url = URL(string: mealDetails[0].strMealThumb)
            guard let url = url else { return }
            let data = try? Data(contentsOf: url)

            if let imageData = data {
                let image = UIImage(data: imageData)
                self.imageView.image = image
            }
            self.instructionsLabel.text = mealDetails[0].strInstructions
            print(mealDetails[0].strInstructions)
        }
    }
}
