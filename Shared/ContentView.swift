//
//  ContentView.swift
//  Shared
//
//  Created by Eugene Agibalov on 30.03.2022.
//

import SwiftUI

struct quotes: Decodable {
    let USDRUB: Float
}

struct requestResult: Decodable {
    let quotes: quotes
}

struct ContentView: View {
    
    @State private var showRate = false
    @State private var rate : String = ""
    
    var body: some View {
        
        if !showRate {
            Button("Get rate"){
                
                let url = URL(string: "http://api.currencylayer.com/live?access_key=b2a1a15248dee0819102b0d420d67782&source=USD&currencies=RUB&format=1")!

                let task = URLSession.shared.dataTask(with: url){ (data, response, error) -> Void in
                    if let ers = error {
                        self.rate = ers.localizedDescription
                    } else {
                        let resp: requestResult = try! JSONDecoder().decode( requestResult.self, from: data!)
                        rate = "Dollar rate: " + String(resp.quotes.USDRUB) + " rub"
                    }
                    showRate.toggle()
                
                }
                task.resume()
            }
        }
        
        if showRate {
            Text(rate).padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

