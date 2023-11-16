//
//  FugitiveViewModel.swift
//  BountyHunterSUI
//
//  Created by Ángel González on 15/11/23.
//

import Foundation

@MainActor class FugitiveViewModel: ObservableObject {
    @Published var postData = [TodoItem]()
    
    func fetchData() async {
        guard let downloadedPosts: [TodoItem] = await APIService().getTodos() else { return }
        postData = downloadedPosts
    }
}
