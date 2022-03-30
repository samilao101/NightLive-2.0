//
//  UserAvatarView.swift
//  NightLive
//
//  Created by Sam Santos on 3/27/22.
//

import SwiftUI

struct UserAvatarView: View {
    
    var name: String
    var image: UIImage
    var size: CGFloat
    
    var body: some View {
        VStack{
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(lineWidth: 3))
            
        Text(name)
        }
    }
}

struct UserAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        UserAvatarView(name: "Samilao101", image: UIImage(systemName: "person")!, size: 90)
    }
}
