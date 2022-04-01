//
//  CheckedInListView.swift
//  NightLive
//
//  Created by Sam Santos on 3/27/22.
//

import SwiftUI

struct CheckedInListView: View {
    
    
    @StateObject var vm : CheckedInViewModel
    
    
    let columns: [GridItem] = [
        GridItem(.fixed(80), spacing: 50, alignment: nil),
        GridItem(.fixed(80), spacing: 50, alignment: nil),
        GridItem(.fixed(80), spacing: 50, alignment: nil)
    ]
    
    init(club: ClubModel) {
        _vm = StateObject.init(wrappedValue: CheckedInViewModel(club: club))
    }
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns){
                
                ForEach(vm.usersCheckedIn) { user in
                    UserAvatarView(user: user)
                }
                
            }
        }
    }
}

//struct CheckedInListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckedInListView()
//    }
//}
