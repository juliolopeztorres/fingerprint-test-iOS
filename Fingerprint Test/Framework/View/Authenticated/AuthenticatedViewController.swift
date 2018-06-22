
import UIKit

class AuthenticatedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onBackBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
