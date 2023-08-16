//
//  ContentView.swift
//  Sample POC
//
//  Created by Anuj Kumar on 11/08/23.
//

import SwiftUI



enum SearchScope: String, CaseIterable {
    case inbox, favorites
}

struct ContentView: View {
    @State private var messages = [Message]()
    @State private var index = 0
    @State private var searchText = ""
    @State private var searchScope = SearchScope.inbox
    
    var body: some View {
        Color(UIColor(red: 37/255, green: 150/255, blue: 190/255, alpha: 1.0)).edgesIgnoringSafeArea(.all)
            .overlay(NavigationStack {
                VStack {
                    List {
                        VStack{
                            TabView(selection: $index) {
                                ForEach((0..<messages.count), id: \.self) { index in
                                    CardView(messages: messages[index].text)
                                }
                            }.background(.thinMaterial).overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth:1)
                            )
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                            
                            HStack(spacing: 2) {
                                ForEach((0..<3), id: \.self) { index in
                                    Circle()
                                        .fill(index == self.index ? Color.black : Color.black.opacity(0.5))
                                        .frame(width: 20, height: 20)
                                    
                                }
                                
                            }
                            SearchBar(text: $searchText).padding().background(.ultraThinMaterial)
                                .searchScopes($searchScope) {
                                    ForEach(SearchScope.allCases, id: \.self) { scope in
                                        
                                    }
                                }
                                .onAppear(perform: runSearch)
                                .onSubmit(of: .search, runSearch)
                                .onChange(of: searchScope) { _ in runSearch()
                                    
                                }
                        }
                        .frame(height: 300)
                        
                        ForEach(filteredMessages) { message in
                            VStack(alignment: .leading) {
                                HStack {
                                    VStack {
                                        Image(systemName: "cloud.heavyrain.fill")
                                    }
                                    VStack{
                                        Text(message.user)
                                            .font(.headline)
                                        Text(message.text)
                                    }
                                }
                            }
                        }
                    }
                }.modifier(FormHiddenBackground()).navigationTitle("Sample").navigationBarTitleDisplayMode(.inline)
            })
    }
    
    var filteredMessages: [Message] {
        if searchText.isEmpty {
            return messages
        } else {
            return messages.filter { $0.text.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func runSearch() {
        Task {
            guard let url = URL(string: "https://hws.dev/\(searchScope.rawValue).json") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            messages = try JSONDecoder().decode([Message].self, from: data)
        }
    }
}
