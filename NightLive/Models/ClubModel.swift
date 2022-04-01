//
//  ClubsModel.swift
//  NightLive
//
//  Created by Sam Santos on 3/24/22.
//

import Foundation
import UIKit

struct ClubDataModel: Codable {
   
        let id : String
        let name: String
        let address: String
        let phone: String
        let website: String
}

struct ClubModel: Identifiable {
    
    let id : String
    let name: String
    let address: String
    let phone: String
    let website: String
    let image: UIImage?
    var checkedIN: Int?
    
    init(id: String, data: [String: Any], image: UIImage?) {
       
        self.id = id
        name = data[FirebaseConstants.clubName] as? String ?? ""
        address = data[FirebaseConstants.clubAddress] as? String ?? ""
        website = data[FirebaseConstants.clubWebsite] as? String ?? ""
        phone = data[FirebaseConstants.clubPhone] as? String ?? ""
        checkedIN = data[FirebaseConstants.checkedIN] as? Int ?? 0
        self.image = image
    }
    
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        var dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?, value:Any) -> (String, Any)? in
          guard let label = label else { return nil }
          return (label, value)
        }).compactMap { $0 })
        dict.removeValue(forKey: "image")
        return dict
      }
    
    func downloadLogo(handler: @escaping(Result<UIImage, Error>)->Void) {

        print(5)

        let logoStorage = FirebaseManager.shared.storage.reference().child("LocationImage/\(self.id)/\(self.id).jpeg")

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
    
}
