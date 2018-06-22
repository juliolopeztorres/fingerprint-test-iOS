
protocol LoginWithFingerprintUseCaseRepositoryProtocol {
    func login(callback: LoginWithFingerprintUseCaseRepositoryProtocolCallback) -> Void
}

protocol LoginWithFingerprintUseCaseRepositoryProtocolCallback {
    func onLoginSuccess(recoveredPassword: String) -> Void
    func onLoginError(_ error: String) -> Void
}
