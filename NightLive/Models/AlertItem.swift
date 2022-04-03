//
//  AlertItem.swift
//  NightLive
//
//  Created by Sam Santos on 3/30/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
    
    var alert: Alert {
        Alert(title: title, message: message, dismissButton: dismissButton)
    }
}

struct AlertContext {
    
    //MARK: - MapView Errors
    static let checkedOutOfOtherClub             = AlertItem(title: Text("Checked Out Of Previous Clubs"),
                                                            message: Text("You are checked Out of prrevious club"),
                                                            dismissButton: .default(Text("Ok")))
    
}

