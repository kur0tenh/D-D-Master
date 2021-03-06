
import UIKit

class PickerController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var arrAtributes = arrClases.lolClases
    var celda = 0
    @IBOutlet weak var pvPaises: UIPickerView!
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    @IBAction func Accept(_ sender: Any) {
        
        
        print(arrClases.selected)
        arrClases.celda?.detailTextLabel?.text = arrAtributes[celda]
        if arrClases.selected == 1{
            arrClases.Raza = arrAtributes[celda]

        }
        if arrClases.selected == 2{
            arrClases.Clase = arrAtributes[celda]
        }
        if arrClases.selected == 3{
            if arrClases.subclassMight
            {
                arrClases.Subclase = arrAtributes[celda]
            }
        }
        if arrClases.selected == 4{
            arrClases.Background = arrAtributes[celda]
        }
        if arrClases.selected == 5{
            arrClases.strength = Int(arrAtributes[celda])!
        }
        if arrClases.selected == 6{
            arrClases.dexterity = Int(arrAtributes[celda])!
        }
        if arrClases.selected == 7{
            arrClases.constitution = Int(arrAtributes[celda])!
        }
        if arrClases.selected == 8{
            arrClases.intelligence = Int(arrAtributes[celda])!
        }
        if arrClases.selected == 9{
            arrClases.wisdom = Int(arrAtributes[celda])!
        }
        if arrClases.selected == 10{
            arrClases.charisma = Int(arrAtributes[celda])!
        }
        if arrClases.selected == 11{
            arrClases.nivel = Int(arrAtributes[celda])!
        }
        if arrClases.selected == 12{
            if arrClases.skillMight{
                arrClases.skill1 = arrAtributes[celda]}
        }
        if arrClases.selected == 13{
            if arrClases.skillMight{
                arrClases.skill2 = arrAtributes[celda]}
        }
        if arrClases.selected == 14{
            if arrClases.skillMight{
                arrClases.skill3 = arrAtributes[celda]}
        }
        if arrClases.selected == 15{
            if arrClases.skillMight{
                arrClases.skill4 = arrAtributes[celda]}
        }
        if arrClases.selected == 100{
            arrStatSelected.strength = Int(arrAtributes[celda])!
            arrClases.stastSeleccionados.append(arrAtributes[celda])
        }
        if arrClases.selected == 110{
            arrStatSelected.constitution = Int(arrAtributes[celda])!
            arrClases.stastSeleccionados.append(arrAtributes[celda])
        }
        if arrClases.selected == 120{
            arrStatSelected.dexterity = Int(arrAtributes[celda])!
            arrClases.stastSeleccionados.append(arrAtributes[celda])
        }
        if arrClases.selected == 130{
            arrStatSelected.intelligence = Int(arrAtributes[celda])!
            arrClases.stastSeleccionados.append(arrAtributes[celda])
        }
        if arrClases.selected == 140{
            arrStatSelected.wisdom = Int(arrAtributes[celda])!
            arrClases.stastSeleccionados.append(arrAtributes[celda])
        }
        if arrClases.selected == 150{
            arrStatSelected.charisma = Int(arrAtributes[celda])!
            arrClases.stastSeleccionados.append(arrAtributes[celda])
        }

        
        self.dismiss(animated: true, completion: nil)

    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        return false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrAtributes.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        celda = row
        print(arrAtributes[row])
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        arrAtributes = arrClases.lolClases
        
        return arrAtributes[row]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(arrClases.lolClases)")
        self.pvPaises.dataSource = self
        self.pvPaises.delegate = self
    }
}
