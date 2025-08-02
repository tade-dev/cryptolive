//
//  CryptoListViewModel.swift
//  cryptolive
//
//  Created by BSTAR on 02/08/2025.
//

import Combine
import Foundation

class CryptoListViewModel: ObservableObject {
    
    @Published var searchQuery: String = ""
    @Published var cryptoList: [Crypto] = []
    @Published var isLoading: Bool = false
    @Published var cancellables: Set<AnyCancellable> = []
    var filteredCryptoList: [Crypto] {
        if(searchQuery.isEmpty) {
            return cryptoList
        } else {
            return cryptoList.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
        }
    }
   
    init() {
        fetchCryptoData()
    }
    
    func fetchCryptoData() {
        let url = URL(string: "https://rest.coincap.io/v3/assets")
        
        guard let url else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response)-> Data in
                guard
                    let repsonse = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                        throw URLError(.badServerResponse)
                    }
                return data
            }
            .decode(type: [Crypto].self, decoder: JSONDecoder())
            .sink { (completion) in
                print("COMPLETION:: \(completion)")
            } receiveValue: { [weak self] cryptoList in
                self?.cryptoList = cryptoList
            }
            .store(in: &cancellables)
    }
    
}
