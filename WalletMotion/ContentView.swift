//
//  ContentView.swift
//  WalletMotion
//
//  Created by Hemang Solanki on 31/05/26.
//

import SwiftUI

struct Transaction: Identifiable {
    var id = UUID()
    var merchant: String
    var category: String
    var amount: String
    var icon: String
}

struct Card: Identifiable {
    var id = UUID()
    var color1: Color
    var color2: Color
    var type: String
    var number: String
    var expDate: String
    var cardHolder: String = "Hemang J. Solanki"
    var transactions: [Transaction]
}

let mockCards = [
    Card(color1: Color(red: 0.1, green: 0.1, blue: 0.2), color2: Color(red: 0.2, green: 0.2, blue: 0.4), type: "VISA", number: "****  ****  ****  1234", expDate: "12/28", transactions: [
        Transaction(merchant: "Apple Store", category: "Electronics", amount: "-$120.00", icon: "desktopcomputer"),
        Transaction(merchant: "Starbucks", category: "Food & Drink", amount: "-$5.50", icon: "cup.and.saucer.fill"),
        Transaction(merchant: "Uber", category: "Transport", amount: "-$24.00", icon: "car.fill")
    ]),
    Card(color1: Color(red: 0.8, green: 0.1, blue: 0.3), color2: Color(red: 0.9, green: 0.4, blue: 0.1), type: "Mastercard", number: "****  ****  ****  5678", expDate: "05/29", transactions: [
        Transaction(merchant: "Delta Airlines", category: "Travel", amount: "-$340.00", icon: "airplane"),
        Transaction(merchant: "Airbnb", category: "Travel", amount: "-$450.00", icon: "house.fill"),
        Transaction(merchant: "Uber", category: "Transport", amount: "-$45.00", icon: "car.fill")
    ]),
    Card(color1: Color(red: 0.0, green: 0.4, blue: 0.8), color2: Color(red: 0.2, green: 0.8, blue: 0.9), type: "AMEX", number: "****  ****  ****  9012", expDate: "08/27", transactions: [
        Transaction(merchant: "Nike", category: "Shopping", amount: "-$89.99", icon: "bag.fill"),
        Transaction(merchant: "Amazon", category: "Shopping", amount: "-$12.99", icon: "cart.fill"),
        Transaction(merchant: "Best Buy", category: "Electronics", amount: "-$199.99", icon: "desktopcomputer")
    ]),
    Card(color1: Color(red: 0.1, green: 0.5, blue: 0.2), color2: Color(red: 0.3, green: 0.8, blue: 0.4), type: "VISA", number: "****  ****  ****  3456", expDate: "11/30", transactions: [
        Transaction(merchant: "Whole Foods", category: "Groceries", amount: "-$85.50", icon: "basket.fill"),
        Transaction(merchant: "Trader Joe's", category: "Groceries", amount: "-$42.20", icon: "basket.fill"),
        Transaction(merchant: "Target", category: "Shopping", amount: "-$120.00", icon: "cart.fill")
    ])
]

struct ContentView: View {
    @State private var cards = mockCards
    @State private var selectedCard: Card? = nil
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("My Wallet")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding()
                
                ScrollView {
                    VStack(spacing: -80) {
                        ForEach(Array(cards.enumerated()), id: \.element.id) { index, card in
                            if selectedCard?.id != card.id {
                                CardView(card: card)
                                    .matchedGeometryEffect(id: card.id, in: animation)
                                    // Add subtle 3D tilt and offset based on position in stack
                                    .rotation3DEffect(.degrees(selectedCard == nil ? Double(index) * -3 : 0), axis: (x: 1, y: 0, z: 0))
                                    .offset(y: selectedCard == nil ? CGFloat(index) * 10 : 0)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                            selectedCard = card
                                        }
                                    }
                            } else {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(height: 200)
                            }
                        }
                    }
                    .padding()
                }
            }
            .opacity(selectedCard == nil ? 1 : 0)
            
            if let selected = selectedCard {
                ExpandedCardView(card: selected, animation: animation, selectedCard: $selectedCard)
                    .zIndex(1)
            }
        }
    }
}

struct CardView: View {
    var card: Card
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                Text("GLOBAL BANK")
                    .font(.system(size: 14, weight: .black, design: .rounded))
                    .foregroundColor(.white.opacity(0.9))
                    .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                
                Spacer()
                
                Image(systemName: "wave.3.right")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.8))
            }
            
            Spacer()
            
            // EMV Chip
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color(red: 0.9, green: 0.8, blue: 0.4), Color(red: 0.7, green: 0.6, blue: 0.2)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .frame(width: 45, height: 35)
                .overlay(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .stroke(Color.black.opacity(0.2), lineWidth: 1)
                )
                .overlay(
                    HStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 2).stroke(Color.black.opacity(0.2), lineWidth: 1).frame(width: 10, height: 25)
                        RoundedRectangle(cornerRadius: 2).stroke(Color.black.opacity(0.2), lineWidth: 1).frame(width: 10, height: 25)
                    }
                )
                .padding(.bottom, 15)
            
            Text(card.number)
                .font(.system(size: 24, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
                // Emboss effect
                .shadow(color: .black.opacity(0.5), radius: 1, x: 1, y: 1)
                .shadow(color: .white.opacity(0.4), radius: 1, x: -1, y: -1)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(.bottom, 20)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("CARDHOLDER")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.white.opacity(0.7))
                    Text(card.cardHolder.uppercased())
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 1, y: 1)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("VALID THRU")
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(.white.opacity(0.7))
                    Text(card.expDate)
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 1, y: 1)
                }
                .padding(.trailing, 20)
                
                // Realistic Logos
                if card.type == "Mastercard" {
                    ZStack {
                        Circle().fill(Color.red.opacity(0.8)).frame(width: 30, height: 30).offset(x: -10)
                        Circle().fill(Color.orange.opacity(0.8)).frame(width: 30, height: 30).offset(x: 10)
                    }
                    .frame(width: 50)
                } else if card.type == "VISA" {
                    Text("VISA")
                        .font(.system(size: 26, weight: .heavy, design: .rounded))
                        .italic()
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 1, y: 1)
                } else {
                    Text(card.type)
                        .font(.system(size: 22, weight: .heavy, design: .rounded))
                        .italic()
                        .foregroundColor(.white)
                }
            }
        }
        .padding(25)
        .frame(height: 220)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                // Base Gradient
                LinearGradient(gradient: Gradient(colors: [card.color1, card.color2]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                // Gloss Reflection Overlay
                LinearGradient(stops: [
                    .init(color: .white.opacity(0.3), location: 0),
                    .init(color: .white.opacity(0.05), location: 0.4),
                    .init(color: .clear, location: 0.401),
                    .init(color: .clear, location: 1)
                ], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: card.color1.opacity(0.4), radius: 15, x: 0, y: 10)
        // Add a subtle border to the card
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.white.opacity(0.2), lineWidth: 1)
        )
    }
}

struct ExpandedCardView: View {
    var card: Card
    var animation: Namespace.ID
    @Binding var selectedCard: Card?
    
    @State private var dragOffset: CGSize = .zero
    @State private var showList = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                        selectedCard = nil
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.primary)
                }
                Spacer()
            }
            .padding()
            .opacity(dragOffset == .zero ? 1 : 0)
            
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: animation)
                .frame(maxHeight: 250)
                .padding(.horizontal)
                .offset(y: dragOffset.height)
                .scaleEffect(1 - (abs(dragOffset.height) / 1000))
                .rotation3DEffect(.degrees(Double(dragOffset.height / 10)), axis: (x: 1, y: 0, z: 0))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height > 0 {
                                dragOffset = value.translation
                            }
                        }
                        .onEnded { value in
                            if value.translation.height > 100 {
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    selectedCard = nil
                                }
                            } else {
                                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    dragOffset = .zero
                                }
                            }
                        }
                )
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(Array(card.transactions.enumerated()), id: \.element.id) { index, transaction in
                        TransactionRow(transaction: transaction)
                            .opacity(showList ? 1 : 0)
                            .offset(y: showList ? 0 : 50)
                            .scaleEffect(showList ? 1 : 0.8)
                            .rotation3DEffect(.degrees(showList ? 0 : 20), axis: (x: 1, y: 0, z: 0))
                            .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.8).delay(Double(index) * 0.1), value: showList)
                    }
                }
                .padding(.top)
                .opacity(dragOffset == .zero ? 1 : 0)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    showList = true
                }
            }
            
            Spacer()
        }
        .background(Color(UIColor.systemBackground).ignoresSafeArea())
    }
}

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 50, height: 50)
                Image(systemName: transaction.icon)
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.merchant)
                    .font(.headline)
                Text(transaction.category)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(transaction.amount)
                .font(.headline)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
