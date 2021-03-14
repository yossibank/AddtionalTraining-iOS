//
//  KeychainManager.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/15.
//

import KeychainAccess

final class KeychainManager {

    private struct Constant {
        static let identifier = "CFBundleIdentifier"
    }

    enum Keys: String {
        case token
    }

    private var keychain: Keychain = {
        guard
            let identifier = Bundle.main.object(
                forInfoDictionaryKey: Constant.identifier
            ) as? String
        else {
            return Keychain(service: .blank)
        }
        return Keychain(service: identifier)
    }()

    static let shared = KeychainManager()

    private init() {}

    func setToken(_ token: String) {
        do {
            try keychain.set(token, key: Keys.token.rawValue)
        } catch {
            print("can't set \(Keys.token.rawValue)")
        }
    }

    func getToken() -> String? {
        try? keychain.get(Keys.token.rawValue)
    }

    func removeToken() {
        do {
            try keychain.remove(Keys.token.rawValue)
        } catch {
            print("can't remove \(Keys.token.rawValue)")
        }
    }
}
