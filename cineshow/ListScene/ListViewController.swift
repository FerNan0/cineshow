//
//  ListViewController.swift
//  cineshow
//
//  Created by Fernando Duarte on 27/01/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    
    @IBOutlet var listTbv: UITableView!
    let interactor = ListInteractor()
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.adjustTbvHeader()
        self.setUI()
        self.loadFavorites()
        let presenter = ListPresenter()
        presenter.viewController = self
        interactor.presenter = presenter
    }
    
    func loadFavorites() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieDB")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                var movieHelper = Movie()
                movieHelper.title = data.value(forKey: "title") as? String
                movieHelper.type = data.value(forKey: "type") as? String
                movieHelper.imdbID = data.value(forKey: "imdbID") as? String
                movieHelper.poster = data.value(forKey: "poster") as? String
                movieHelper.year = data.value(forKey: "year") as? String
                movies.append(movieHelper)
          }
            
        } catch {
            
            print("Failed")
        }
        listTbv.reloadData()
    }
    func setUI() {
        listTbv.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "listCell")
        listTbv.register(UINib(nibName: "Detail", bundle: nil), forCellReuseIdentifier: "detail")
        self.title = "List screen"
        listTbv.delegate = self
        listTbv.dataSource = self
        listTbv.tableFooterView = UIView()
        listTbv.allowsSelection = true
    }
    
    func adjustTbvHeader() {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 100.0))
        let textField =  UITextField(frame: CGRect(x: 20, y: 40, width: self.view.frame.width - 40, height: 40))
        textField.placeholder = "Type a movie"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.search
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.delegate = self
        headerView.addSubview(textField)
        listTbv.tableHeaderView = headerView
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = listTbv.dequeueReusableCell(withIdentifier: "listCell") as? ListCell {
            cell.configure(image: movies[indexPath.row].poster ?? "", name: movies[indexPath.row].title ?? "", year: movies[indexPath.row].year ?? "")
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(nibName: "Detail", bundle: nil) as DetailViewController
        vc.movie = movies[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        interactor.callEndPoint(argument: textField.text ?? "")
        
        return true
    }
}

extension ListViewController: PresenterProtocol {
    func showData(movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.listTbv.reloadData()
        }
    }
}
