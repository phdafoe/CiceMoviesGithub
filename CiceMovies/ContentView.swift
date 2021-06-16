//
//  ContentView.swift
//  CiceMovies
//
//  Created by cice on 15/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authState: AuthenticationManager
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        if currentPage > totalPages {
            if authState.loggedInUser != nil{
                MoviesCoordinator.navigation()
            } else {
                LoginView()
            }
        } else {
            WalkthroughView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
