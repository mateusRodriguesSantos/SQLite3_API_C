//
//  ViewControllerAlterar.swift
//  CRUD_SQLite
//
//  Created by Mateus Rodrigues Santos on 25/07/19.
//  Copyright © 2019 Mateus Rodrigues Santos. All rights reserved.
//

import UIKit

var idAlteracao:Int?

class ViewControllerAlterar: UIViewController {

    @IBOutlet weak var nomeAlterar: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func alterar(_ sender: Any) {
        alterarDados(nome: nomeAlterar.text! , id: idAlteracao!)
        dismiss(animated: true, completion: nil)
    }
}
