//
//  CardView.swift
//  Sample POC
//
//  Created by Anuj Kumar on 16/08/23.
//

import SwiftUI

struct CardView: View{
    var messages:String
    var body: some View{
        VStack{
            Text(messages)
            Image(systemName: "cloud.heavyrain.fill")
                .font(.largeTitle)
        }
    }
}
