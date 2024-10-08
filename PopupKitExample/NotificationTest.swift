//
//  NotificationTest.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 23.08.2024.
//

import PopupKit
import SwiftUI

struct NotificationTest: View {
    @EnvironmentObject var notificationPresenter: NotificationPresenter
    
    @State var path = NavigationPath()
    @State var isFullscreen = false
    @State var isSheet = false
    
    @State var n1 = false
    @State var n2 = false
    @State var n3 = false
    @State var n4 = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                Button("Continuous notification 1") {
                    n1.toggle()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Continuous notification 2") {
                    n2.toggle()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Continuous notification 3") {
                    n3.toggle()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Show notification 4") {
                    n4.toggle()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Pop to root") {
                    notificationPresenter.popToRoot()
                }
                .buttonStyle(.bordered)
                
                Button("Pop last") {
                    notificationPresenter.popLast()
                }
                .buttonStyle(.bordered)
                
                Button {
                    n1.toggle()
                    n2.toggle()
                    n3.toggle()
                    n4.toggle()
                } label: {
                    Text("SHOW ALL")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .padding()
                        .background(.blue, in: Capsule())
                }
                
                Button {
                    path.append(DestinationA())
                } label: {
                    Text("Push to A")
                        .padding(10)
                        .background(.orange, in: Capsule())
                }
                
                Button {
                    isFullscreen.toggle()
                } label: {
                    Text("Fullscreen to B")
                        .padding(10)
                        .background(.orange, in: Capsule())
                }
                
                Button {
                    isSheet.toggle()
                } label: {
                    Text("Sheet to B")
                        .padding(10)
                        .background(.orange, in: Capsule())
                }
                
                Button {
                    for entry in notificationPresenter.stack {
                        print("[\(entry.deep)]: \(entry.id)")
                    }
                } label: {
                    Text("Reveal stack")
                        .foregroundStyle(.white)
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .background(.indigo, in: RoundedRectangle(cornerRadius: 25))
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.bottom, 100)
                
                Color.red.frame(height: 30)
                Color.indigo.frame(height: 30)
                Color.yellow.frame(height: 30)
            }
            .navigationTitle("Title")
            .navigationDestination(for: DestinationA.self) { _ in
                NotificationViewA()
            }
            .fullScreenCover(isPresented: $isFullscreen) {
                NotificationViewB(isPresented: $isFullscreen)
            }
            .sheet(isPresented: $isSheet) {
                NotificationViewB(isPresented: $isSheet)
            }
            .notification(isPresented: $n1, expiration: .never) {
                Text("Continuous notification 1")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background(.orange)
                    .clipShape(Capsule())
                    .padding(.horizontal)
            }
            .notification(isPresented: $n2, expiration: .never) {
                Rectangle()
                    .fill(.thinMaterial)
                    .overlay {
                        Text("Continuous Notification 2")
                    }
                    .frame(height: 300)
            }
            .notification(isPresented: $n3, expiration: .never) {
                Rectangle()
                    .fill(.background)
                    .overlay {
                        Text("Continuous Notification 3")
                    }
                    .overlay(
                        Rectangle()
                            .strokeBorder(
                                .green,
                                style: .init(
                                    lineWidth: 3,
                                    lineCap: .round,
                                    dash: [5,5]
                                )
                            )
                    )
                    .frame(height: 300)
                    .frame(maxHeight: .infinity)
            }
            .notification(isPresented: $n4) {
                Text("Notification 4")
                    .frame(maxWidth: .infinity, minHeight: 100)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.thinMaterial)
                            .overlay {
                                ContainerRelativeShape()
                                    .stroke(.blue, lineWidth: 0.5)
                                    .padding(5)
                            }
                    }
                    .containerShape(RoundedRectangle(cornerRadius: 30))
                    .padding(.horizontal)
            }
        }
    }
    
    struct DestinationA: Hashable { }
}

struct NotificationViewA: View {
    @State private var isNotified = false
    
    var body: some View {
        VStack {
            Text("NotificationViewA")
            
            Button("Show notification") {
                isNotified.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .notification(isPresented: $isNotified) {
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundStyle(.mint)
                    .padding()
                
                Text("Nested notification")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct NotificationViewB: View {
    @EnvironmentObject var presenter: NotificationPresenter
    @State private var isNotified = false
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("NotificationViewB")
            
            Button("Show notification") {
                isNotified.toggle()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Close") {
                isPresented = false
            }
            .buttonStyle(.bordered)
        }
        .notification(isPresented: $isNotified) {
            HStack {
                Image(systemName: "star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundStyle(.mint)
                    .padding()
                
                Text("Fullscreen notification")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    NotificationTest()
        .previewPopupKit(.notification)
}
