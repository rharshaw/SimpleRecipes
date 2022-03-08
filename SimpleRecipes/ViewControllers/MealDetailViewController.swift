//
//  MealDetailViewController.swift
//  SimpleRecipes
//
//  Created by Rian Harshaw on 3/6/22.
//

import Foundation
import UIKit


class MealDetailViewController: UIViewController {
    
    
    // MARK: - Properties
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.numberOfLines = 10
        ingredientsLabel.font = UIFont.systemFont(ofSize: 12)
        return ingredientsLabel
    }()
    
    let ingredientsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Ingredients"
        return label
    }()
    
    let instructionsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Instructions"
        
        return label
    }()
    
    let measurementsLabel: UILabel = {
        let measurementsLabel = UILabel()
        return measurementsLabel
    }()
    
    let instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        instructionsLabel.numberOfLines = 40
        instructionsLabel.font = UIFont.systemFont(ofSize: 12)
        
        return instructionsLabel
    }()
    
    var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    
    var mealId: String?
    var mealDetails = [Details]()
    var imageURL: URL?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMealDetail()
        configureUI()
    }
    
    
    // MARK: - Functions
    
    func fetchMealDetail() {
        guard let mealId = mealId else { return }
        // API Call
        NetworkService.shared.fetchMealDetail(mealId: mealId) { details in
            self.mealDetails = details.meals.compactMap { $0 }
            
            self.configureData(mealDetails: details.meals)
            print("DEBUG: \(details.meals[0].getIngredients())")
        }
    }
    
    func configureUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.setDimensions(width: self.view.bounds.width, height: self.view.bounds.height)
        
        let stack = UIStackView(arrangedSubviews: [imageView, ingredientsTitleLabel, ingredientsLabel, instructionsTitleLabel, instructionsLabel])
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setDimensions(width: self.view.bounds.width - 40, height: self.view.bounds.height - 10)
        
        imageView.setDimensions(width: self.view.bounds.width, height: 150)
        // Adding to Subview + Adding Constraints
        view.addSubview(scrollView)
        scrollView.addSubview(stack)
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        stack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20)
    }
    
    func configureData(mealDetails: [Details]) {
        DispatchQueue.main.async {
            guard let mealThumb = mealDetails[0].strMealThumb else { return }
            let url = URL(string: mealThumb)
            guard let url = url else { return }
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                self.imageView.image = image
            }
            
            self.ingredientsLabel.text = (mealDetails[0].getIngredients())
            self.instructionsLabel.text = mealDetails[0].strInstructions
            
        }
    }
}
