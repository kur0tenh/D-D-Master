
import UIKit

class PickerController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let arrAtributes = arrClases.lolClases
    
    @IBAction func regresar(sender: UIStoryboardSegue){
        print("regresando...")
    }
    @IBOutlet weak var pvPaises: UIPickerView!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
        print(arrAtributes[row])
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrAtributes[row]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("lel")
        //print("\(arrClases.lolClases)")
        self.pvPaises.dataSource = self
        self.pvPaises.delegate = self
    }
}
