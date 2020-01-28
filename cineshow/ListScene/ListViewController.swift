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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.adjustTbvHeader()
        let presenter = ListPresenter()
        presenter.viewController = self
        interactor.presenter = presenter
    }
    
    func adjustTbvHeader() {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 80.0))
        let textField =  UITextField(frame: CGRect(x: 20, y: 40, width: self.view.frame.width - 40, height: 40))
        textField.placeholder = "Type a movie"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.delegate = self
        headerView.addSubview(textField)
        listTbv.tableHeaderView = headerView
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension ListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        interactor.callEndPoint(argument: textField.text ?? "")
        
        return true
    }
}
