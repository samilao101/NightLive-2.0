//
//  CheckedInListView.swift
//  NightLive
//
//  Created by Sam Santos on 3/27/22.
//

import SwiftUI

struct CheckedInListView: View {
    
    
    
    let columns: [GridItem] = [
        GridItem(.fixed(50), spacing: nil, alignment: nil),
        GridItem(.fixed(50), spacing: nil, alignment: nil),
        GridItem(.fixed(50), spacing: nil, alignment: nil)
    ]
    
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns){
                Text("Placeholder")
                Text("Placeholder")
                Text("Placeholder")
                Text("Placeholder")
                Text("Placeholder")
                Text("Placeholder")
            }
        }
    }
}

struct CheckedInListView_Previews: PreviewProvider {
    static var previews: some View {
        CheckedInListView()
    }
}
