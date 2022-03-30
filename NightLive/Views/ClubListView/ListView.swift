//
//  ClubListView.swift
//  NightLive
//
//  Created by Sam Santos on 3/24/22.
//

import SwiftUI

struct ListView: View {
    
    @StateObject var viewModel = ListViewModel()
    
    var body: some View {
    NavigationView {
        List {
            ForEach(viewModel.listOfClubs) { club in
                NavigationLink {
                    ClubDetailView(club: club)
                } label: {
                    CellView(club: club)
                }
            }
        }
        .navigationTitle("Clubs")
      }
    }
}

struct ClubListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}


