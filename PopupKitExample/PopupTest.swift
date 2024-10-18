//
//  PopupTest.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 17.10.2024.
//

import PopupKit
import SwiftUI

struct PopupTest: View {
    @State private var p1 = false
    @State private var p11 = false
    @State private var p2 = false
    @State private var pText = false
    
    @State private var text = ""
    
    @EnvironmentObject private var presenter: PopupPresenter

    var body: some View {
        VStack {
            Text("Input: \(text)")
            
            Divider()
            
            Button("Popup 1") {
                p1.toggle()
            }
            
            Button("Popup 2") {
                p2.toggle()
            }
            
            Button("Popup Text") {
                pText.toggle()
            }
        }
        .buttonStyle(.borderedProminent)
        .popup(isPresented: $p1, ignoresEdges: []) {
            VStack {
                Text("Popup #1").font(.title2)
                
                Button("Button") {
                    p11.toggle()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Close") {
                    presenter.popLast()
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(width: 250, height: 200)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
        }
        .popup(isPresented: $p11, outTapBehavior: .dismiss) {
            RoundedRectangle(cornerRadius: 20)
                .fill(.indigo)
                .frame(width: 200, height: 400)
                .overlay {
                    Button("Close") {
                        p11 = false
                    }
                    .buttonStyle(.borderedProminent)
                }
        }
        .popup(isPresented: $p2, ignoresEdges: .top) {
            Color.brown
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                .overlay {
                    Button("Close") {
                        p2 = false
                    }
                    .buttonStyle(.borderedProminent)
                }
        }
        .popup(isPresented: $pText, outTapBehavior: .dismiss) {
            PopupText(text: $text)
        }
    }
}

struct PopupText: View {
    @Binding var text: String
    
    @EnvironmentObject var presenter: PopupPresenter

    var body: some View {
        VStack {
            Text("Input: \(text)")
            
            TextField("", text: $text, axis: .horizontal)
                .padding()
                .background(.ultraThinMaterial, in: Capsule())
                .padding()
            
            Button("Close") {
                presenter.popLast()
            }
            .buttonStyle(.bordered)
        }
        .frame(width: 300, height: 250)
        .background(.mint, in: RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    PopupTest()
        .previewPopupKit(.popup(ignoredSafeAreaEdges: []))
}
