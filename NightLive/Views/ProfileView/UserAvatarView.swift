//
//  UserAvatarView.swift
//  NightLive
//
//  Created by Sam Santos on 3/27/22.
//

import SwiftUI

class UserAvatarViewModel: ObservableObject {
    
    @Published var image : UIImage = UIImage(systemName: "person")!
    let user: ChatUser
    
    
    init(user: ChatUser) {
        self.user = user
        
        getProfileImage(user: user)
    }
    
    func getProfileImage(user: ChatUser) {
        DispatchQueue.main.async {
            self.downloadProfileImage(imageId: user.uid) { result in
                switch result {
                case .success(let image):
                    print("image 5")
                    self.image = image
                case .failure(_):
                    break
                }
            }
        }
       
    }
    
    
    func downloadProfileImage(imageId: String, handler: @escaping(Result<UIImage, Error>)->Void) {

        print("image 1")
        let logoStorage = FirebaseManager.shared.storage.reference().child("\(FirebaseConstants.profileImages)/\(imageId)/\(imageId)")

        print("image 2")
        logoStorage.getData(maxSize: 1 * 1024 * 1024) { data, error in
            print("image 3")
          if let error = error {
            print(error.localizedDescription)
              print("image 3 error")
          } else {
              print("image 4")
            let image = UIImage(data: data!)
            guard let newimage = image else { return }
            handler(.success(newimage))
          }

        }

    }
    
}


struct UserAvatarView: View {
    
    var name: String
    var size: CGFloat
    var withName: Bool
    
    @StateObject var vm : UserAvatarViewModel
    
    init(user: ChatUser, size: CGFloat = 60, withName: Bool = true) {
     
        _vm = StateObject.init(wrappedValue: UserAvatarViewModel(user: user))
        self.name = user.email
        self.size = size
        self.withName = withName
    }
    
    var body: some View {
        VStack{
        Image(uiImage: vm.image)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(lineWidth: 3))
         
            if withName {
                Text(name)
                        .foregroundColor(.white)
            }
        }
        
        
    }
}

//struct UserAvatarView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserAvatarView(name: "Samilao101", image: UIImage(systemName: "person")!, size: 90)
//    }
//}
