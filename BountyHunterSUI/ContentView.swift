//
//  ContentView.swift
//  BountyHunterSUI
//
//  Created by Ángel González on 14/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fvm = FugitiveViewModel()
    var body: some View {
        NavigationView {
            List(fvm.postData) { post in
                HStack {
                    Text("\(post.id)")
                        .padding()
                        .overlay(Circle().stroke(.blue))
                    Text(post.title)
                        .bold()
                        .lineLimit(1)
                }
            }
            .refreshable {
                await fvm.fetchData()
            }
            .navigationTitle("Fugitives")
            .onAppear {
                if fvm.postData.isEmpty {
                    Task {
                        await fvm.fetchData()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
