//  DetailView.swift
//  WorldExplorer
//  Created by John Gallaugher on 11/16/25.
//  YouTube.com/profgallaugher - gallaugher.bsky.social

import SwiftUI

struct DetailView: View {
    @State var country: Country
    @State private var countryDetailVM = CountryDetailViewModel()
    var body: some View {
        VStack (alignment: .leading) {
            Text(country.name.common)
                .font(.largeTitle)
                .bold()
            
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(.gray)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Region:")
                    Text("Capital:")
                }
                .bold()
                
                VStack(alignment: .leading) {
                    Text(countryDetailVM.countryDetail.subregion)
                    Text(countryDetailVM.countryDetail.capital.joined(separator: ", "))
                }
            }
            
            Text("Flag:")
                .bold()
            
            AsyncImage(url: URL(string: countryDetailVM.countryDetail.flags.png)) { phase in
                if let image = phase.image { // We have a valid image
                    image
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 8)
                } else if phase.error != nil { // We've had an error
                    Image(systemName: "questionmark.square.dashed")
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 8)
                } else { // Use a placeholder - image is loading
                    ProgressView()
                        .scaleEffect(4)
                        .tint(.red)
                }
            }
            .frame(maxWidth: .infinity)
            
            if countryDetailVM.countryDetail.coatOfArms.png != nil {
                Text("Coat of Arms:")
                    .bold()
                
                AsyncImage(url: URL(string: countryDetailVM.countryDetail.coatOfArms.png ?? "")) { phase in
                    if let image = phase.image { // We have a valid image
                        image
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 8)
                    } else if phase.error != nil { // We've had an error
                        Image(systemName: "questionmark.square.dashed")
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 8)
                    } else { // Use a placeholder - image is loading
                        ProgressView()
                            .scaleEffect(4)
                            .tint(.red)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .task {
            countryDetailVM.countryName = country.name.common
            await countryDetailVM.getData()
            print("Flag: \(countryDetailVM.countryDetail.flags.png)")
        }
    }
}

#Preview {
    DetailView(country: Country(name: Name(common: "Canada"), flag: "🇨🇦"))
}
