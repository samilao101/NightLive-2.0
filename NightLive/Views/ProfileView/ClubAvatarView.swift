//
//  AvatarView.swift
//  NightLive
//
//  Created by Sam Santos on 3/26/22.
//

import SwiftUI

struct ClubAvatarView: View {
    
    var image: UIImage
    var size: CGFloat
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

//struct AvatarView_Previews: PreviewProvider {
//    static var previews: some View {
//        AvatarView(image: PlaceholderImage.avatar, size: 90)
//    }
//}
