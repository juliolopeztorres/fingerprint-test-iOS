
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainViewController: MainViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.mainViewController = MainViewController(nibName: String(describing: MainViewController.self), bundle: nil)
        
        self.window?.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
            
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        self.mainViewController?.checkFingerprintSensorUseCase?.check()
    }
}

