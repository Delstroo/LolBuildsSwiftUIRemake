//
//  ChampionHomeViewModel.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/12/23.
//

import Combine
import Foundation

class ChampionHomeViewModel: ObservableObject {
    
    enum ChampionTypeSort: String, CaseIterable {
        case All = "All"
        case Fighter = "Fighter"
        case Tank = "Tank"
        case Marksman = "Marksman"
        case Mage = "Mage"
        case Assassin = "Assassin"
        case Support = "Support"
    }
    
    @Published var categorySelected = "All"
    @Published var sortType: ChampionTypeSort = .All
    @Published var champions: [ChampionInfo] = []

    func fetchChampions(networkLayer: NetworkLayer, completion: @escaping (Result<[ChampionInfo], NetworkError>) -> Void) {
        let url = URL.apiEndpoint(url: URL.championURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        guard let finalURL = components?.url?.appendingPathExtension("json") else { return }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = HTTPMethod.get.rawValue

        networkLayer.fetch(request) { (result: Result<TopLevelObject, NetworkError>) in
            switch result {
            case .success(let championResult):
                // Extract and sort the champions
                DispatchQueue.main.async {
                    let championss = championResult.data.map { $0.value }.sorted(by: { $0.name < $1.name })
                    for champion in championss {
                        self.champions.append(champion)
                    }
                    completion(.success(self.champions))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

class RequestThrottler {
    private let queue = DispatchQueue(label: "com.example.RequestThrottler", attributes: .concurrent)
    private var requestQueue = [() -> Void]()
    private var isProcessing = false

    func throttle(_ requestBlock: @escaping () -> Void) {
        queue.async(flags: .barrier) {
            self.requestQueue.append(requestBlock)
            if !self.isProcessing {
                self.processNextRequest()
            }
        }
    }

    private func processNextRequest() {
        queue.async {
            guard !self.requestQueue.isEmpty else {
                self.isProcessing = false
                return
            }

            self.isProcessing = true
            let requestBlock = self.requestQueue.removeFirst()
            requestBlock()
            // Delay for a specific interval before processing the next request
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
                self.processNextRequest() // Adjust the delay interval as needed
            }
        }
    }
}

