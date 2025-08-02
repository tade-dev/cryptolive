//
//  CryptoListView.swift
//  cryptolive
//
//  Created by BSTAR on 02/08/2025.
//

import SwiftUI
import Combine

struct CryptoListView: View {
    
    @StateObject var vm = CryptoListViewModel()
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(vm.filteredCryptoList) { crypto in
                        
                    }
                }
            }
            .navigationTitle("Crypto List")
            .searchable(text: $vm.searchQuery)
            .onReceive(timer) { value in
                vm.fetchCryptoData()
            }
        }
    }
}

struct CryptoTile: View {
    
    let name: String
    let symbol: String
    let priceUsd: String
    let marketCap: String
    let onTap: OnTap
    
    typealias OnTap = ()-> Void
    
    var body: some View {
        HStack {
            
            Spacer()
            buildChangeIndicator(value: priceUsd)
        }
    }
    
    private func buildChangeIndicator(value: String) -> some View {
        return Text("\(value.contains("-") ? value : "+\(value)")%")
            .foregroundStyle(.white)
            .font(.headline)
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 3)
                    .fill(value.contains("-") ? Color.red : Color.green)
            )
    }
    
}

#Preview {
    CryptoListView()
}
