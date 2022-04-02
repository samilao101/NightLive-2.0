//
//  PreviewCheckedInViewModel.swift
//  NightLive
//
//  Created by Sam Santos on 4/2/22.
//

import Foundation
import SwiftUI

class PreviewCheckedInViewModel: ObservableObject {
    
    let club: ClubModel
    
    @Published var usersCheckedIn = [ChatUser]()
    
   
    var limited: Bool = false
    
    
    init(club: ClubModel ) {
        self.club = club
        getCheckedInUsers(club: club)
    }
    
    func getCheckedInUsers(club: ClubModel) {
        usersCheckedIn = [ChatUser]()
        FirebaseManager.shared.firestore.collection(FirebaseConstants.locations).document(club.id).collection(FirebaseConstants.checkedInUsers).limit(to: 3).addSnapshotListener { querySnapShot, error in
            
            
                if let error = error {
                    print(error.localizedDescription)
                }
            
            
            
            querySnapShot?.documentChanges.forEach({ change in
                
                if change.type == .added {
                    let data = change.document.data()
                    
                    let user = ChatUser(data: data)
                    
                        self.usersCheckedIn.append(user)
                
                    }
                
                if change.type == .removed {
                    let data = change.document.data()
                    
                    let user = ChatUser(data: data)
                    if let index = self.usersCheckedIn.firstIndex(where: { storedUser in
                        storedUser.uid == user.uid
                        
                    }) {
                        
                        self.usersCheckedIn.remove(at: index)
                        
                    }
                }
                
                
              
            })
            
            
        }

    
    
    }
    
    
}
