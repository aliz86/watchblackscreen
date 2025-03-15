//
//  ContentView.swift
//  Black Screen Project Watch App
//
//  Created by Ali on 3/16/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // This view displays a full-screen black background.
        Color.black
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
