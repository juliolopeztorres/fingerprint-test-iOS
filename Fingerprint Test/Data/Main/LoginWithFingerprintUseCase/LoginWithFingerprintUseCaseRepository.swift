import LocalAuthentication

class LoginWithFingerprintUseCaseRepository: LoginWithFingerprintUseCaseRepositoryProtocol {
    var context: LAContext?
    
    init() {
        self.context = LAContext()
    }
    
    func login(callback: LoginWithFingerprintUseCaseRepositoryProtocolCallback) {
        let username = self.getString(key: Constants.USERNAME_KEY)
        
        self.context?.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Hey \(username), you can login with your finger!",
            reply: { (wasSuccess, error) in
                if (wasSuccess) {
                    let password = self.getSecureStoredPassword(for: username)
                    if (!password.isEmpty) {
                        callback.onLoginSuccess(recoveredPassword: password)
                        return
                    }
                }
                
                callback.onLoginError(error != nil ? error!.localizedDescription : "Error getting secure stored password")
        })
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
