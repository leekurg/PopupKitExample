//
//  CoverTest.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 25.08.2024.
//

import PopupKit
import SwiftUI

struct CoverTest: View {
    @State private var c1 = false
    @State private var c2 = false
    @State private var c3 = false
    @State private var c4 = false
    @State private var cNavigation = false
    @State private var ci: MyIdent?
    
    @EnvironmentObject var presenter: CoverPresenter
    
    var body: some View {
        ScrollView {
            Button("Non-modal half sheet 1") {
                c1.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Modal interactive half sheet 2") {
                c2.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Modal non-interactive 3/4 sheet 3") {
                c3.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Modal interactive very high sheet 4") {
                c4.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Modal interactive item sheet") {
                ci = ci == nil ? MyIdent(id: UUID(), value: 3) : nil
            }
            .buttonStyle(.borderedProminent)
            
            Button("Presenter present sheet") {
                presenter.present(
                    id: UUID(),
                    modal: .none,
                    background: .red,
                    cornerRadius: 30
                ) {
                    Text("Presented by presenter")
                        .foregroundStyle(.white)
                        .frame(height: 300)
                }
            }
            .buttonStyle(.borderedProminent)
            
            Button("Sheet with navigation") {
                cNavigation.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer(minLength: 300)
            
            Color.mint.frame(height: 150)
            Color.purple.frame(height: 150)
        }
        .cover(isPresented: $c1, background: .gray, modal: .none, cornerRadius: 10) {
            Text("Non-modal half sheet 1")
                .frame(height: 400)
        }
        .cover(isPresented: $c2, modal: .modal(interactivity: .interactive)) {
            VStack {
                Text("Modal interactive half sheet 2")
                    .padding(50)

                Button("Open sheet 3") {
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
                Text("Modal non-interactive 3/4 sheet 3")
                    .padding(50)
                
                Button("Close") {
                    c3.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(minHeight: 600)
        }
        .cover(
            isPresented: $c4,
            background: .indigo,
            modal: .modal(interactivity: .interactive)
        ) {
            VStack(spacing: 0) {
                Color.red.frame(height: 300)
                Color.yellow.frame(height: 300)
                Color.green.frame(height: 252)
                Color.blue.frame(height: 100)
            }
            .frame(width: 300)
        }
        .cover(
            item: $ci,
            background: .blue,
            modal: .modal(interactivity: .interactive)
        ) { item in
            Text("Item sheet with value \(item.value)")
                .foregroundStyle(.white)
                .font(.system(.title, design: .rounded, weight: .bold))
                .frame(height: 500)
        }
        .cover(
            isPresented: $cNavigation,
            background: .indigo,
            modal: .none
        ) {
            NavigationView {
                Button("Button") {
                    print("Tapped")
                }
                .navigationTitle("Title")
            }
        }
    }
}

extension CoverTest {
    struct MyIdent: Identifiable {
        let id: UUID
        let value: Int
    }
}

#Preview {
    CoverTest()
        .previewPopupKit(.cover(ignoredSafeAreaEdges: .all))
}
