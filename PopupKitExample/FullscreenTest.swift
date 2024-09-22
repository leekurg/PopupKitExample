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
    @State private var fi: MyIdent?
    @State private var fs = false
    @State private var fNavigation = false

    var body: some View {
        ZStack {
            Color.red.opacity(0.3)
            
            VStack {
                Button("PopupKit fullscreen") {
                    f1.toggle()
                }
                
                Button("PopupKit item fullscreen") {
                    fi = fi == nil ? MyIdent(id: UUID(), value: 3) : nil
                }
                
                Button("Navigatable fullscreen") {
                    fNavigation.toggle()
                }
                .buttonStyle(.bordered)

                Button("System fullscreen") {
                    fs.toggle()
                }
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
        .fullscreen(
            item: $fi,
            background: .green
        ) { item in
            Text("Fullscreen with item \(item.value)")
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
            ViewB(deep: 0)
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
    @State var deep: Int
    @State var f1 = false
    @State var fc = false
    
    @EnvironmentObject var fullscreenPresenter: FullscreenPresenter

    var body: some View {
        VStack {
            Text("Fullscreen #\(deep)")
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

struct NavigatableFullscreen: View {
    @State var path = NavigationPath()
    @EnvironmentObject var presenter: FullscreenPresenter
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack {
                    Button("Open next screen") {
                        path.append(Destination())
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Close") {
                        presenter.popLast()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.top, 50)
            }
            .navigationTitle("Combined")
            .navigationDestination(for: Destination.self) { _ in
                ScrollView {
                    Color.purple
                        .frame(height: 500)
                        .overlay {
                            Text("Hello, World!")
                                .foregroundStyle(.white)
                                .navigationTitle("Second screen")
                        }
                }
            }
        }
    }
    
    struct Destination: Hashable { }
}

fileprivate struct ViewB: View {
    let deep: Int
    @State var fc = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("System fullscreen #\(deep)")
            
            Button("Open") {
                fc.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Close") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .fullScreenCover(isPresented: $fc) {
            ViewB(deep: deep + 1)
        }
    }
}

#Preview {
    FullscreenTest()
        .previewPopupKit(.fullscreen)
}
