//
//  CellView.swift
//  NightLive
//
//  Created by Sam Santos on 3/26/22.
//

import SwiftUI

struct CellView: View {
    let club: ClubModel
    
    var body: some View {
        
        HStack{
            Image(uiImage: (club.image ?? UIImage(systemName: "building"))!)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.vertical, 8)
            VStack(alignment: .leading) {
                Text(club.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
       
                HStack{
                    ForEach(1..<5) { _ in
                        ClubAvatarView(image: UIImage(systemName: "person")!, size: 20)
                    }
                }
            }
            
        }
        
        
    }
}

struct CellView_Previews: PreviewProvider {
    
    
    static var data: [String: Any] = [
        FirebaseConstants.clubName: "Club NightClub THesafkjnals;f",
        FirebaseConstants.clubAddress: "123 Fake St, City, State, 10001",
        FirebaseConstants.clubPhone: "18001231234",
        FirebaseConstants.clubWebsite: "www.website.com",
    ]
    
    static var previews: some View {
        CellView(club: ClubModel(id: "123", data: data, image: UIImage(systemName: "building")!))
    }
}
