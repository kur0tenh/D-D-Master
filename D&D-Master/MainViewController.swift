//
//  MainViewController.swift
//  D&D-Master
//
//  Created by Angel Escobar on 21/03/17.
//  Copyright © 2017 Ángel Escobar Márquez. All rights reserved.
//

import UIKit
struct arrClases {
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

}
class MainViewController: UITableViewController{
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var campaign: UITextField!
    @IBOutlet weak var experence: UITextField!
    @IBOutlet weak var sex: UISegmentedControl!
    @IBOutlet weak var flaw: UILabel!
    @IBOutlet weak var ideal: UITextField!
    @IBOutlet weak var traittwo: UITextField!
    @IBOutlet weak var traitone: UITextField!
    @IBOutlet weak var feature: UITextField!
    @IBOutlet weak var region: UITextField!
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
    func crearTabla() -> Bool {
        let sqlCreaTabla = "create table clases(nombre varchar(20),hitdice integer,diceroll integer,skillnumber integer, proficiencias varchar(1000), equipo varchar(1000), savingthrows varchar(1000)); create table razas(nombre varchar(20), str integer, dex integer, cons integer, intell integer, wis integer , charisma integer,lenguajes varchar(1000),vision varchar(20),tamano varchar(20),speed integer,proficiencias varchar(1000)); create table subclases(nombre varchar(20),sobreclase varchar(20)); create table background(nombre varchar(20),skills varchar(1000),lenguajes varchar(1000), equipo varchar(1000), dinero varchar(1000)); create table monstruos(nombre varchar(20),descripcion varchar(1000),imagen varchar(1000)); create table hechizos(nombre varchar(20),descripcion varchar(1000),imagen varchar(1000)); create table personaje(nombre varchar(20), str integer, dex integer, cons integer, intell integer, wis integer , charisma integer, lenguajes varchar(1000), vision varchar(1000), tamano varchar(1000), speed integer, proficiencias varchar(1000), hitdice integer, diceroll integer, skillnumber integer, equipo varchar(1000), savingthrows varchar(10000), clase varchar(20), subclase varchar(20), raza varchar(20), background varchar(20), nivel varchar(20), skills varchar(1000), exp integer, region varchar(1000), feature varchar(1000), trait1 varchar(1000), trait2 varchar(1000), ideal varchar(1000), flaw varchar(1000), sexo varchar(20));"
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlCreaTabla, nil, nil, &error) == SQLITE_OK {
            return true
        } else {
            sqlite3_close(baseDatos)
            let msg = String.init(cString: error!)
            print("Error: \(msg)")
            return false
        }
    }
    
    func insertarDatos() {
        let sqlInserta = "INSERT INTO clases (nombre, hitdice, diceroll,skillnumber,proficiencias,equipo,savingthrows) VALUES ('Fighter',10,10,2,'all armor-shields-simple weapons-martial weapons','chain mail-long sword-shield-light crossbow, 20 bolts,dungeonier pack','strenght-constitution'); INSERT INTO subclases (nombre,sobreclase) VALUES ('champion','Fighter'); INSERT INTO subclases (nombre,sobreclase) VALUES ('battle master','Fighter'); INSERT INTO subclases (nombre,sobreclase) VALUES ('eldrich knight','Fighter'); INSERT INTO clases (nombre, hitdice, diceroll,skillnumber,proficiencias,equipo,savingthrows) VALUES ('Barbarian',12,12,2,'Light armor-Midium armor-shields-simple weapons-martial weapons','great axe-two handaxes-explorer pack-two javelins','strenght-constitution'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Berserker','Barbarian'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Bear','Barbarian'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Eagle','Barbarian'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Wolf','Barbarian'); INSERT INTO clases (nombre, hitdice, diceroll,skillnumber,proficiencias,equipo,savingthrows) VALUES ('Monk',8,8,2,'simple weapons-short swords','short sword-dungeonier pack-10 darts','strenght-dexterity'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Way of the open hand','Monk'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Way of shadow','Monk'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Way of the four elements','Monk'); INSERT INTO clases (nombre, hitdice, diceroll,skillnumber,proficiencias,equipo,savingthrows) VALUES ('Rogue',8,8,4,'light armor-simple weapons-short swords-long swords-rapier-hand crossbow-thieve tools','rapier-short bow-20 arrows-burglars pack-leather armor-2 daggers-thief tools','strenght-Intelligence'); INSERT INTO subclases (nombre,sobreclase) VALUES ('thief','Rogue'); INSERT INTO subclases (nombre,sobreclase) VALUES ('assassin','Rogue'); INSERT INTO subclases (nombre,sobreclase) VALUES ('arcane trickster','Rogue'); INSERT INTO clases (nombre, hitdice, diceroll,skillnumber,proficiencias,equipo,savingthrows) VALUES ('Paladin',10,10,2,'all armor-shields-simple weapons-martial weapons-','long sword-shield-5 javelins-priest pack-chain mail-holy symbol','wisdom-charisma'); INSERT INTO subclases (nombre,sobreclase) VALUES ('devotion','Paladin'); INSERT INTO subclases (nombre,sobreclase) VALUES ('ancients','Paladin'); INSERT INTO subclases (nombre,sobreclase) VALUES ('vengance','Paladin'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('mountain dwarf',2,0,0,2,0,0,'common-dwarvish','dark vision 60 feat','medium',25,'battle axe-hand axe-throwing hammer-war hammer-smith tools-light armor-medium armor'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('hill dwarf',0,0,0,2,0,1,'common-dwarvish','dark vision 60 feat','medium',25,'battle axe-hand axe-throwing hammer-war hammer-smith tools'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('high elf',0,2,0,1,0,0,'common-elvish','dark vision 60 feat','medium',30,'perseption-long sword-short sword-long bow-short-bow'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('wood elf',0,2,0,0,1,0,'common-elvish','dark vision 60 feat','medium',35,'perseption-long sword-short sword-long bow-short-bow'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('dark elf',0,2,0,0,0,1,'common-elvish','dark vision 60 feat','medium',120,'perseption-rapier-short sword-hand crossbow'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('human',1,1,1,1,1,1,'common','','medium',20,''); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('black dragon',0,2,0,0,0,1,'common-draconic','','medium',30,'acid dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('blue dragon',0,2,0,0,0,1,'common-draconic','','medium',30,'lightning dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('brass dragon',0,2,0,0,0,1,'common-draconic','','medium',30,'fire dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('bronce dragon',0,2,0,0,0,1,'common-draconic','','medium',30,'lightning dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('copper dragon',0,2,0,0,0,1,'common-draconic','','medium',30,'acid dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('gold dragon',0,2,0,0,0,1,'common-draconic','','medium',30,'fire dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('green dragon',0,2,0,0,0,1,'common-draconic','','medium',30,'poison con'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('red dragon',0,2,0,0,0,1,'common-draconic','','medium',30,'fire dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('silver dragon',0,2,0,0,0,1,'common-draconic','','medium',30,'cold con'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('white dragon',0,2,0,0,0,1,'common-draconic','','medium',30,'cold con'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('tieflings',0,0,0,1,0,2,'common-infernal','dark vision 60','medium',30,''); INSERT INTO background (nombre,skills,lenguajes,equipo,dinero) VALUES ('guild artesan','insight-persuation','one of choice','artisan tools-letter of introduction-travelers clothes','15 gold'); INSERT INTO background (nombre,skills,lenguajes,equipo,dinero) VALUES ('charlatan','deception-sleight of Hand','','fine clothes-disguise kit-weighted dice','15 gold'); INSERT INTO background (nombre,skills,lenguajes,equipo,dinero) VALUES ('acolyte','insight-religion','two of choice','holy symbol-prayer book-5 sticks of incense-vestments-common clothes-belt ','15 gold'); INSERT INTO background (nombre,skills,lenguajes,equipo,dinero) VALUES ('criminal','deception-stealth','','crow bar-dark comon clothes-hood','15 gold');"
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) != SQLITE_OK {
            print("Error al insertar datos)")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        
        consultarClases()
            print("yolo")
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
        let subclase = arrClases.subclases
        let raza = arrClases.Raza
        let background = arrClases.Background
        let nivel = arrClases.nivel
        var skills = ("\(arrClases.skill1)-\(arrClases.skill2)-\(arrClases.skill3)-\(arrClases.skill4)")
        let exp = experence.text!
        let reg = region.text!
        let feat = feature.text!
        let trait1 = traitone.text!
        let trait2 = traittwo.text!
        let idea = ideal.text!
        let fla = flaw.text!
        let sexo = sex.titleForSegment(at: sex.selectedSegmentIndex)!
        let sqlConsulta = "SELECT * FROM razas Where nombre = '\(arrClases.Raza)'"
        var declaracion: OpaquePointer? = nil
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK
        {
            while sqlite3_step(declaracion) == SQLITE_ROW
            {
                lenguajes = lenguajes+"-"+String.init(cString: sqlite3_column_text(declaracion, 7))
                vision = String.init(cString: sqlite3_column_text(declaracion, 8))
                tamano = String.init(cString: sqlite3_column_text(declaracion, 9))
                speed = String.init(cString: sqlite3_column_text(declaracion, 10))
                proficiencias = proficiencias+"-"+String.init(cString: sqlite3_column_text(declaracion, 11))
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
        let sqlInserta = "INSERT INTO personaje (nombre, str, dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias,hitdice,diceroll,skillnumber,equipo,savingthrows,clase,subclase,raza,background,nivel,skills,exp,region,feature,trait1,trait2,ideal,flaw,sexo) VALUES ('\(nombre)',\(str),\(dex),\(cons),\(intell),\(wis),\(charisma),'\(lenguajes)','\(vision)','\(tamano)','\(speed)','\(proficiencias)',\(hitdice),\(diceroll),\(skillnumber),'\(equipo)','\(savingtrhows)','\(clase)','\(subclase)','\(raza)','\(background)','\(nivel)','\(skills)',\(exp),'\(reg)','\(feat)','\(trait1)','\(trait2)','\(idea)','\(fla)','\(sexo)');"
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) != SQLITE_OK {
            print("Error al insertar datos)")
        }else{
            print("todo bien")
        }
    
    }
}
