//
//  CellView.swift
//  NightLive
//
//  Created by Sam Santos on 3/26/22.
//

import SwiftUI

struct CellView: View {
    let club: ClubModel
    
    @State var usersCheckedIn = [ChatUser]()
    @StateObject var vm : PreviewCheckedInViewModel
   
    
    
    var body: some View {
        
        HStack{
            Image(uiImage: (club.image ?? UIImage(systemName: "building"))!)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)
            VStack(alignment: .leading) {
                Text(club.name)
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .lineLimit(1)
            
                ScrollView{
                HStack{
                    ForEach(vm.usersCheckedIn) { user in
                        UserAvatarView(user: user, size: 30, withName: false)
                       
                      }
                    if club.checkedIN! > 2 {
                        PreviewCount(number: club.checkedIN! - 3)
                    }
                }.padding(3)
                }
            }
            
        }
        
    }
    
  
   
}

struct PreviewCount: View {
    
    var number: Int
    
    var body: some View {
        
        HStack {
            Text("\(String(number))+")
                .bold()
        }
    
    }
    
    
}


//
//struct CellView_Previews: PreviewProvider {
//    
//    
//    static var data: [String: Any] = [
//        FirebaseConstants.clubName: "Club NightClub THesafkjnals;f",
//        FirebaseConstants.clubAddress: "123 Fake St, City, State, 10001",
//        FirebaseConstants.clubPhone: "18001231234",
//        FirebaseConstants.clubWebsite: "www.website.com",
//    ]
//    
//    static var previews: some View {
//        CellView(club: ClubModel(id: "123", data: data, image: UIImage(systemName: "building")!))
//    }
//}
