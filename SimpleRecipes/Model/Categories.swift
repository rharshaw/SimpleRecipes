//
//  Model.swift
//  SimpleRecipes
//
//  Created by Rian Harshaw on 3/5/22.
//

import Foundation


struct Categories: Codable {
    let categories: [CategoryItems]
}

struct CategoryItems: Codable {
    var idCategory: String
    var strCategory: String
    var strCategoryThumb: String
    var strCategoryDescription: String
}
