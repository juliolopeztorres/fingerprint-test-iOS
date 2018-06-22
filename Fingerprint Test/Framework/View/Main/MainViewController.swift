
import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var usernameTV: UITextField!
    @IBOutlet weak var passwordTV: UITextField!
    
    var checkFingerprintSensorUseCase: CheckFingerprintSensorUseCase?
    var registerUseCase: RegisterUseCase?
    var checkUsernameStoredUseCase: CheckUsernameStoredUseCase?
    var loginWithFingerprintUseCase: LoginWithFingerprintUseCase?
    var loginUseCase: LoginUseCase?
    
    var canUseFingerprint = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.injectUseCases()
        
        self.usernameTV.delegate = self
        self.passwordTV.delegate = self
        
        self.checkFingerprintSensorUseCase?.check()
    }
    
    private func injectUseCases() -> Void {
        self.checkFingerprintSensorUseCase = CheckFingerprintSensorUseCase(with: self)
        self.registerUseCase = RegisterUseCase(with: self)
        self.checkUsernameStoredUseCase = CheckUsernameStoredUseCase(with: self)
        self.loginWithFingerprintUseCase = LoginWithFingerprintUseCase(with: self)
        self.loginUseCase = LoginUseCase(with: self)
    }
    
    private func goToAuthenticatedView() -> Void {
        self.present(AuthenticatedViewController(nibName: String(describing: AuthenticatedViewController.self), bundle: self.nibBundle), animated: true, completion: nil)
        self.clearUsernameAndPassword()
    }
    
    @IBAction func onRegisterBtnClicked(_ sender: Any) {
        if (self.registerUseCase?.register(username: self.usernameTV.text!, password: self.passwordTV.text!))! {
            self.goToAuthenticatedView()
        } else {
            self.showAlert(title: "Error", message: "Error registering the new user", successBtnTitle: "Close")
        }
    }
    
    @IBAction func onLoginBtnClicked(_ sender: Any) {
        if (self.canUseFingerprint) {
            self.loginWithFingerprintUseCase?.login()
            return
        }
        
        if ((self.loginUseCase?.login(username: self.usernameTV.text!, password: self.passwordTV.text!))!) {
            self.goToAuthenticatedView()
        } else {
            self.showAlert(title: "Error", message: "Username/Password incorrect", successBtnTitle: "Close")
        }
    }
    
    private func clearUsernameAndPassword() -> Void {
        self.usernameTV.text = ""
        self.passwordTV.text = ""
    }
    
    private func showFingerprintIcon() -> Void {
        DispatchQueue.main.async {
            (self.view.viewWithTag(1) as! UIImageView).isHidden = false
        }
    }
    
    private func hideFingerprintIcon() -> Void {
        DispatchQueue.main.async {
            (self.view.viewWithTag(1) as! UIImageView).isHidden = true
        }
    }
    
    private func showAlert(title: String, message: String, successBtnTitle: String) -> Void {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: successBtnTitle, style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

extension MainViewController: CheckFingerprintSensorUseCaseViewProtocol {
    func onCheckFingerprintSuccess() {
        self.checkUsernameStoredUseCase?.check()
    }
    
    func onCheckFingerprintError() {
        self.hideFingerprintIcon()
        self.canUseFingerprint = false
    }
}

extension MainViewController: RegisterUseCaseViewProtocol {}

extension MainViewController: CheckUsernameStoredUseCaseViewProtocol {
    func onCheckUsernameSuccess() {
        self.canUseFingerprint = true
        self.showFingerprintIcon()
    }
    
    func onCheckUsernameError() {}
}

extension MainViewController: LoginWithFingerprintUseCaseViewProtocol {
    func onLoginSuccess(recoveredPassword: String) {
        // TODO: Use recoveredPassword to log in via normal HTTPS request to your backend
        DispatchQueue.main.async {
            self.goToAuthenticatedView()
        }
    }
    
    func onLoginError(_ error: String) {
        self.hideFingerprintIcon()
        self.canUseFingerprint = false
        self.showAlert(title: "Error", message: error, successBtnTitle: "Close")
    }
}

extension MainViewController: LoginUseCaseViewProtocol {}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
}

