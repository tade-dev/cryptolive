//
//  Crypto.swift
//  cryptolive
//
//  Created by BSTAR on 02/08/2025.
//

import Foundation

struct Crypto: Codable, Identifiable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: String
    let maxSupply: String
    let marketCapUsd: String
    let volumeUsd24Hr: String
    let priceUsd: String
    let changePercent24Hr: String
    let vwap24Hr: String
    let explorer: String
    let tokens: Tokens
}

struct Tokens: Codable {
    
}
