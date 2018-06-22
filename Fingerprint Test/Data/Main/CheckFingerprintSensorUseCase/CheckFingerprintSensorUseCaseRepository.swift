import LocalAuthentication

class CheckFingerprintSensorUseCaseRepository: CheckFingerprintSensorUseCaseRepositoryProtocol {
    
    var context: LAContext
    
    init() {
        self.context = LAContext()
    }
    
    func check() -> Bool {
        return self.context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
}
