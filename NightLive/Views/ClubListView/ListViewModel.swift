//
//  ListViewModel.swift
//  NightLive
//
//  Created by Sam Santos on 3/24/22.
//

import Foundation
import Firebase
import SwiftUI

class ListViewModel: ObservableObject {
    
    @Published var listOfClubs = [ClubModel]()
    
    init() {
        getClubs()
    }
    
    func getClubs() {
        FirebaseManager.shared.firestore.collection("Locations").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            }
       
            querySnapshot?.documentChanges.forEach({ change in
          
                var clubImage = UIImage()
                
                if change.type == .added {
                    let data = change.document.data()
                    let id = change.document.documentID
               
                    self.downloadLogo(imageId: id) { result in
                        switch result {
                        case .success(let image):
                            clubImage = image
                            self.createAndAddModel(id: id, data: data, clubImage: clubImage)
                        case .failure(_):
                            clubImage = UIImage(systemName: "building")!
                            self.createAndAddModel(id: id, data: data, clubImage: clubImage)
                        }
                    }
                    
                    
                }
                
                if change.type == .modified {
                  
                    let data = change.document.data()
                    let id = change.document.documentID
                    let number = data[FirebaseConstants.checkedIN] as? Int ?? 0

                    if let index = self.listOfClubs.firstIndex(where: { club in
                        club.id == id
                        
                    }) {
                        self.listOfClubs[index].checkedIN = number
                        
                    }
                    
                }
               
                
            })
            
        }
    }
    
    func downloadLogo(imageId: String, handler: @escaping(Result<UIImage, Error>)->Void) {

        print(5)

        let logoStorage = FirebaseManager.shared.storage.reference().child("LocationImage/\(imageId)/\(imageId).jpeg")

        logoStorage.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print(error.localizedDescription)
          } else {
            let image = UIImage(data: data!)
            guard let newimage = image else { return }
            handler(.success(newimage))
          }

        }

    }
    
    func createAndAddModel(id: String, data: [String: Any], clubImage: UIImage) {
        DispatchQueue.main.async {
            let club = ClubModel(id: id, data: data, image: clubImage)
            self.listOfClubs.append(club)
        }
    }
    
}

