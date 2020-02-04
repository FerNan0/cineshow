//
//  ListViewController.swift
//  cineshow
//
//  Created by Fernando Duarte on 27/01/20.
//  Copyright © 2020 Fernando Duarte. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet var listTbv: UITableView!
    let interactor = ListInteractor()
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.adjustTbvHeader()
        self.setUI()
        let presenter = ListPresenter()
        presenter.viewController = self
        interactor.presenter = presenter
    }
    
    func setUI() {
        listTbv.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "listCell")
        self.title = "List screen"
        listTbv.delegate = self
        listTbv.dataSource = self
        listTbv.tableFooterView = UIView()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    func adjustTbvHeader() {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 80.0))
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
            cell.configure(image: UIImage(), name: movies[indexPath.row].title ?? "", year: movies[indexPath.row].year ?? "")
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
