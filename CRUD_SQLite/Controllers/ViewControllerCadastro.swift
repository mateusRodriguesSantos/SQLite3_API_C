//
//  ViewControllerCadastro.swift
//  CRUD_SQLite
//
//  Created by Mateus Rodrigues Santos on 25/07/19.
//  Copyright © 2019 Mateus Rodrigues Santos. All rights reserved.
//

import UIKit

class ViewControllerCadastro: UIViewController {


    @IBOutlet weak var nomeCadastro: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func cadastro(_ sender: Any) {
        gravaDados(nome: nomeCadastro.text! as NSString)
        self.dismiss(animated: true, completion: nil)
    }
    
}
