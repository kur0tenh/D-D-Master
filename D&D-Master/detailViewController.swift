//
//  detailViewController.swift
//  D&D-Master
//
//  Created by Ángel Escobar Márquez on 10/05/17.
//  Copyright © 2017 Ángel Escobar Márquez. All rights reserved.
//

import Foundation
import UIKit
class DetailViewController: UIViewController  {
    @IBOutlet weak var trait10: UILabel!
    @IBOutlet weak var trait20: UILabel!
    @IBOutlet weak var idealo: UILabel!
    @IBOutlet weak var flawo: UILabel!
    @IBOutlet weak var gendero: UILabel!
    @IBOutlet weak var featureo: UILabel!
    @IBOutlet weak var proficiencieso: UITextView!
    @IBOutlet weak var languageso: UITextView!
    @IBOutlet weak var spellso: UITextView!
    @IBOutlet weak var skillso: UITextView!
    var proficiencias = ""
    var languages = ""
    var skills = ""
    var spells = ""
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
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    
    override func viewDidLoad() {
        _ = abrirBaseDatos()
        self.hideKeyboardWhenTappedAround()
        trait10.text = "Trait one: " + arrStats.trait1
        trait20.text = "Trait two: " + arrStats.trait2
        idealo.text = "Ideal: " + arrStats.ideal
        flawo.text = "Flaw: " + arrStats.flaw
        featureo.text = "Feature: " + arrStats.feature
        proficiencieso.text = "Proficiencies: "+arrStats.proficiencies
        languageso.text = "Languages: "+arrStats.languages
        spellso.text = "Spells: "+arrStats.spells
        skillso.text = "Skills: "+arrStats.skills
        gendero.text = "Gender: "+arrStats.sexo
        proficiencias = proficiencieso.text
        languages = languageso.text
        skills = skillso.text
        spells = spellso.text
        }
    
    @IBAction func updateProficiencies(_ sender: Any) {
        let sqlInserta = "UPDATE personaje SET  proficiencias = '\(proficiencias)' WHERE nombre = '\(arrStats.nombre)'"
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) != SQLITE_OK {
            
            print("Error al insertar datos)")
        }else{
            print("todo bien")
            
        }
    }
    
    
    @IBAction func updateLanguages(_ sender: Any) {
        let sqlInserta = "UPDATE personaje SET  lenguajes = '\(languages)' WHERE nombre = '\(arrStats.nombre)'"
        print(sqlInserta)
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) != SQLITE_OK {
            
            print("Error al insertar datos)")
        }else{
            print("todo bien")
            
        }
    }
    
    @IBAction func updateSkills(_ sender: Any) {
        print(skillso.text)
        let sqlInserta = "UPDATE personaje SET  skills = '\(skills)' WHERE nombre = '\(arrStats.nombre)'"
        print(sqlInserta)
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) != SQLITE_OK {
            
            print("Error al insertar datos)")
        }else{
            print("todo bien")
            
        }
    }
    
    @IBAction func updateSpells(_ sender: Any) {
        let sqlInserta = "UPDATE personaje SET  spells = '\(spells)' WHERE nombre = '\(arrStats.nombre)'"
        
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) != SQLITE_OK {
            
            print("Error al insertar datos)")
        }else{
            print("todo bien")
        }
    }
}
