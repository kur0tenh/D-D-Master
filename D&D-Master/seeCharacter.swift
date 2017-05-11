//
//  seeCharacter.swift
//  D&D-Master
//
//  Created by Angel Escobar on 02/05/17.
//  Copyright © 2017 Ángel Escobar Márquez. All rights reserved.
//

import UIKit
struct arrStats {
    static var selected = 0
    static var strength = 0
    static var dexterity = 0
    static var constitution = 0
    static var intelligence = 0
    static var wisdom = 0
    static var charisma = 0
    static var nivel = 1
    static var hitdice = 0
    static var nombre = ""
    static var trait1 = ""
    static var trait2 = ""
    static var ideal = ""
    static var flaw = ""
    static var feature = ""
    static var proficiencies = ""
    static var languages = ""
    static var spells = ""
    static var skills = ""
    static var sexo = ""
    static var region = ""

    
    
}
class SeeCharacter: UIViewController  {
    
   
    
    @IBOutlet weak var levelo: UILabel!
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
        self.hideKeyboardWhenTappedAround()
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
                //experienceo.text = "Experience: " + String.init(cString: sqlite3_column_text(declaracion, 23))
                dicerollo.text = "Diceroll: " + String.init(cString: sqlite3_column_text(declaracion, 13))
                equipmento.text = String.init(cString: sqlite3_column_text(declaracion, 15))
                subclasso.text = "Subclass: " + String.init(cString: sqlite3_column_text(declaracion, 18))
                arrStats.nivel = Int(String.init(cString: sqlite3_column_text(declaracion, 21)))!
                arrStats.wisdom = Int(String.init(cString: sqlite3_column_text(declaracion, 5)))!
                arrStats.constitution = Int(String.init(cString: sqlite3_column_text(declaracion, 3)))!
                arrStats.strength = Int(String.init(cString: sqlite3_column_text(declaracion, 1)))!
                arrStats.dexterity = Int(String.init(cString: sqlite3_column_text(declaracion, 2)))!
                arrStats.intelligence = Int(String.init(cString: sqlite3_column_text(declaracion, 4)))!
                arrStats.charisma = Int(String.init(cString: sqlite3_column_text(declaracion, 6)))!
                arrStats.hitdice = Int(String.init(cString: sqlite3_column_text(declaracion, 12)))!
                arrStats.nombre = String.init(cString: sqlite3_column_text(declaracion, 0))
                arrStats.trait1 = String.init(cString: sqlite3_column_text(declaracion, 26))
                arrStats.trait2 = String.init(cString: sqlite3_column_text(declaracion, 27))
                arrStats.ideal = String.init(cString: sqlite3_column_text(declaracion, 28))
                arrStats.flaw = String.init(cString: sqlite3_column_text(declaracion, 29))
                arrStats.languages = String.init(cString: sqlite3_column_text(declaracion, 7))
                arrStats.spells = String.init(cString: sqlite3_column_text(declaracion, 31))
                arrStats.skills = String.init(cString: sqlite3_column_text(declaracion, 22))
                arrStats.sexo = String.init(cString: sqlite3_column_text(declaracion, 30))
                arrStats.region = String.init(cString: sqlite3_column_text(declaracion, 24))
                arrStats.feature = String.init(cString: sqlite3_column_text(declaracion, 25))
                arrStats.proficiencies = String.init(cString: sqlite3_column_text(declaracion, 11))

            }
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
    @IBAction func UpdateEquipment(_ sender: Any) {
        let equipo = equipmento.text!
        let sqlInserta = "UPDATE personaje SET  equipo = '\(equipo)' WHERE nombre = '\(arrStats.nombre)'"
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) != SQLITE_OK {
            
            print("Error al insertar datos)")
        }else{
            print("todo bien")
            
        }
    
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
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
                //experienceo.text = "Experience: " + String.init(cString: sqlite3_column_text(declaracion, 23))
                dicerollo.text = "Diceroll: " + String.init(cString: sqlite3_column_text(declaracion, 13))
                equipmento.text = String.init(cString: sqlite3_column_text(declaracion, 15))
                subclasso.text = "Subclass: " + String.init(cString: sqlite3_column_text(declaracion, 18))
                levelo.text = "Level: " + String.init(cString: sqlite3_column_text(declaracion, 21))
                arrStats.nivel = Int(String.init(cString: sqlite3_column_text(declaracion, 21)))!
                arrStats.wisdom = Int(String.init(cString: sqlite3_column_text(declaracion, 5)))!
                arrStats.constitution = Int(String.init(cString: sqlite3_column_text(declaracion, 3)))!
                arrStats.strength = Int(String.init(cString: sqlite3_column_text(declaracion, 1)))!
                arrStats.dexterity = Int(String.init(cString: sqlite3_column_text(declaracion, 2)))!
                arrStats.intelligence = Int(String.init(cString: sqlite3_column_text(declaracion, 4)))!
                arrStats.charisma = Int(String.init(cString: sqlite3_column_text(declaracion, 6)))!
                arrStats.hitdice = Int(String.init(cString: sqlite3_column_text(declaracion, 12)))!
                arrStats.nombre = String.init(cString: sqlite3_column_text(declaracion, 0))
                
            }
        }
    }
}
