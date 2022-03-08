//
//  ViewController.swift
//  SimpleRecipes
//
//  Created by Rian Harshaw on 3/5/22.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    var categories: [CategoryItems]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Categories"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        self.view.isUserInteractionEnabled = true
        tableView.frame = view.bounds
        self.tableView.delegate = self
        self.tableView.dataSource = self
        fetchCategories()
    }
    
    func fetchCategories() {
        NetworkService.shared.fetchCategories { category in
            DispatchQueue.main.async {
            self.categories = category.categories.sorted { $0.strCategory < $1.strCategory }
            self.tableView.reloadData()
            }
        }
    }
    
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MealsViewController()
        guard let categories = categories else { return }
        controller.title = categories[indexPath.row].strCategory
        controller.category = categories[indexPath.row].strCategory
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let categories = categories else { return cell }
        cell.textLabel?.text = categories[indexPath.row].strCategory
        return cell
    }
}

