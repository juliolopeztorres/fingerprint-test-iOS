
import Foundation

class RegisterUseCaseRepository: RegisterUseCaseRepositoryProtocol {
    
    func register(username: String, password: String) -> Bool {
        let passwordItem = KeychainPasswordItem(service: Constants.SERVICE_NAME, account: username, accessGroup: nil)

        do {
            try passwordItem.savePassword(password)
            self.set(key: Constants.USERNAME_KEY, value: username)
        } catch {
            return false
        }
        
        return true
    }
    
    private func set(key: String, value: Any) -> Void {
        UserDefaults.standard.set(value, forKey: key)
    }
}
