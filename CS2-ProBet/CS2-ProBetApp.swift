//
//  CS2-ProBetApp.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 09/12/2023.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
        }
    }
}
