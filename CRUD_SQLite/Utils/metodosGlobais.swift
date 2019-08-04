//
//  metodosGlobais.swift
//  CRUD_SQLite
//
//  Created by Mateus Rodrigues Santos on 25/07/19.
//  Copyright © 2019 Mateus Rodrigues Santos. All rights reserved.
//

import Foundation
import SQLite3

class Cliente{
    var id:Int?
    var nome:String?
    
    init(id: Int,nome: String) {
        self.id = id
        self.nome = nome
    }
}

var  db: OpaquePointer?
var criar: OpaquePointer?
var leitura: OpaquePointer?
var gravar: OpaquePointer?
var delecao: OpaquePointer?
var alterar: OpaquePointer?

var arrayCliente = [Cliente]()

func criarTabela(){
    if sqlite3_prepare_v2(db,"CREATE TABLE Cliente(id INTEGER PRIMARY KEY,nome TEXT);", -1,&criar, nil) == SQLITE_OK{
        if sqlite3_step(criar) == SQLITE_DONE{
            print("Criada a tabela com sucesso!!!")
        }else{
            print("Erro na criacao da tabela1!!!")
        }
    }else{
        print("Erro na criacao da tabela2!!!")
    }
    
    sqlite3_finalize(criar)
}

func lerClientes(){
    if sqlite3_prepare(db,"SELECT * FROM Cliente", -1,&leitura, nil) == SQLITE_OK{
        while sqlite3_step(leitura) == SQLITE_ROW{
            let numero = sqlite3_column_int(leitura, 0)
            guard let texto = sqlite3_column_text(leitura, 1) else {return}
            
            let id = Int(numero)
            let name = String(cString: texto)
            arrayCliente.append(Cliente(id: id, nome: name))
            print(name)
        }
    }else{
        print("Leitura feita com sucesso!!!")
    }
    sqlite3_finalize(leitura)
}

func alterarDados(nome: String,id: Int){
    print(nome,id)
    let sql = "UPDATE Cliente SET nome=? WHERE id=?"
    
    if sqlite3_prepare(db,sql, -1,&alterar, nil) == SQLITE_OK{
        
        sqlite3_bind_text(alterar, 1,nome, -1, nil)
        sqlite3_bind_int(alterar, 2, Int32(id))
        
        if sqlite3_step(alterar) == SQLITE_DONE{
            print("Dados alterados com sucesso!!!")
        }else{
            print("Erro na alteracao!!!")
        }
    }else{
        print("Erro na preparacao do sql!!!")
    }
    sqlite3_finalize(alterar)
}

func gravaDados(nome: NSString){
    if sqlite3_prepare(db,"INSERT INTO CLIENTE (nome) VALUES (?)", -1, &gravar, nil) == SQLITE_OK{
        
        sqlite3_bind_text(gravar, 1,nome.utf8String, -1, nil)
        
        if sqlite3_step(gravar) == SQLITE_DONE{
            print("Dados inseridos com sucesso!!!")
        }else{
            print("Erro ao inserir dados!!!")
        }
    }else{
        print("Erro na preparação do sql!!!")
    }
}

func deletaDados(id: Int32){
    if sqlite3_prepare(db, "DELETE FROM Cliente WHERE id=?", -1, &delecao, nil) == SQLITE_OK{
        
        sqlite3_bind_int(delecao, 1, id)
        
        if sqlite3_step(delecao) == SQLITE_DONE{
            print("Deletado com sucesso!!!")
        }else{
            print("Erro na deleção")
        }
        
    }else{
        print("Erro na preparação do delete!!!")
    }
    sqlite3_finalize(delecao)
}
