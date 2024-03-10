//
//  MenuDemo.swift
//  MyTask
//
//  Created by Maulik Rajani on 03/03/24.
//

import SwiftUI

struct MenuDemo: View {
    
    @State private var selctedText = "Select"
    
    var body: some View {
        Menu(selctedText) {
            Button("Item 1") {
                selctedText = "Item 1"
            }
            Button("Item 2") {
                selctedText = "Item 2"
            }
            
            Menu("SubMenu") {
                Button("Sub Item 1") {
                    selctedText = "Sub Item 1"
                }
                Button("Sub Item 2") {
                    selctedText = "Sub Item 2"
                }
            }
        }
    }
}

#Preview {
    MenuDemo()
}
