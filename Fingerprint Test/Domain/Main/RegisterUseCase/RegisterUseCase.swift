
class RegisterUseCase {
    var view: RegisterUseCaseViewProtocol
    var repository: RegisterUseCaseRepositoryProtocol
    
    init(with view: RegisterUseCaseViewProtocol) {
        self.view = view
        self.repository = RegisterUseCaseRepository()
    }
    
    public func register(username: String, password: String) -> Bool {
        if (username.isEmpty || password.isEmpty) {
            return false
        }
        
        return self.repository.register(username: username, password: password)
    }
}
