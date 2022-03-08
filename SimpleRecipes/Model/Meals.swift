//
//  Meals.swift
//  SimpleRecipes
//
//  Created by Rian Harshaw on 3/6/22.
//

import Foundation

struct Meals: Codable {
    let meals: [MealItems]
}

struct MealItems: Codable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
}
