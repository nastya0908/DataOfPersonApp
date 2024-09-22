
import Foundation

final class Storage {
    
    private let defaults = UserDefaults.standard
    
    public func saveObject(value: Any,
                           for key: StorageKeys) {
        defaults.set(value,
            forKey: key.rawValue)
    }
    
    public func fetchObject<T>(type: T.Type,
                               for key: StorageKeys) ->T? {
        return defaults.object(forKey: key.rawValue) as? T
    }
}

enum StorageKeys: String {
    case name
    case birthdate
}
