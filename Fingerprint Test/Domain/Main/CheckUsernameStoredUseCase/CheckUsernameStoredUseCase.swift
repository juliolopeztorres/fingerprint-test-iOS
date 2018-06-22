
class CheckUsernameStoredUseCase {
    var view: CheckUsernameStoredUseCaseViewProtocol
    var repository: CheckUsernameStoredUseCaseRepositoryProtocol
    
    init(with view: CheckUsernameStoredUseCaseViewProtocol) {
        self.view = view
        self.repository = CheckUsernameStoredUseCaseRepository()
    }
    
    public func check() -> Void {
        self.repository.check() ? self.view.onCheckUsernameSuccess() : self.view.onCheckUsernameError()
    }
}
