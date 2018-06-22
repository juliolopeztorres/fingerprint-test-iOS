
class LoginUseCase {
    var view: LoginUseCaseViewProtocol
    var repository: LoginUseCaseRepositoryProtocol
    
    init(with view: LoginUseCaseViewProtocol) {
        self.view = view
        self.repository = LoginUseCaseRepository()
    }
    
    public func login(username: String, password: String) -> Bool {
        if (username.isEmpty || password.isEmpty) {
            return false
        }
        
        return self.repository.login(username: username, password: password)
    }
}
