//
//  SeeSpells.swift
//  D&D-Master
//
//  Created by Angel Escobar on 02/05/17.
//  Copyright © 2017 Ángel Escobar Márquez. All rights reserved.
//
import UIKit

class SeeSpells: UIViewController  {
    
    @IBOutlet weak var nameSpell: UILabel!
    @IBOutlet weak var descriptionSpell: UITextView!

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
        let spell = arrSpells.spell
        _ = abrirBaseDatos()
        var declaracion: OpaquePointer? = nil
        let sqlConsulta = "SELECT * FROM hechizos WHERE nombre = '\(spell)'"
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK
        {
            while sqlite3_step(declaracion) == SQLITE_ROW
            {
                nameSpell.text = String.init(cString: sqlite3_column_text(declaracion, 0))
                descriptionSpell.text = String.init(cString: sqlite3_column_text(declaracion, 1))
                
            }
        }
        
    }
    
}
