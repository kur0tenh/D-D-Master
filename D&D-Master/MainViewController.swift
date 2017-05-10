//
//  MainViewController.swift
//  D&D-Master
//
//  Created by Angel Escobar on 21/03/17.
//  Copyright © 2017 Ángel Escobar Márquez. All rights reserved.
//

import UIKit
struct arrClases {
    static var stastSeleccionados = [String]()
    static var lolClases = [String]()
    static var subclases = [String]()
    static var selected = 0
    static var Raza = ""
    static var Clase = ""
    static var Subclase = ""
    static var Background = ""
    static var strength = 0
    static var dexterity = 0
    static var constitution = 0
    static var intelligence = 0
    static var wisdom = 0
    static var charisma = 0
    static var nivel = 1
    static var skill1 = ""
    static var skill2 = ""
    static var skill3 = ""
    static var skill4 = ""
    static var skillMight = true
    static var subclassMight = false
    static var celda: UITableViewCell? = nil
 
}
class MainViewController: UITableViewController{
   
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var campaign: UITextField!
    @IBOutlet weak var sex: UISegmentedControl!
    @IBOutlet weak var flaw: UILabel!
    @IBOutlet weak var ideal: UITextField!
    @IBOutlet weak var traittwo: UITextField!
    @IBOutlet weak var traitone: UITextField!
    @IBOutlet weak var feature: UITextField!
    @IBOutlet weak var region: UITextField!
    var baseDatos: OpaquePointer? = nil
    //var celda: UITableViewCell? = nil
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrClases.celda = tableView.cellForRow(at: indexPath)
        if indexPath.row == 2 {
            consultarClases()
            arrClases.selected = 2
            
        }
        else if indexPath.row == 3{
            consultarSubclases()
            arrClases.selected = 3
        }
        if indexPath.row == 4{
            consultarBackground()
            arrClases.selected = 4
        }
        if indexPath.row == 1{
            consultarRazas()
            arrClases.selected = 1
        }
        if indexPath.row == 5{
            statsMaximos()
            arrClases.selected = 5
        }
        if indexPath.row == 6{
            statsMaximos()
            arrClases.selected = 6
        }
        if indexPath.row == 7{
            statsMaximos()
            arrClases.selected = 7
        }
        if indexPath.row == 8{
            statsMaximos()
            arrClases.selected = 8
        }
        if indexPath.row == 9{
            statsMaximos()
            arrClases.selected = 9
        }
        if indexPath.row == 10{
            statsMaximos()
            arrClases.selected = 10
        }
        if indexPath.row == 11{
            niveles()
            arrClases.selected = 11
        }
        if indexPath.row == 12{
            skills(number: 1)
            arrClases.selected = 12
        }
        if indexPath.row == 13{
            skills(number: 2)
            arrClases.selected = 13
        }
        if indexPath.row == 14{
            skills(number:3)
            arrClases.selected = 14
        }
        if indexPath.row == 15{
            skills(number: 4)
            arrClases.selected = 15
        }
    }
    
    @IBOutlet weak var SelectionClass: UILabel!
    func consultarClases() {
        let sqlConsulta = "SELECT * FROM clases"
        var declaracion: OpaquePointer? = nil
        var nombres = [String]()
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK {
            var i = 0
            while sqlite3_step(declaracion) == SQLITE_ROW  {
                let nombre = String.init(cString: sqlite3_column_text(declaracion, 0))
                nombres.append(nombre)
                print(nombre)
                i = i+1
            }
            i = 0
            arrClases.lolClases = nombres
            print("\(arrClases.lolClases)")
        }
    }
    
    func consultarSubclases() {
        let sqlConsulta = "SELECT * FROM subclases WHERE sobreclase="+"\""+arrClases.Clase+"\""
        print(sqlConsulta)
        var declaracion: OpaquePointer? = nil
        var nombres = [String]()
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK {
            var i = 0
            while sqlite3_step(declaracion) == SQLITE_ROW  {
                let nombre = String.init(cString: sqlite3_column_text(declaracion, 0))
                print("aqui")
                nombres.append(nombre)
                print(nombre)
                i = i+1
                arrClases.subclassMight = true
            }
            if arrClases.Clase == ""{
                nombres.append("selecciona una clase primero")
                nombres.append("")
                arrClases.subclassMight = false
            }
            i = 0
            arrClases.lolClases = nombres
            print("\(arrClases.lolClases)")
        }
    }
    
    func consultarBackground() {
        let sqlConsulta = "SELECT * FROM background"
        print(sqlConsulta)
        var declaracion: OpaquePointer? = nil
        var nombres = [String]()
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK {
            var i = 0
            while sqlite3_step(declaracion) == SQLITE_ROW  {
                let nombre = String.init(cString: sqlite3_column_text(declaracion, 0))
                print("aqui")
                nombres.append(nombre)
                print(nombre)
                i = i+1
            }
            i = 0
            arrClases.lolClases = nombres
            print("\(arrClases.lolClases)")
        }
    }
    func consultarRazas() {
        let sqlConsulta = "SELECT * FROM razas"
        print(sqlConsulta)
        var declaracion: OpaquePointer? = nil
        var nombres = [String]()
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK {
            var i = 0
            while sqlite3_step(declaracion) == SQLITE_ROW  {
                let nombre = String.init(cString: sqlite3_column_text(declaracion, 0))
                print("aqui")
                nombres.append(nombre)
                print(nombre)
                i = i+1
            }
            i = 0
            arrClases.lolClases = nombres
            print("\(arrClases.lolClases)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = abrirBaseDatos()
        self.hideKeyboardWhenTappedAround()
        /*
        if(UserDefaults.standard.bool(forKey: "HasLaunchedOnce"))
        {
            // app already launched
        }
        else
        {
            _ = crearTabla()
            insertarDatos()
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
        }
        */
        consultarClases()
        
            print("")
        }
 
    func statsMaximos(){
        var nombres = [String]()
        nombres.append("\(0)")
        if !((arrClases.strength == 15) || (arrClases.dexterity == 15) || (arrClases.charisma == 15) || (arrClases.wisdom == 15) || (arrClases.intelligence == 15) || (arrClases.constitution == 15)){
            nombres.append("15")
        }
        if !((arrClases.strength == 14) || (arrClases.dexterity == 14) || (arrClases.charisma == 14) || (arrClases.wisdom == 15) || (arrClases.intelligence == 14) || (arrClases.constitution == 14)){
            nombres.append("14")
        }
        if !((arrClases.strength == 13) || (arrClases.dexterity == 13) || (arrClases.charisma == 13) || (arrClases.wisdom == 13) || (arrClases.intelligence == 13) || (arrClases.constitution == 13)){
            nombres.append("13")
        }
        if !((arrClases.strength == 12) || (arrClases.dexterity == 12) || (arrClases.charisma == 12) || (arrClases.wisdom == 12) || (arrClases.intelligence == 12) || (arrClases.constitution == 12)){
            nombres.append("12")
        }
        if !((arrClases.strength == 10) || (arrClases.dexterity == 10) || (arrClases.charisma == 10) || (arrClases.wisdom == 15) || (arrClases.intelligence == 10) || (arrClases.constitution == 10)){
            nombres.append("10")
        }
        if !((arrClases.strength == 8) || (arrClases.dexterity == 8) || (arrClases.charisma == 8) || (arrClases.wisdom == 8) || (arrClases.intelligence == 8) || (arrClases.constitution == 8)){
            nombres.append("8")
        }
        nombres.append("\(0)")
        arrClases.lolClases = nombres
    }
    
    func sumarVariables(){
        arrClases.strength = arrClases.strength + addstat(stat: "str")
        arrClases.dexterity = arrClases.dexterity + addstat(stat: "dex")
        arrClases.constitution = arrClases.constitution + addstat(stat: "cons")
        arrClases.intelligence = arrClases.intelligence + addstat(stat: "intell")
        arrClases.wisdom = arrClases.wisdom + addstat(stat: "wis")
        arrClases.charisma = arrClases.charisma + addstat(stat: "charisma")
    }
    func niveles(){
        var nombres = [String]()
        var i = 0
        while i < 20{
            i = i + 1
            nombres.append("\(i)")
        }
        arrClases.lolClases = nombres
    }
    
    func addstat(stat: String) -> Int
    {
        var st = "0"
        let sqlConsulta = "SELECT \(stat) FROM razas WHERE nombre = '\(arrClases.Raza)'"
        print (sqlConsulta)
        var declaracion: OpaquePointer? = nil
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK
        {
            while sqlite3_step(declaracion) == SQLITE_ROW
            {
                st = String.init(cString: sqlite3_column_text(declaracion, 0))
                print(st)
            }
        }
        return Int(st)!
    }
    
    func skills(number: Int){
        var st = 0
        var nombres = [String]()
        let sqlConsulta = "SELECT * FROM clases WHERE nombre = '\(arrClases.Clase)'"
        print (sqlConsulta)
        var declaracion: OpaquePointer? = nil
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK
        {
            while sqlite3_step(declaracion) == SQLITE_ROW
            {
                st = Int(String.init(cString: sqlite3_column_text(declaracion, 3)))!
                
            }
        }
        if number <= st{
            nombres.append("Acrobatics")
            nombres.append("Sleight of hand")
            nombres.append("Stealth")
            nombres.append("Arcana")
            nombres.append("History")
            nombres.append("Investigation")
            nombres.append("Nature")
            nombres.append("Religion")
            nombres.append("Animal Handling")
            nombres.append("Insight")
            nombres.append("Medicine")
            nombres.append("Perception")
            nombres.append("Survival")
            nombres.append("Deception")
            nombres.append("Intimidation")
            nombres.append("Performance")
            nombres.append("Persuacion")
            arrClases.skillMight = true
        }else
        {
            nombres.append(" ")
            nombres.append("\(arrClases.Clase) class only have \(st) skill ponts")
            arrClases.skillMight = false
        }
        arrClases.lolClases = nombres
    }
    @IBAction func crearPersona(_ sender: Any)
    {
        let experiences = [0,300,900,2700,6500,14000,23000,34000,48000,64000,85000.100000,120000,140000,165000,195000,225000,265000,305000,355000]
        sumarVariables()
        let nombre = name.text!
        let str = arrClases.strength
        let dex =  arrClases.dexterity
        let cons = arrClases.constitution
        let intell = arrClases.intelligence
        let wis = arrClases.wisdom
        let charisma = arrClases.charisma
        var lenguajes = ""
        var vision = ""
        var tamano = ""
        var speed = ""
        var proficiencias = ""
        var hitdice = "0"
        var diceroll = "0"
        var skillnumber = "0"
        var equipo = ""
        var savingtrhows = ""
        let clase = arrClases.Clase
        let subclase = arrClases.Subclase
        let raza = arrClases.Raza
        let background = arrClases.Background
        let nivel = arrClases.nivel
        var skills = ("\(arrClases.skill1)-\(arrClases.skill2)-\(arrClases.skill3)-\(arrClases.skill4)")
        let reg = region.text!
        let feat = feature.text!
        let trait1 = traitone.text!
        let trait2 = traittwo.text!
        let idea = ideal.text!
        let fla = flaw.text!
        let sexo = sex.titleForSegment(at: sex.selectedSegmentIndex)!
        let sqlConsulta = "SELECT * FROM razas Where nombre = '\(arrClases.Raza)'"
        var declaracion: OpaquePointer? = nil
        let exp = experiences[nivel-1]
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK
        {
            while sqlite3_step(declaracion) == SQLITE_ROW
            {
                lenguajes = lenguajes+"-"+String.init(cString: sqlite3_column_text(declaracion, 7))
                vision = String.init(cString: sqlite3_column_text(declaracion, 8))
                tamano = String.init(cString: sqlite3_column_text(declaracion, 9))
                speed = String.init(cString: sqlite3_column_text(declaracion, 10))
                proficiencias = String.init(cString: sqlite3_column_text(declaracion, 11))
            }
        }
        let sqlConsulta2 = "SELECT * FROM clases Where nombre = '\(arrClases.Clase)'"
        var declaracion2: OpaquePointer? = nil
        if sqlite3_prepare_v2(baseDatos, sqlConsulta2, -1, &declaracion2, nil) == SQLITE_OK
        {
            while sqlite3_step(declaracion2) == SQLITE_ROW
            {
                hitdice = String.init(cString: sqlite3_column_text(declaracion2, 1))
                diceroll = String.init(cString: sqlite3_column_text(declaracion2, 2))
                skillnumber = String.init(cString: sqlite3_column_text(declaracion2, 3))
                proficiencias = proficiencias+"-"+String.init(cString: sqlite3_column_text(declaracion2, 4))
                equipo = equipo+"-"+String.init(cString: sqlite3_column_text(declaracion2, 5))
                savingtrhows = String.init(cString: sqlite3_column_text(declaracion2, 6))

            }
        }
        let sqlConsulta3 = "SELECT * FROM background Where nombre = '\(arrClases.Background)'"
        var declaracion3: OpaquePointer? = nil
        if sqlite3_prepare_v2(baseDatos, sqlConsulta3, -1, &declaracion3, nil) == SQLITE_OK
        {
            while sqlite3_step(declaracion3) == SQLITE_ROW
            {
                skills = skills+"-"+String.init(cString: sqlite3_column_text(declaracion3, 1))
                lenguajes = lenguajes+"-"+String.init(cString: sqlite3_column_text(declaracion3, 2))
                equipo = equipo+"-"+String.init(cString: sqlite3_column_text(declaracion3, 3))
                equipo = equipo+"-"+String.init(cString: sqlite3_column_text(declaracion3, 4))
                
            }
        }
        let sqlInserta = "INSERT INTO personaje (nombre, str, dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias,hitdice,diceroll,skillnumber,equipo,savingthrows,clase,subclase,raza,background,nivel,skills,exp,region,feature,trait1,trait2,ideal,flaw,sexo,spells) VALUES ('\(nombre)',\(str),\(dex),\(cons),\(intell),\(wis),\(charisma),'\(lenguajes)','\(vision)','\(tamano)','\(speed)','\(proficiencias)',\(hitdice),\(diceroll),\(skillnumber),'\(equipo)','\(savingtrhows)','\(clase)','\(subclase)','\(raza)','\(background)','\(nivel)','\(skills)','\(exp)','\(reg)','\(feat)','\(trait1)','\(trait2)','\(idea)','\(fla)','\(sexo)',' ');"
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) != SQLITE_OK {
            let controller = UIAlertController(title: "Couldn't create character", message: "Some of the attributes are wrong", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(ok)
            present(controller, animated: true, completion: nil)
            print("Error al insertar datos)")
        }else{
            print("todo bien")
            
        }
    
    }
}
