//  ContentView.swift
//  WorldExplorer
//  Created by John Gallaugher on 11/16/25.
//  YouTube.com/profgallaugher - gallaugher.bsky.social

import SwiftUI

struct CountryListView: View {
    enum Regions: String, CaseIterable {
        case africa, americas, asia, europe, oceania
    }
    
    @State private var countryVM = CountryViewModel()
    @State private var selectedRegion: Regions = .europe
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("Select region:")
                Spacer()
                Picker("", selection: $selectedRegion) {
                    ForEach(Regions.allCases, id: \.self) { region in
                        Text(region.rawValue.capitalized)
                    }
                }
                .onChange(of: selectedRegion) {
                    Task {
                        countryVM.region = selectedRegion.rawValue
                        await countryVM.getData()
                        countryVM.countries.sort { $0.name.common < $1.name.common }
                    }
                }
            }
            .padding(.horizontal)
            
            List(countryVM.countries) { country in
                NavigationLink {
                    DetailView(country: country)
                } label: {
                    HStack {
                        Text(country.flag)
                        Text(country.name.common)
                    }
                    .font(.title)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Countries:")
            .task {
                await countryVM.getData()
                countryVM.countries.sort { $0.name.common < $1.name.common }
            }
        }
    }
}

#Preview {
    CountryListView()
}
