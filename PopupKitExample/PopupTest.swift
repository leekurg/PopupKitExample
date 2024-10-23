//
//  PopupTest.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 17.10.2024.
//

import PopupKit
import SwiftUI

// stacked popup - with dismissing on outside tap

// text input popup - text input on the main screen

// fullscreen popup - respecting safe area

// alert with custom actions - actions with - rich - customization

struct PopupTest: View {
    @State private var stacked1 = false
    @State private var textInput = false
    @State private var fullscreen = false
    @State private var alert = false
    @State private var alertWithContent = false
    
    @State private var text = ""
    
    @EnvironmentObject private var presenter: PopupPresenter

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.76, green: 0.45, blue: 1)
                
                VStack {
                    Button("Stacked") {
                        stacked1.toggle()
                    }
                    
                    HStack {
                        Button("For text input") {
                            textInput.toggle()
                        }
                        
                        if !text.isEmpty {
                            Text(": \(text)")
                        }
                    }
                    
                    Button("Large") {
                        fullscreen.toggle()
                    }
                    
                    Divider()
                    
                    Group {
                        Button("Alert") {
                            alert.toggle()
                        }
                        
                        Button("Alert with user content") {
                            alertWithContent.toggle()
                        }
                    }
                    .tint(.orange)
                }
                .buttonStyle(.borderedProminent)
                .navigationTitle("Popup & alert")
            }
            .ignoresSafeArea()
        }
        .popup(isPresented: $stacked1) {
            PopupCongrats()
        }
    }
//        .popup(isPresented: $p1, ignoresEdges: []) {
//            VStack {
//                Text("Popup #1").font(.title2)
//                
//                Button("Button") {
//                    p11.toggle()
//                }
//                .buttonStyle(.borderedProminent)
//                
//                Button("Close") {
//                    presenter.popLast()
//                }
//                .buttonStyle(.borderedProminent)
//            }
//            .frame(width: 250, height: 200)
//            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
//        }
//        .popup(isPresented: $p11, outTapBehavior: .dismiss) {
//            RoundedRectangle(cornerRadius: 20)
//                .fill(.indigo)
//                .frame(width: 200, height: 400)
//                .overlay {
//                    Button("Close") {
//                        p11 = false
//                    }
//                    .buttonStyle(.borderedProminent)
//                }
//        }
//        .popup(isPresented: $p2, ignoresEdges: .top) {
//            Color.brown
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .padding(.horizontal)
//                .overlay {
//                    Button("Close") {
//                        p2 = false
//                    }
//                    .buttonStyle(.borderedProminent)
//                }
//        }
//        .popup(isPresented: $pText, outTapBehavior: .dismiss) {
//            PopupText(text: $text)
//        }
//        .alert("Title", isPresented: $alert) {
//            Button("Delete", role: .destructive) { }
//            
//            Button("With image", systemImage: "gear") { }
//            
//            Button("Regular", systemImage: "gear") { }
//            Button("Regular", systemImage: "gear") { }
//            Button("Regular", systemImage: "gear") { }
//            Button("Regular", systemImage: "gear") { }
//            Button("Regular", systemImage: "gear") { }
//            Button("Regular", systemImage: "gear") { }
//        } message: {
//            Text("This is an alert message")
//        }
//        .popupAlert(
//            isPresented: $popupAlert,
//            title: "Title",
//            msg: "Message"
//        ) {
//            Regular(
//                text: Text("Action with icon"),
//                image: .systemName("sparkles"),
//                action: {}
//            )
//            Destructive(
//                text: Text("Destructive action"),
//                action: {}
//            )
//        }
//        .popupAlert(isPresented: $popupAlertCustom) {
//            AnimatedSquare().padding(30)
//        } actions: {
//            
//        }
}

struct PopupCongrats: View {
    @State var animatedColor = false
    @State var animatedScale = false
    @State var popup = false

    @EnvironmentObject var presenter: PopupPresenter
    
    var body: some View {
        VStack {
            Image(systemName: "hands.sparkles.fill")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundStyle(animatedColor ? .red : .orange)
                .rotationEffect(.degrees(animatedScale ? 360 : 0))
                .onAppear {
                    withAnimation(
                        .easeInOut(duration: 0.5).repeatForever(autoreverses: true)
                    ) {
                        animatedColor.toggle()
                    }

                    withAnimation(
                        .spring(duration: 1)
                        .delay(0.2)
                        .repeatForever(autoreverses: true)
                    ) {
                        animatedScale.toggle()
                    }
                }
            
            Text("Fully customizable popups!")
                .font(.system(size: 20, weight: .semibold, design: .rounded))
            
            Button("Stack another one!") {
                popup.toggle()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top, 10)

            Button("Close") {
                presenter.popLast()
            }
        }
        .padding([.horizontal, .top], 30)
        .padding(.bottom, 20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
        .tint(.purple)
        .popup(isPresented: $popup) {
            PopupStacked()
        }
    }
}

struct PopupStacked: View {
    @EnvironmentObject var presenter: PopupPresenter
    
    var body: some View {
        ZStack {
            Color.green
            Color.black.opacity(0.15)
            
            VStack {
                Text("Stack")
                Text("as much")
                Text("as")

                Text("you like!")
                    .foregroundStyle(.yellow)
            }
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .padding(.bottom, 30)
            .foregroundStyle(.white)
            
            Button("Close") {
                presenter.popLast()
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom)
            .tint(.purple)
        }
        .frame(width: 250, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

struct PopupText: View {
    @Binding var text: String

    var body: some View {
        VStack {
            Text("Input: \(text)")
            
            TextField("", text: $text, axis: .horizontal)
                .padding()
                .background(.ultraThinMaterial, in: Capsule())
                .padding()
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
//        .preferredColorScheme(.dark)
        .environment(\.popupActionTint, .blue)
}
