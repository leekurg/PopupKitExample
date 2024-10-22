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
    @State private var alert = false
    @State private var popupAlert = false
    @State private var popupAlertCustom = false
    
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
            
            Button("System alert") {
                alert.toggle()
            }
            .buttonStyle(.bordered)
            
            Button("Popup alert text") {
                popupAlert.toggle()
            }
            .buttonStyle(.bordered)
            
            Button("Popup alert custom") {
                popupAlertCustom.toggle()
            }
            .buttonStyle(.bordered)
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
        .alert("Title", isPresented: $alert) {
            Button("Delete", role: .destructive) { }
            
            Button("With image", systemImage: "gear") { }
            
            Button("Regular", systemImage: "gear") { }
            Button("Regular", systemImage: "gear") { }
            Button("Regular", systemImage: "gear") { }
            Button("Regular", systemImage: "gear") { }
            Button("Regular", systemImage: "gear") { }
            Button("Regular", systemImage: "gear") { }
        } message: {
            Text("This is an alert message")
        }
        .popupAlert(
            isPresented: $popupAlert,
            title: "Title",
            msg: "Message"
        ) {
            [
                .action(
                    text: Text("Action with icon"),
                    image: .systemName("sparkles"),
                    action: {}
                ),
                .destructive(
                    text: Text("Destructive action"),
                    action: {}
                )
            ]
        }
        .popupAlert(isPresented: $popupAlertCustom) {
            AnimatedSquare().padding(30)
        } actions: {
            []
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

struct AnimatedSquare: View {
    @State private var animated = false

    var body: some View {
        RoundedRectangle(cornerRadius: animated ? 25 : 10)
            .fill(animated ? .orange : .purple)
            .frame(width: 50, height: 50)
            .rotationEffect(.degrees(animated ? 720 : 0))
            .onAppear {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    animated.toggle()
                }
            }
    }
}

#Preview {
    PopupTest()
        .previewPopupKit(.popup(ignoredSafeAreaEdges: []))
        .preferredColorScheme(.dark)
        .environment(\.popupActionTint, .blue)
}
