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
    static var selected = ""
}
class MainViewController: UITableViewController{
    
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
        let sqlCreaTabla = "create table clases(nombre varchar(20),hitdice integer,diceroll integer,skillnumber integer, proficiencias varchar(100), equipo varchar(100), savingthrows varchar(100)); create table razas(nombre varchar(20), str integer, dex integer, cons integer, intell integer, wis integer , charisma integer,lenguajes varchar(100),vision varchar(20),tamano varchar(20),speed integer,proficiencias varchar(100)); create table subclases(nombre varchar(20),sobreclase varchar(20)); create table background(nombre varchar(20),skills varchar(100),lenguajes varchar(100), equipo varchar(100), dinero varchar(100)); create table personaje(numero integer, nombre varchar(20), raza varchar(20), clase varchar(20), subclase varchar(20), background varchar(100), str integer, dex integer, cons integer, intell integer, wis integer, charisma integer, nivel integer, experiencia integer, siguiente integer, campaña varchar(20), region varchar(20), tamaño varchar(20), feature varchar(20), pt1 varchar(20), pt2 varchar(20), ideal varchar (20), flaw varchar (20), gender varchar(20), skills varchar(200), lenguajes varchar(100), dinero varchar(100));"
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
        let sqlInserta = "INSERT INTO clases (nombre, hitdice, diceroll,skillnumber,proficiencias,equipo,savingthrows) VALUES ('Fighter',10,10,2,'all armor-shields-simple weapons-martial weapons','chain mail-long sword-shield-light crossbow, 20 bolts,dungeonier pack','strenght-constitution'); INSERT INTO subclases (nombre,sobreclase) VALUES ('champion','Fighter'); INSERT INTO subclases (nombre,sobreclase) VALUES ('battle master','Fighter'); INSERT INTO subclases (nombre,sobreclase) VALUES ('eldrich knight','Fighter'); INSERT INTO clases (nombre, hitdice, diceroll,skillnumber,proficiencias,equipo,savingthrows) VALUES ('Barbarian',12,12,2,'Light armor-Midium armor-shields-simple weapons-martial weapons','great axe-two handaxes-explorer pack-two javelins','strenght-constitution'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Berserker','Barbarian'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Bear','Barbarian'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Eagle','Barbarian'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Wolf','Barbarian'); INSERT INTO clases (nombre, hitdice, diceroll,skillnumber,proficiencias,equipo,savingthrows) VALUES ('Monk',8,8,2,'simple weapons-short swords','short sword-dungeonier pack-10 darts','strenght-dexterity'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Way of the open hand','Monk'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Way of shadow','Monk'); INSERT INTO subclases (nombre,sobreclase) VALUES ('Way of the four elements','Monk'); INSERT INTO clases (nombre, hitdice, diceroll,skillnumber,proficiencias,equipo,savingthrows) VALUES ('Rogue',8,8,4,'light armor-simple weapons-short swords-long swords-rapier-hand crossbow-thieve tools','rapier-short bow-20 arrows-burglars pack-leather armor-2 daggers-thief tools','strenght-Intelligence'); INSERT INTO subclases (nombre,sobreclase) VALUES ('thief','Rogue'); INSERT INTO subclases (nombre,sobreclase) VALUES ('assassin','Rogue'); INSERT INTO subclases (nombre,sobreclase) VALUES ('arcane trickster','Rogue'); INSERT INTO clases (nombre, hitdice, diceroll,skillnumber,proficiencias,equipo,savingthrows) VALUES ('Paladin',10,10,2,'all armor-shields-simple weapons-martial weapons-','long sword-shield-5 javelins-priest pack-chain mail-holy symbol','wisdom-charisma'); INSERT INTO subclases (nombre,sobreclase) VALUES ('devotion','Paladin'); INSERT INTO subclases (nombre,sobreclase) VALUES ('ancients','Paladin'); INSERT INTO subclases (nombre,sobreclase) VALUES ('vengance','Paladin'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias,) VALUES ('mountain dwarf'2,0,0,2,0,0,0,0,'common-dwarvish','dark vision 60 feat','medium',25,'battle axe-hand axe-throwing hammer-war hammer-smith tools-light armor-medium armor'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias,) VALUES ('hill dwarf'0,0,0,2,0,1,0,0,'common-dwarvish','dark vision 60 feat','medium',25,'battle axe-hand axe-throwing hammer-war hammer-smith tools'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias,) VALUES ('high elf'0,2,0,1,0,0,0,0,'common-elvish','dark vision 60 feat','medium',30,'perseption-long sword-short sword-long bow-short-bow'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias,) VALUES ('wood elf'0,2,0,0,1,0,0,0,'common-elvish','dark vision 60 feat','medium',35,'perseption-long sword-short sword-long bow-short-bow'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias,) VALUES ('dark elf'0,2,0,0,0,1,0,0,'common-elvish','dark vision 60 feat','medium',120,'perseption-rapier-short sword-hand crossbow'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('human',1,1,1,1,1,1,1,1,'common','','medium',20,''); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('black dragon',0,2,0,0,0,0,0,1,'common-draconic','','medium',30,'acid dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('blue dragon',0,2,0,0,0,0,0,1,'common-draconic','','medium',30,'lightning dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('brass dragon',0,2,0,0,0,0,0,1,'common-draconic','','medium',30,'fire dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('bronce dragon',0,2,0,0,0,0,0,1,'common-draconic','','medium',30,'lightning dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('copper dragon',0,2,0,0,0,0,0,1,'common-draconic','','medium',30,'acid dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('gold dragon',0,2,0,0,0,0,0,1,'common-draconic','','medium',30,'fire dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('green dragon',0,2,0,0,0,0,0,1,'common-draconic','','medium',30,'poison con'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('red dragon',0,2,0,0,0,0,0,1,'common-draconic','','medium',30,'fire dex'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('silver dragon',0,2,0,0,0,0,0,1,'common-draconic','','medium',30,'cold con'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('white dragon',0,2,0,0,0,0,0,1,'common-draconic','','medium',30,'cold con'); INSERT INTO razas (nombre,str,dex,cons,intell,wis,charisma,lenguajes,vision,tamano,speed,proficiencias) VALUES ('tieflings',0,0,0,0,0,1,0,2,'common-infernal','dark vision 60','medium',30,''); INSERT INTO background (nombre,skills,lenguajes,equipo,dinero) VALUES ('guild artesan','insight-persuation','one of choice','artisan tools-letter of introduction-travelers clothes','15 gold'); INSERT INTO background (nombre,skills,lenguajes,equipo,dinero) VALUES ('charlatan','deception-sleight of Hand','','fine clothes-disguise kit-weighted dice','15 gold'); INSERT INTO background (nombre,skills,lenguajes,equipo,dinero) VALUES ('acolyte','insight-religion','two of choice','holy symbol-prayer book-5 sticks of incense-vestments-common clothes-belt ','15 gold'); INSERT INTO background (nombre,skills,lenguajes,equipo,dinero) VALUES ('criminal','deception-stealth','','crow bar-dark comon clothes-hood','15 gold');"
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) != SQLITE_OK {
            print("Error al insertar datos)")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            consultarClases()
            arrClases.selected = "clases"
            print("swag")
        }
    }
    
    
    func consultarClases() {
        let sqlConsulta = "SELECT * FROM clases"
        print("aqui")
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
        
        abrirBaseDatos()
        
        if(UserDefaults.standard.bool(forKey: "HasLaunchedOnce"))
        {
            // app already launched
        }
        else
        {
            crearTabla()
            insertarDatos()
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
        }
        
        consultarClases()
            print("yolo")
        }

}
