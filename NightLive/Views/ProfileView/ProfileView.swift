//
//  ProfileView.swift
//  NightLive
//
//  Created by Sam Santos on 3/24/22.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var vm: ProfileViewModel
    
    var body: some View {
      
        ZStack {
            
            if vm.isUserCurrentlyLoggedOut {
                LoginView( didCompleteLoginProcess: {
                        self.vm.isUserCurrentlyLoggedOut = false
                        self.vm.fetchCurrentUser()
                })

            } else {
                VStack {
                    HStack {
                        Button {
                            vm.handleSignOut()
                        } label: {
                            Text("Log out")
                        }

                    }
                        Text("Hello user \(String(vm.chatUser?.email ?? "")) ")
                }
            }
            
        }
        
        
    }
 
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

//
//var body: some View {
//    Text("Hello")
//        .fullScreenCover(isPresented: $vm.isUserCurrentlyLoggedOut, onDismiss: nil) {
//            LoginView(vm: vm, didCompleteLoginProcess: {
//                self.vm.isUserCurrentlyLoggedOut = false
//                self.vm.fetchCurrentUser()
//            })
//        }
//}
