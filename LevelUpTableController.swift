
//  D&D-Master
//
//  Created by Angel Escobar on 21/03/17.
//  Copyright © 2017 Ángel Escobar Márquez. All rights reserved.
//

import UIKit

struct arrStatSelected {
    static var selected = 0
    static var strength = 0
    static var dexterity = 0
    static var constitution = 0
    static var intelligence = 0
    static var wisdom = 0
    static var charisma = 0
    static var nivel = 1
    static var hitdice = 0
}

class LevelUpTableController: UITableViewController{
    
    var str = 0
    var wis = 0
    var char = 0
    var cons = 0
    var int = 0
    var dex = 0
    var hit = 0
    var level = 0
    
    var baseDatos: OpaquePointer? = nil
    func obtenerPath(_	salida:	String)	->	URL?	{
        if let path =	FileManager.default.urls(for:	.documentDirectory,	in:	.userDomainMask).first {
            print(path)
            return path.appendingPathComponent(salida)
        }
        return nil
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
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
    
    func statsNivel(){
        if arrClases.stastSeleccionados.contains("2"){
            arrClases.lolClases = ["0","0"]
        }
        else if arrClases.stastSeleccionados.contains("1"){
            arrClases.lolClases = ["1","0"]
        }
        else{
            arrClases.lolClases = ["2","1","0"]

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrClases.celda = tableView.cellForRow(at: indexPath)
        statsNivel()
        if indexPath.row == 0 {
            arrClases.selected = 100
            statsNivel()
        }
        else if indexPath.row == 1{
            arrClases.selected = 110
        }
        if indexPath.row == 2{
            arrClases.selected = 120
        }
        if indexPath.row == 3{
            arrClases.selected = 130
        }
        if indexPath.row == 4{
            arrClases.selected = 140
        }
        if indexPath.row == 5{
            arrClases.selected = 150
        }
    }
    
    func sumar(){
        str = arrStatSelected.strength + arrStats.strength
        wis = arrStatSelected.wisdom + arrStats.wisdom
        char = arrStatSelected.charisma + arrStats.charisma
        int = arrStatSelected.intelligence + arrStats.intelligence
        cons = arrStatSelected.constitution + arrStats.constitution + 1
        dex = arrStatSelected.dexterity + arrStats.dexterity
        hit = arrStats.hitdice + 1
        level = arrStats.nivel + 1
    }

    @IBAction func Aceptar(_ sender: Any) {
        sumar()
        let nombre = arrStats.nombre
        let sqlInserta = "UPDATE personaje SET  str = \(str), dex = \(dex), wis = \(wis),charisma = \(char),intell = \(int), cons = \(cons), hitdice = \(hit),nivel = '\(level)' WHERE nombre = '\(nombre)'"
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) != SQLITE_OK {
            
            print("Error al insertar datos)")
        }else{
            print("todo bien")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrClases.lolClases = ["2","1","0"]
        arrClases.stastSeleccionados = []
        _ = abrirBaseDatos()
        self.hideKeyboardWhenTappedAround()
        print("")
    }
    
    
}
