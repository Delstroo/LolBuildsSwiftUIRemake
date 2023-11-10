//
//  ChampionDetailViewModel.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/13/23.
//

import Foundation

class ChampionDetailViewModel: ObservableObject {
    
    // MARK: DropDown Checks
    @Published var isPassiveTapped: Bool = false
    @Published var isQTapped: Bool = false
    @Published var isWTapped: Bool = false
    @Published var isETapped: Bool = false
    @Published var isRTapped: Bool = false
    
    @Published var champion: ChampionData?
    
    func fetchChampionDetail(networkLayer: NetworkLayer, champion: ChampionInfo, completion: @escaping (Result<ChampionData, NetworkError>) -> Void) {
        let baseURL = URL.apiEndpoint(url: URL.championURL)
        let champURL = baseURL.appendingPathComponent(champion.image.full.replacingOccurrences(of: ".png", with: ""))
        let finalURL = champURL.appendingPathExtension("json")
        var request = URLRequest(url: finalURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        networkLayer.fetch(request) { (result: Result<SelectedChampionTopLevelObject, NetworkError>) in
            switch result {
            case .success(let champion):
                DispatchQueue.main.async {
                    self.champion = champion.data.values.first!
                    completion(.success(champion.data.values.first!))
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.throwError(error)))
            }
        }
        
    }
    
}
