//
//  MealsViewController.swift
//  SimpleRecipes
//
//  Created by Rian Harshaw on 3/6/22.
//

import Foundation
import UIKit

class MealsViewController: UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var meals: [MealItems]?
    var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        fetchMeals()
    }
    
    func fetchMeals() {
        guard let category = category else { return }
        NetworkService.shared.fetch(category: category) { meals in
            self.meals = meals.meals
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }

private let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .grouped)
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return table
}()

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return meals?.count ?? 10
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    guard let meals = meals else { return cell }
    cell.textLabel?.text = meals[indexPath.row].strMeal
    return cell
    }
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MealDetailViewController()
        guard let meals = meals else { return }
        controller.title = meals[indexPath.row].strMeal
        controller.mealId = meals[indexPath.row].idMeal
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
