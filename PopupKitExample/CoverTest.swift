//
//  CoverTest.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 25.08.2024.
//

import SwiftUI

struct CoverTest: View {
    @State private var c1 = false
    @State private var c2 = false
    @State private var c3 = false
    
    var body: some View {
        ScrollView {
            Button("Half sheet 1") {
                c1.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Half sheet 2") {
                c2.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Half sheet 3") {
                c3.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer(minLength: 300)
            
            Color.mint.frame(height: 150)
            Color.purple.frame(height: 150)
        }
        .cover(isPresented: $c1, background: .gray, modal: .none, cornerRadius: 10) {
            Text("Half sheet 1")
                .frame(height: 400)
        }
        .cover(isPresented: $c2, modal: .modal(interactivity: .interactive)) {
            VStack {
                Text("Half sheet 2")
                    .padding(50)

                Button("Open C3") {
                    c3.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(minHeight: 400)
        }
        .cover(
            isPresented: $c3,
            background: .brown,
            modal: .modal(interactivity: .noninteractive),
            cornerRadius: 50
        ) {
            VStack {
                Text("Half sheet 3")
                    .padding(50)
                
                Button("Close") {
                    c3.toggle()
                    print("Tappped")
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(minHeight: 600)
        }
    }
}

#Preview {
    CoverTest()
        .debugPreviewCoverEnv(ignoresSafeAreaEdges: [.bottom])
}
