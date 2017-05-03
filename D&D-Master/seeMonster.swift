//
//  seeMonster.swift
//  D&D-Master
//
//  Created by Angel Escobar on 02/05/17.
//  Copyright © 2017 Ángel Escobar Márquez. All rights reserved.
//


import UIKit

class SeeMonster: UIViewController  {
    
    @IBOutlet weak var monsterName: UILabel!
    @IBOutlet weak var monsterDescription: UITextView!
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
    override func viewDidLoad()
    {
        let monstruo = arrMonstruos.monstruo
        _ = abrirBaseDatos()
        var declaracion: OpaquePointer? = nil
        let sqlConsulta = "SELECT * FROM monstruos WHERE nombre = '\(monstruo)'"
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK
        {
            while sqlite3_step(declaracion) == SQLITE_ROW
            {
                monsterName.text = String.init(cString: sqlite3_column_text(declaracion, 0))
                monsterDescription.text = String.init(cString: sqlite3_column_text(declaracion, 1))
                
            }
        }

    }

}
