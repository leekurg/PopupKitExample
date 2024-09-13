//
//  NotificationTest.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 23.08.2024.
//

import PopupKit
import SwiftUI

struct NotificationTest: View {
    @EnvironmentObject var presenter: NotificationPresenter
    
    @State var isSheet = false
    @State var count = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.orange.opacity(0.7)
                
                VStack {
                    Button {
                        count += 1

                        presenter.present(
                            id: UUID(),
                            expiration: count < 3 ? .timeout(.seconds(1)) : .never
                        ) {
                            Text(
                                count < 3
                                    ? "Expired in 1 second"
                                    : "Continious notification"
                            )
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
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(10)
                            .background(.white.opacity(0.2), in: Circle())
                            .foregroundStyle(.blue)
                    }
                    .padding()
                    
                    Button("Open sheet") {
                        isSheet.toggle()
                    }
                    .buttonStyle(.bordered)
                }
            }
            .ignoresSafeArea()
            .navigationTitle("Notification")
            .sheet(isPresented: $isSheet) {
                NavigationStack {
                    Button {
                        presenter.present(
                            id: UUID(),
                            expiration: .never
                        ) {
                            HStack(spacing: 40) {
                                Image(systemName: "sparkles")
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: 120, height: 120)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.purple)
                                
                                Text("Still on top!")
                                    .foregroundStyle(.green)
                                    .font(.system(.title2, design: .rounded, weight: .bold))
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(.thinMaterial)
                            }
                            .padding(.horizontal)
                        }
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(10)
                            .background(.black.opacity(0.1), in: Circle())
                            .foregroundStyle(.blue)
                    }
                    .padding()
                    .navigationTitle("System sheet")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

#Preview {
    NotificationTest()
        .previewPopupKit(.notification)
}
