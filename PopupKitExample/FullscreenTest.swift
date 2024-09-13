//
//  FullscreenTest.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 23.08.2024.
//

import PopupKit
import SwiftUI

struct FullscreenTest: View {
    @State private var f1 = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.red.opacity(0.8)
                
                Button("PopupKit fullscreen") {
                    f1.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
            .fullscreen(
                isPresented: $f1,
                background: .ultraThinMaterial
            ) {
                ViewA(deep: 0)
            }
            .ignoresSafeArea()
            .navigationTitle("Fullscreen")
        }
        .fullscreen(
            isPresented: $ft,
            background: .brown
        ) {
            TextFullscreen()
        }
        .fullscreen(
            isPresented: $fNavigation,
            background: .ultraThinMaterial,
            ignoresEdges: [.all],
            dismissalScroll: .none
        ) {
            NavigatableFullscreen()
        }
        .fullScreenCover(isPresented: $fs) {
            TextField("", text: .constant(""))
                .padding()
                .background(.ultraThinMaterial, in: Capsule())
                .padding()
        }
    }
}

extension FullscreenTest {
    struct MyIdent: Identifiable {
        let id: UUID
        let value: Int
    }
}

fileprivate struct ViewA: View {
    let deep: Int
    @State var f1 = false
    
    @EnvironmentObject var presenter: FullscreenPresenter

    var body: some View {
        VStack {
            Text("Fullscreen #\(deep)")
                .font(.system(.title, design: .monospaced))

            HStack {
                Button("Next fullscreen") {
                    f1.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.blue)
        .overlay(alignment: .topLeading) {
            Text("respects safe area")
                .font(.system(.caption, design: .monospaced))
                .foregroundStyle(.blue)
        }
        .overlay(alignment: .topTrailing) {
            Button {
                presenter.popLast()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(10)
                    .background(.white.opacity(0.2), in: Circle())
                    .foregroundStyle(.gray)
            }
            .padding()
        }
        .fullscreen(isPresented: $f1, background: .ultraThinMaterial) {
            ViewA(deep: deep + 1)
        }
    }
}

#Preview {
    FullscreenTest()
        .previewPopupKit(.fullscreen)
}
