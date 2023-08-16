//
//  Constant.swift
//  Sample POC
//
//  Created by Anuj Kumar on 16/08/23.
//

import Foundation
import SwiftUI

// Hidde view background
struct FormHiddenBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content.onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear {
                UITableView.appearance().backgroundColor = .systemGroupedBackground
            }
        }
    }
}
