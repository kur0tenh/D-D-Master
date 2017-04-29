
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
        if arrClases.selected == 1{
            arrClases.Raza = arrAtributes[celda]
        }
        if arrClases.selected == 2{
            arrClases.Clase = arrAtributes[celda]
        }
        if arrClases.selected == 3{
            arrClases.Subclase = arrAtributes[celda]
        }
        if arrClases.selected == 4{
            arrClases.Background = arrAtributes[celda]
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
