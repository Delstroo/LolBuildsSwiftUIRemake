//
//  Extension+URL.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/11/23.
//

import Foundation

extension URL {
    
    static var championURL: URL {
            return URL(string: "https://ddragon.leagueoflegends.com/cdn/13.20.1/data/en_US/champion")!
        }
    
    static var championSplashURL: URL {
        return URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/")!
    }
    
    static var championLoadingSplashURL: URL {
        return URL(string: "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/")!
    }
    
    static var championSpellImageURL: URL {
        return URL(string: "https://ddragon.leagueoflegends.com/cdn/12.3.1/img/spell/")!
    }
    
    static var championImageURL: URL {
        return URL(string: "https://ddragon.leagueoflegends.com/cdn/11.16.1/img/champion/")!
    }
    
    static var itemURL: URL {
        return URL(string: "https://ddragon.leagueoflegends.com/cdn/13.20.1/data/en_US/item")!
    }
    
    static var itemImageURL: URL {
        return URL(string: "https://ddragon.leagueoflegends.com/cdn/13.20.1/img/item/")!
    }
    
    static var hdItemImageURL: URL {
        return URL(string: "https://leagueofitems.com/images/items/256/")!
    }
    
    static func apiEndpoint(url: URL, query: String? = nil ,queryValue: String? = nil) -> URL {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = [URLQueryItem(name: query ?? "", value: queryValue ?? "")]
            return components?.url ?? url
        }
}

extension String {
    func formattedString() -> String {
        // Remove special characters and spaces
        var cleanedString = self.replacingOccurrences(of: "[^a-zA-Z0-9]", with: "", options: .regularExpression)
        
        // Capitalize the first letter and make the rest lowercase
        if let firstChar = cleanedString.first {
            let restOfString = String(cleanedString.dropFirst()).lowercased()
            cleanedString = String(firstChar) + restOfString
        }
        
        return cleanedString
    }
}

extension String {
    func removeWhitespace() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension String {
    func replaceCapitalLetters() -> String {
        do {
            // Add a space after a capital letter if it is followed by a digit
            let regex = try NSRegularExpression(pattern: "([A-Z])([0-9])", options: .caseInsensitive)
            let range = NSRange(self.startIndex..<self.endIndex, in: self)
            let modifiedString = regex.stringByReplacingMatches(in: self, range: range, withTemplate: "$1 $2")
            
            // Then, add a space after a digit if it is followed by a capital letter
            let modifiedRange = NSRange(modifiedString.startIndex..<modifiedString.endIndex, in: modifiedString)
            let finalString = regex.stringByReplacingMatches(in: modifiedString, range: modifiedRange, withTemplate: "$1 $2")
            
            return finalString
        } catch {
            print("Regex error: \(error.localizedDescription)")
            return self
        }
    }
}

