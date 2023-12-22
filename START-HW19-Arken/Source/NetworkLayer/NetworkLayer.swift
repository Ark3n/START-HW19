//
//  File.swift
//  START-HW19-Arken
//
//  Created by Arken Sarsenov on 21.12.2023.
//

import Foundation
import CryptoKit

struct NetworkService {
    static func getURL()-> String {
        let publicKey = "875ac65d365dc4bf882349b6946bcb76"
        let privateKey = "720643086da2de79d997e5286b65e74488baa2db"
        let ts = Date().timeIntervalSince1970.description
        let hash = getHash(str: ts + privateKey + publicKey)
        let urlString = "https://gateway.marvel.com:443/v1/public/characters?ts=" + ts + "&apikey=" + publicKey + "&hash=" + hash
        return urlString
    }
}

private func getHash(str: String) -> String {
    let digest = Insecure.MD5.hash(data: Data(str.utf8))
    return digest.map {String(format: "%02hhx", $0)}.joined()
}
