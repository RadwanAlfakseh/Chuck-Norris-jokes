//
//  Chuck_Norris_jokesApp.swift
//  Shared
//
//  Created by Radwan Alfakseh on 20/06/2022.
//

import SwiftUI

@main
struct Chuck_Norris_jokesApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                NavigationView{
                    MainView()
                }.tabItem {
                        Image(systemName: "house.fill")
                    Text("Home")
                }
                NavigationView
                {
                    JokesCatagories()
                }
                .tabItem {
                    Image(systemName:"list.bullet")
                    Text("Catagories")
                }
                
            }
        }
    }
}

