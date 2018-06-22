
protocol LoginWithFingerprintUseCaseViewProtocol {
    func onLoginSuccess(recoveredPassword: String) -> Void
    func onLoginError(_ error: String) -> Void
}
