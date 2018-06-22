
class LoginWithFingerprintUseCase {
    var view: LoginWithFingerprintUseCaseViewProtocol
    var repository: LoginWithFingerprintUseCaseRepositoryProtocol
    
    init(with view: LoginWithFingerprintUseCaseViewProtocol) {
        self.view = view
        self.repository = LoginWithFingerprintUseCaseRepository()
    }
    
    public func login() -> Void {
        self.repository.login(callback: self)
    }
}

extension LoginWithFingerprintUseCase: LoginWithFingerprintUseCaseRepositoryProtocolCallback {
    func onLoginSuccess(recoveredPassword: String) {
        self.view.onLoginSuccess(recoveredPassword: recoveredPassword)
    }
    
    func onLoginError(_ error: String) {
        self.view.onLoginError(error)
    }
}
