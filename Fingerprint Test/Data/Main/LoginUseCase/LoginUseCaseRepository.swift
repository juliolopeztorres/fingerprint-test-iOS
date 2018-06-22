
import LocalAuthentication

class LoginUseCaseRepository: LoginUseCaseRepositoryProtocol {
    func login(username: String, password: String) -> Bool {
        let storedUsername = self.getString(key: Constants.USERNAME_KEY)
        let storedPassword = self.getSecureStoredPassword(for: storedUsername)
        
        return storedUsername == username && password == storedPassword
    }
    
    private func getString(key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    private func getSecureStoredPassword(for username: String) -> String {
        let passwordItem = KeychainPasswordItem(service: Constants.SERVICE_NAME, account: username, accessGroup: nil)
        do {
            return try passwordItem.readPassword()
        } catch {}
        
        return ""
    }
}
