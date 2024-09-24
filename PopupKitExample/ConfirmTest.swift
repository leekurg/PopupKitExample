//
//  ConfirmTest.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 24.09.2024.
//

import SwiftUI

struct ConfirmTest: View {
    @State var c1: Bool = false
    @State var cItem: MyIdent?
    @State var cs: Bool = false

    var body: some View {
        VStack {
            Button("Confirm example") {
                c1.toggle()
            }
            .buttonStyle(.borderedProminent)

            Button("Confirm item example") {
                cItem = cItem == nil ? .init(id: UUID(), value: 7) : nil
            }
            .buttonStyle(.borderedProminent)

            Button("System confirm example") {
                cs.toggle()
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            VStack(spacing: 0) {
                Color.mint.frame(height: 100)
                Color.blue.frame(height: 100)
                Color.indigo.frame(height: 100)
            }
        }
        .confirm(isPresented: $c1) {
            VStack(spacing: 20) {
                Circle()
                    .fill(.yellow)
                    .frame(width: 70)
                
                Text("Are you sure?")
            }
        } actions: {
            [
                .action(
                    text: Text("Action 1"),
                    action: {}
                ),
                .action(
                    text: Text("Action 2"),
                    image: .systemName("gear"),
                    action: {}
                ),
                .destructive(
                    text: Text("Destructive action"),
                    image: .systemName("sparkles"),
                    action: {}
                ),
                .cancel(text: Text("My cancel 1")),
                .cancel(text: Text("My cancel 2")),
                .action(
                    text: Text("Customized action".uppercased())
                        .font(.system(size: 20, weight: .thin))
                        .foregroundStyle(.indigo),
                    action: {}
                )
            ]
        }
        .confirm(item: $cItem) {
            [
                .action(text: Text("Action 1"), action: {})
            ]
        }
        .confirmationDialog("Title", isPresented: $cs) {
            Button("Action 1") {}

            Button("Action 2") {}

            Button("Action 3") {}
        }
        .confirmTint(.blue)
        .confirmFonts(
            regular: .system(size: 18, weight: .regular),
            cancel: .system(size: 18, weight: .semibold)
        )
    }
}

extension ConfirmTest {
    struct MyIdent: Identifiable {
        let id: UUID
        let value: Int
    }
}

#Preview {
    ConfirmTest()
        .previewPopupKit(.confirm)
        .confirmTint(.blue)
        .confirmFonts(
            regular: .system(size: 18, weight: .regular),
            cancel: .system(size: 18, weight: .semibold)
        )
}
