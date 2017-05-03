//
//  seeCharacter.swift
//  D&D-Master
//
//  Created by Angel Escobar on 02/05/17.
//  Copyright © 2017 Ángel Escobar Márquez. All rights reserved.
//

import UIKit

class SeeCharacter: UIViewController  {

    @IBOutlet weak var subclasso: UILabel!
    @IBOutlet weak var speedo: UILabel!
    @IBOutlet weak var wisdomo: UILabel!
    @IBOutlet weak var constitutiono: UILabel!
    @IBOutlet weak var strenghto: UILabel!
    @IBOutlet weak var backgroundo: UILabel!
    @IBOutlet weak var raceo: UILabel!
    @IBOutlet weak var classo: UILabel!
    @IBOutlet weak var nameo: UILabel!
    @IBOutlet weak var dexterityo: UILabel!
    @IBOutlet weak var intelligenso: UILabel!
    @IBOutlet weak var charismao: UILabel!
    @IBOutlet weak var hitdiceo: UILabel!
    @IBOutlet weak var experienceo: UILabel!
    @IBOutlet weak var dicerollo: UILabel!
    @IBOutlet weak var equipmento: UITextView!
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
        let personaje = arrPersonajes.personaje
        _ = abrirBaseDatos()
        var declaracion: OpaquePointer? = nil
        let sqlConsulta = "SELECT * FROM personaje WHERE nombre = '\(personaje)'"
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK
        {
            while sqlite3_step(declaracion) == SQLITE_ROW
            {
                speedo.text = "Speed: " + String.init(cString: sqlite3_column_text(declaracion, 10))
                wisdomo.text = "Wisdom: " + String.init(cString: sqlite3_column_text(declaracion, 5))
                constitutiono.text = "Constitution: " + String.init(cString: sqlite3_column_text(declaracion, 3))
                strenghto.text = "Strenght: " + String.init(cString: sqlite3_column_text(declaracion, 1))
                backgroundo.text = "Background: " + String.init(cString: sqlite3_column_text(declaracion, 20))
                raceo.text = "Race: " + String.init(cString: sqlite3_column_text(declaracion, 19))
                classo.text = "Class: " + String.init(cString: sqlite3_column_text(declaracion, 17))
                nameo.text = String.init(cString: sqlite3_column_text(declaracion, 0))
                dexterityo.text = "Dexterity: " + String.init(cString: sqlite3_column_text(declaracion, 2))
                intelligenso.text = "Intelligence: " + String.init(cString: sqlite3_column_text(declaracion, 4))
                charismao.text = "Charisma: " + String.init(cString: sqlite3_column_text(declaracion, 6))
                hitdiceo.text = "Hitdice: " + String.init(cString: sqlite3_column_text(declaracion, 12))
                experienceo.text = "Experience: " + String.init(cString: sqlite3_column_text(declaracion, 23))
                dicerollo.text = "Diceroll: " + String.init(cString: sqlite3_column_text(declaracion, 13))
                equipmento.text = String.init(cString: sqlite3_column_text(declaracion, 15))
                subclasso.text = "Subclass: " + String.init(cString: sqlite3_column_text(declaracion, 18))
                
            }
        }
    }
}
