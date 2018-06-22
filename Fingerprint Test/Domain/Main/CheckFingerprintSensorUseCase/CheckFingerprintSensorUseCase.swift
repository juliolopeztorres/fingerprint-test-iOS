
class CheckFingerprintSensorUseCase {
    var view: CheckFingerprintSensorUseCaseViewProtocol
    var repository: CheckFingerprintSensorUseCaseRepositoryProtocol
    
    init(with view: CheckFingerprintSensorUseCaseViewProtocol) {
        self.view = view
        self.repository = CheckFingerprintSensorUseCaseRepository()
    }
    
    public func check() -> Void {
        self.repository.check() ? self.view.onCheckFingerprintSuccess() : self.view.onCheckFingerprintError()
    }
}
