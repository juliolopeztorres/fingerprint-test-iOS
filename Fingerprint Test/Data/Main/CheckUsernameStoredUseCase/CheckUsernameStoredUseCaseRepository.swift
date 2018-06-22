
import Foundation

class CheckUsernameStoredUseCaseRepository: CheckUsernameStoredUseCaseRepositoryProtocol {
    func check() -> Bool {
        return !self.getString(key: Constants.USERNAME_KEY).isEmpty
    }
    
    private func getString(key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
}
