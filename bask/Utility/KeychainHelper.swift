//
//  KeychainHelper.swift
//  bask
//
//  Created by MapMac on 28/12/2022.
//

import Foundation

/// A helper class used to SAVE, READ, UPDATE, DELETE data to
/// Keychain.
class KeychainHelper {
    
    static let shared = KeychainHelper()
    
    private init(){}
    
    func save<T>(_ data: T, _ service: String, _ account: String) where T: Codable{
        
        do {
            let data = try JSONEncoder().encode(data)
            save(data, service, account)
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }
    
    
    func read<T>(service: String, account: String, type: T.Type) -> T? where T: Codable {
        
        
        guard let data = read(service: service, account: account) else { return nil }
        
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    /// Method to save data to the Keychain.
    /// - Parameters:
    ///   - data: Data to be saved.
    ///   - service: Value for the key `kSecAttrService` to be used in the query.
    ///   - account: Value for the key `kSecAttrAccount` to be used in the query.
    private func save(_ data: Data, _ service: String, _ account: String){
        
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            
            if status == errSecDuplicateItem {
                updateData(data, service, account)
            } else {
                print("Error performing keychain action \(status)")
            }
        }
    }
    
    /// Method to read data from the Keychain.
    /// - Parameters:
    ///   - service: Value for the key `kSecAttrService` to be used in the query.
    ///   - account: Value for the key `kSecAttrAccount` to be used in the query.
    private func read(service: String, account: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    func delete(service: String, account: String) {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        // Delete item from keychain
        SecItemDelete(query)
    }
    
    private func updateData(_ data: Data, _ service: String, _ account: String){
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        let attributesToUpdate = [kSecValueData: data] as CFDictionary
        
        SecItemUpdate(query, attributesToUpdate)
    }
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}
