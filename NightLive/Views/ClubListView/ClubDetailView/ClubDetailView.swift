//
//  ClubDetailView.swift
//  NightLive
//
//  Created by Sam Santos on 3/26/22.
//

import SwiftUI

struct ClubDetailView: View {
    
    @State private var isCheckedIn = false

    let club: ClubModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm: ProfileViewModel


    
    var body: some View {

        ZStack {
            Image(uiImage: club.image!)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .foregroundColor(.white)

                    Text(club.name)
                        .font(.system(size: 32, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    Spacer()
                    
                    
                        }
                
                if vm.chatUser != nil {
                    Button {
                            
                        if club.id == vm.currentClub?.id  {
                            vm.checkOutCurrentClub()
                        } else {
                            vm.checkInCurrentClub(club: club)

                        }
                        
                        
                    } label: {
                        Text(club.id == vm.currentClub?.id ? "Check Out" : "Check In")
                            .padding()
                            .background(club.id == vm.currentClub?.id ? Color.yellow: Color.green)
                            .cornerRadius(12)
                            .foregroundColor(.black)
                    }
                }
              
               

                
                    ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(.white)

                            VStack {
                                Text(club.address)
                                    .font(.headline)
                                    .foregroundColor(.black)

                                Text(club.website)
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                
                                Text(club.phone)
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                            .padding(20)
                            .multilineTextAlignment(.center)
                        }
                        .frame(width: 350, height: 100)
                    
                Spacer()
            }
        
        }
        .alert(item: $vm.alertItem, content: { $0.alert })

        .onAppear{
            if vm.currentClub != nil {
                if vm.currentClub?.id == club.id {
                    isCheckedIn = true
                } else {
                    isCheckedIn = false
                }
            }
            
        }
        .navigationBarHidden(true)
    }
}

struct ClubDetailView_Previews: PreviewProvider {
    
    static var data: [String: Any] = [
        FirebaseConstants.clubName: "Club NightClub",
        FirebaseConstants.clubAddress: "123 Fake St, City, State, 10001",
        FirebaseConstants.clubPhone: "18001231234",
        FirebaseConstants.clubWebsite: "www.website.com",
    ]
    
    static var previews: some View {
        ClubDetailView(club: ClubModel(id: "123", data: data, image: UIImage(systemName: "building")))
    }
}

fileprivate struct BannerImageView: View {
    
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 160)
            .accessibilityHidden(true)
    }
}


fileprivate struct AddressHStack: View {
    
    var address: String
    
    var body: some View {
        HStack {
            Label(address, systemImage: "mappin.and.ellipse")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}
