//
//  ConfirmTest.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 24.09.2024.
//

import SwiftUI

struct ConfirmTest: View {
    @State var c1: Bool = false

    var body: some View {
        Button("Confirm example") {
            c1.toggle()
        }
        .buttonStyle(.borderedProminent)
        .confirm(
            isPresented: $c1,
            background: .ultraThinMaterial,
            cornerRadius: 50
        ) {
            VStack(spacing: 20) {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 70)
                
                Text("Are you sure?")
            }
        } actions: {
            [
                .action(text: Text("Action 1").foregroundStyle(.blue)) {
                    print("Action 1 tapped")
                },
                .action(text: Text("Action 2"), image: .systemName("gear")) {
                    print("Action 2 tapped")
                },
                .cancel(text: Text("My cancel")),
                .destructive(text: Text("Destructive action").foregroundStyle(.blue)) {
                    print("Destructive action tapped")
                }
            ]
        }

    }
}

#Preview {
    ConfirmTest()
}
