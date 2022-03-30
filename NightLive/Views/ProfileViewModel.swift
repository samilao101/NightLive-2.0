//
//  ProfileViewModel.swift
//  NightLive
//
//  Created by Sam Santos on 3/27/22.
//

import Foundation


class ProfileViewModel: ObservableObject {
    
    @Published var isUserCurrentlyLoggedOut = false
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    @Published var currentClub: ClubModel?

    init() {
        
        DispatchQueue.main.async {
            self.isUserCurrentlyLoggedOut = FirebaseManager.shared.auth.currentUser?.uid == nil
        }
        
        fetchCurrentUser()
        
        fetchCurrentClub()
        
    }


    func fetchCurrentUser() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Failed to fetch current user: \(error)"
                print("Failed to fetch current user:", error)
                return
            }
            
            self.chatUser = try? snapshot?.data(as: ChatUser.self)
            FirebaseManager.shared.currentUser = self.chatUser
        }
    }
    
    
    func fetchCurrentClub() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Could not find firebase uid"
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).collection(FirebaseConstants.checkedIn).document(FirebaseConstants.checkedInClub)
            .getDocument { snapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to fetch current user: \(error)"
                    return
                }
                
                self.currentClub = try? snapshot?.data(as: ClubModel.self)
                FirebaseManager.shared.currentUser = self.chatUser
            }
        
    }
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
    }
    
    func checkInCurrentClub(club: ClubModel) {
      
        guard let uid = chatUser?.uid else {return}
       
      
        FirebaseManager.shared.firestore.collection(FirebaseConstants.locations).document(club.id).collection(FirebaseConstants.checkedInUsers)
            .document(uid).setData(chatUser!.asDictionary) { err in
              
                if let err = err {
                    print(err)
                    return
                }
              
                print("Success")
                self.currentClub = club
            }
        
        FirebaseManager.shared.firestore.collection(FirebaseConstants.users).document(chatUser!.uid).collection(FirebaseConstants.checkedIn)
            .document(FirebaseConstants.checkedInClub).setData(club.asDictionary) { err in
              
                if let err = err {
                    print(err)
                    return
                }
              
             
            }
        
        
        
    }
    
    func checkOutCurrentClub(clubUID: String) {
        
        
    }
    
    
}