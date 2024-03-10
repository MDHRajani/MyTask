//
//  HyperlinkDemo.swift
//  MyTask
//
//  Created by Maulik Rajani on 31/01/24.
//

import SwiftUI

struct HyperlinkDemo: View {
    var body: some View {
        VStack {
                    Text("Welcome to our app! ")
                        .foregroundColor(.black)
                    + Text("Click here to visit our website.")
                        .foregroundColor(.blue)
                        .underline()
                    + Text(" We hope you enjoy your experience.")
                        .foregroundColor(.black)
                }
                .padding()
                .overlay(
                    Button(action: {
                        // Open the link when tapped
                        if let url = URL(string: "https://www.example.com") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                )
    }
}

#Preview {
    HyperlinkDemo()
}
