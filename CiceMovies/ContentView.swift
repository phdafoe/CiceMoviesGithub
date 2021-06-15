//
//  ContentView.swift
//  CiceMovies
//
//  Created by cice on 15/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        if currentPage > totalPages {
            MoviesCoordinator.navigation()
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
