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
        .fullScreenCover(isPresented: $fs) {
            ViewB(deep: 0)
        }
    }
}

struct FullWithText: View {
    @FocusState private var focused: Focused?
    @State var text = ""

    var body: some View {
        ScrollView {
            VStack {
                ForEach(1...10, id: \.self) { id in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray)
                        .frame(height: 100)
                        .overlay {
                            Text("\(id)")
                        }
                }
            }
        }
        .clipped()
        .border(.red)
    }
    
    var textField: some View {
        TextField("Title", text: $text, axis: .horizontal)
            .padding(10)
            .background(.ultraThinMaterial, in: Capsule())
            .padding()
            .focused($focused, equals: .textField)
    }
    
    enum Focused {
        case textField
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
