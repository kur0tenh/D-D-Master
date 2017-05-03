//
//  character.swift
//  D&D-Master
//
//  Created by Angel Escobar on 02/05/17.
//  Copyright © 2017 Ángel Escobar Márquez. All rights reserved.
//

import Foundation
import UIKit
struct arrPersonajes {
    static var personaje = ""
}

class CharacterController: UITableViewController{
    var corrido = false
    var nombres = [String]()
    var baseDatos: OpaquePointer? = nil
    func obtenerPath(_	salida:	String)	->	URL?	{
        if let path =	FileManager.default.urls(for:	.documentDirectory,	in:	.userDomainMask).first {
            print(path)
            return path.appendingPathComponent(salida)
        }
        return nil
    }
    func abrirBaseDatos() -> Bool {
        if let path = obtenerPath("baseDatos.txt") {
            if sqlite3_open(path.absoluteString, &baseDatos) == SQLITE_OK {
                return true
            }
            // Error
            sqlite3_close(baseDatos)
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!corrido){
        _ = abrirBaseDatos()
            getPersonajes()
        corrido = true
        }
        return nombres.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = nombres[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrPersonajes.personaje = nombres[indexPath.row]
    
    }
    
    func getPersonajes()
    {
        let sqlConsulta2 = "SELECT * FROM personaje"
        var declaracion2: OpaquePointer? = nil
        print(sqlConsulta2)
        if sqlite3_prepare_v2(baseDatos, sqlConsulta2, -1, &declaracion2, nil) == SQLITE_OK
        {
            print("aqui")
            while sqlite3_step(declaracion2) == SQLITE_ROW
            {
                
                let personajes = String.init(cString: sqlite3_column_text(declaracion2, 0))
                nombres.append(personajes)
                
            }
        }
        print(nombres)
    }
    
    @IBAction func newCharacter(_ sender: Any) {
        corrido = false
    }
}
