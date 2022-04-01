//
//  ProfileViewModel.swift
//  NightLive
//
//  Created by Sam Santos on 3/27/22.
//

import Foundation
import Firebase


class ProfileViewModel: ObservableObject {
    
    @Published var isUserCurrentlyLoggedOut = false
    @Published var errorMessage = ""
    @Published var chatUser: ChatUser?
    @Published var currentClub: ClubModel?
    @Published var alertItem: AlertItem?
    

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
                
                guard let data = snapshot?.data() else { return }
                
                self.currentClub = ClubModel(id: data["id"] as? String ?? "", data: data, image: nil)
                
                
               
            }
        
    }
    
    func handleSignOut() {
        isUserCurrentlyLoggedOut.toggle()
        try? FirebaseManager.shared.auth.signOut()
        currentClub = nil
    }
    
    func checkInCurrentClub(club: ClubModel) {
      
       
        guard let uid = chatUser?.uid else {return}
       
        if currentClub != nil {
            alertItem = AlertContext.checkedOutOfOtherClub
            self.checkOutCurrentClub()
        }

        FirebaseManager.shared.firestore.collection(FirebaseConstants.locations).document(club.id).collection(FirebaseConstants.checkedInUsers)
            .document(uid).setData(chatUser!.asDictionary) { err in
                print(3)

                if let err = err {
                    print(err)
                   

                    return

                }
              

                print("Success")
                self.currentClub = club
            }
        
        FirebaseManager.shared.firestore.collection(FirebaseConstants.users).document(chatUser!.uid).collection(FirebaseConstants.checkedIn)
            .document(FirebaseConstants.checkedInClub).setData(club.asDictionary) { err in
                print(5)

                if let err = err {
                    print(err)
                  

                    return
                }
              
            
            }
        
        
        FirebaseManager.shared.firestore.collection(FirebaseConstants.locations).document(club.id).updateData([FirebaseConstants.checkedIN : FieldValue.increment(Int64(1))])
        
        
        
    }
    
    func checkOutCurrentClub() {
        
        FirebaseManager.shared.firestore.collection(FirebaseConstants.locations).document(currentClub!.id).collection(FirebaseConstants.checkedInUsers).document(chatUser!.uid).delete()
        
        FirebaseManager.shared.firestore.collection(FirebaseConstants.users).document(chatUser!.uid).collection(FirebaseConstants.checkedIn).document(FirebaseConstants.checkedInClub).delete()
        
        FirebaseManager.shared.firestore.collection(FirebaseConstants.locations).document(currentClub!.id).updateData([FirebaseConstants.checkedIN : FieldValue.increment(Int64(-1))])
        
        self.currentClub = nil
    }
    
    
}
