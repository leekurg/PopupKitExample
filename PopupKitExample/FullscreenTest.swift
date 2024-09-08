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
        ZStack {
            Color.red.opacity(0.3)
            
            Button("Full 1") {
                f1.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .fullscreen(
            isPresented: $f1,
            background: .ultraThinMaterial,
            ignoresEdges: [.bottom, .leading],
            dismissalScroll: .none
        ) {
            ViewA(deep: 0)
        }
    }
}

fileprivate struct ViewA: View {
    @State var deep: Int
    @State var f1 = false
    @State var fc = false
    
    @EnvironmentObject var fullscreenPresenter: FullscreenPresenter

    var body: some View {
        VStack {
            Text("Fullscreen \(deep)")
                .font(.title)
            
            Spacer()

            HStack {
                Button("Next fullscreen") {
                    f1.toggle()
                }
            }
            .buttonStyle(.borderedProminent)
            
            Button("Pop to root") {
                fullscreenPresenter.popToRoot()
            }
            .buttonStyle(.bordered)
            
            Button("Pop last") {
                fullscreenPresenter.popLast()
            }
            .buttonStyle(.bordered)
            
            Button("Real fullscreenCover") {
                fc.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.green)
        .fullscreen(isPresented: $f1) {
            ViewA(deep: deep + 1)
        }
        .fullScreenCover(isPresented: $fc) {
            Text("Real fullscreen cover")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .border(.red)
                .ignoresSafeArea(.all, edges: .top)
        }
    }
}

#Preview {
    FullscreenTest()
        .debugPreviewFullscreenEnv(ignoresSafeAreaEdges: .all)
}
