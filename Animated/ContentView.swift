//
//  ContentView.swift
//  Animated
//
//  Created by Hiển Hảo on 16/08/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .chat
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .chat:
                Text("Chat")
            case .search:
                Text("Seatch")
            case .timer:
                Text("Timer")
            case .bell:
                Text("Bell")
            case .user:
                Text("User")
            }
            

            TabBar()
        }
    }
}

#Preview {
    ContentView()
}
