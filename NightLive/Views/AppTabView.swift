//
//  AppTabView.swift
//  NightLive
//
//  Created by Sam Santos on 3/24/22.
//

import SwiftUI

struct AppTabView: View {
    
    @StateObject var vm = ProfileViewModel()

    var body: some View {
        TabView {
            LiveView()
                .tabItem {Label("Live", systemImage: "record.circle")}
            MapView()
                .tabItem {Label("Map", systemImage: "map")}
            ListView()
                .tabItem {Label("List", systemImage: "building")}
            ProfileView()
                .tabItem {Label("Profile", systemImage: "person")}

        }.environmentObject(vm)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
