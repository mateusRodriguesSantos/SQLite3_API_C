//
//  ViewController.swift
//  CRUD_SQLite
//
//  Created by Mateus Rodrigues Santos on 24/07/19.
//  Copyright © 2019 Mateus Rodrigues Santos. All rights reserved.
//

import UIKit
import SQLite3



class ViewController: UITableViewController {
  
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCliente.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.nameText.text = arrayCliente[indexPath.row].nome
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete{
            deletaDados(id: Int32(arrayCliente[indexPath.row].id!))
            arrayCliente.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        idAlteracao = arrayCliente[indexPath.row].id
        self.performSegue(withIdentifier: "alterarDados", sender: self)
    }

    func adicionaArquivoNoDocuments() -> URL{
        let urlDocument = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return urlDocument.appendingPathComponent("filmes").appendingPathExtension("db")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlDoBanco = adicionaArquivoNoDocuments()
    
        if sqlite3_open(urlDoBanco.path, &db) == SQLITE_OK{
            print("Conectado com sucesso!!")
        }else{
            print("Erro de conexao!!!")
        }
        
        criarTabela()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lerClientes()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        arrayCliente.removeAll()
    }

    
}

