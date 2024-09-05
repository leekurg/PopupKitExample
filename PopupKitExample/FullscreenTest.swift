//
//  FullscreenTest.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 23.08.2024.
//

import PopupKit
import SwiftUI

struct FullscreenTest: View {
    var body: some View {
        ViewA(deep: 0)
    }
}

fileprivate struct ViewA: View {
    @State var deep: Int
    @State var f1 = false
    
    @EnvironmentObject var fullscreenPresenter: FullscreenPresenter

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
            
            VStack {
                Text("Fullscreen \(deep)")
                    .font(.title)
                
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
                
//                Button("") {
//                    fullscreenPresenter.popLast()
//                }
//                .buttonStyle(.bordered)
            }
            .fullscreen(isPresented: $f1) {
                ViewA(deep: deep + 1)
            }
        }
    }
}

#Preview {
    FullscreenTest()
        .debugPreviewFullscreenEnv(ignoresSafeAreaEdges: .all)
}
