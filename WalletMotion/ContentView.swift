//
//  ContentView.swift
//  WalletMotion
//
//  Created by Hemang Solanki on 31/05/26.
//

import SwiftUI
import LocalAuthentication

func playHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.prepare()
    generator.impactOccurred()
}

func playSuccessHaptic() {
    let generator = UINotificationFeedbackGenerator()
    generator.prepare()
    generator.notificationOccurred(.success)
}

func playErrorHaptic() {
    let generator = UINotificationFeedbackGenerator()
    generator.prepare()
    generator.notificationOccurred(.error)
}

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
        Transaction(merchant: "Starbucks", category: "Food & Drink", amount: "$5.50", icon: "cup.and.saucer.fill"),
        Transaction(merchant: "Uber", category: "Transport", amount: "$24.00", icon: "car.fill")
    ]),
    Card(color1: Color(red: 0.8, green: 0.1, blue: 0.3), color2: Color(red: 0.9, green: 0.4, blue: 0.1), type: "Mastercard", number: "****  ****  ****  5678", expDate: "05/29", transactions: [
        Transaction(merchant: "Delta Airlines", category: "Travel", amount: "$340.00", icon: "airplane"),
        Transaction(merchant: "Airbnb", category: "Travel", amount: "$450.00", icon: "house.fill"),
        Transaction(merchant: "Uber", category: "Transport", amount: "$45.00", icon: "car.fill")
    ]),
    Card(color1: Color(red: 0.0, green: 0.4, blue: 0.8), color2: Color(red: 0.2, green: 0.8, blue: 0.9), type: "AMEX", number: "****  ****  ****  9012", expDate: "08/27", transactions: [
        Transaction(merchant: "Nike", category: "Shopping", amount: "$89.99", icon: "bag.fill"),
        Transaction(merchant: "Amazon", category: "Shopping", amount: "$12.99", icon: "cart.fill"),
        Transaction(merchant: "Best Buy", category: "Electronics", amount: "$199.99", icon: "desktopcomputer")
    ]),
    Card(color1: Color(red: 0.1, green: 0.5, blue: 0.2), color2: Color(red: 0.3, green: 0.8, blue: 0.4), type: "VISA", number: "****  ****  ****  3456", expDate: "11/30", transactions: [
        Transaction(merchant: "Whole Foods", category: "Groceries", amount: "$85.50", icon: "basket.fill"),
        Transaction(merchant: "Trader Joe's", category: "Groceries", amount: "$42.20", icon: "basket.fill"),
        Transaction(merchant: "Target", category: "Shopping", amount: "$120.00", icon: "cart.fill")
    ])
]

struct ContentView: View {
    @State private var cards = mockCards
    @State private var selectedCard: Card? = nil
    @Namespace private var animation
    @State private var appear = false
    
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
                                    .rotation3DEffect(.degrees(selectedCard == nil ? Double(index) * -3 : 0), axis: (x: 1, y: 0, z: 0))
                                    .offset(y: selectedCard == nil ? CGFloat(index) * 10 : 0)
                                    .offset(y: appear ? 0 : 800)
                                    .animation(.spring(response: 0.6, dampingFraction: 0.6).delay(Double(index) * 0.1), value: appear)
                                    .onTapGesture {
                                        playHaptic(style: .light)
                                        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.55, blendDuration: 0.5)) {
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
            
            // Re-introducing the extraordinary simulated Dynamic Island!
            VStack {
                DynamicIslandView(cards: $cards, selectedCard: $selectedCard)
                    .padding(.top, 11)
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
            .zIndex(3)
        }
        .statusBarHidden(selectedCard != nil) // Hides the Time and Battery when island expands!
        .onAppear {
            appear = true
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
                LinearGradient(gradient: Gradient(colors: [card.color1, card.color2]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
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
                    playHaptic(style: .light)
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.55, blendDuration: 0.5)) {
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
            .padding(.top, 40)
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
                                playHaptic(style: .light)
                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.55, blendDuration: 0.5)) {
                                    selectedCard = nil
                                }
                            } else {
                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.55, blendDuration: 0.5)) {
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
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        )
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
            
            Text("-\(transaction.amount)")
                .font(.headline)
                .foregroundColor(.red.opacity(0.8))
        }
        .padding(.horizontal)
    }
}

struct DynamicIslandView: View {
    @Binding var cards: [Card]
    @Binding var selectedCard: Card?
    
    // Auth phases: 0=hidden, 1=FaceID prompt, 2=Processing, 3=Success, 4=Failed
    @State private var phase = 0 
    @State private var isSpinning = false
    @State private var scanLineY: CGFloat = -15
    @State private var successPop = false
    
    var body: some View {
        ZStack {
            if let card = selectedCard {
                // LEFT SIDE CONTENT - Anchored perfectly to the left edge
                HStack {
                    HStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .fill(LinearGradient(colors: [card.color1, card.color2], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 32, height: 22)
                                .shadow(color: card.color1.opacity(0.5), radius: 5, x: 0, y: 3)
                            
                            Text(card.type == "Mastercard" ? "MC" : card.type)
                                .font(.system(size: 8, weight: .black, design: .rounded))
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(phase == 1 ? "FACE ID" : (phase == 2 ? "PROCESSING" : (phase == 4 ? "FAILED" : "PAID")))
                                .font(.system(size: 10, weight: .bold, design: .rounded))
                                .foregroundColor(phase == 1 ? .orange : (phase == 2 ? .blue : (phase == 4 ? .red : .green)))
                                .animation(.spring(response: 0.3), value: phase)
                            
                            Text(phase == 4 ? "$0.00" : "$999.00")
                                .font(.system(size: 14, weight: .heavy, design: .rounded))
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                .padding(.leading, 24)
                .opacity(phase == 0 ? 0 : 1)
                
                // RIGHT SIDE CONTENT - Anchored perfectly to the right edge
                HStack {
                    Spacer()
                    ZStack {
                        if phase == 1 {
                            // Phase 1: Face ID Prompt
                            ZStack {
                                Image(systemName: "faceid")
                                    .font(.system(size: 26, weight: .light))
                                    .foregroundColor(.gray.opacity(0.5))
                                
                                Image(systemName: "faceid")
                                    .font(.system(size: 26, weight: .light))
                                    .foregroundColor(.white)
                                    .mask(
                                        Rectangle()
                                            .fill(LinearGradient(colors: [.clear, .white, .clear], startPoint: .top, endPoint: .bottom))
                                            .frame(height: 20)
                                            .offset(y: scanLineY)
                                    )
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                                            scanLineY = 15
                                        }
                                    }
                            }
                            .transition(.scale.combined(with: .opacity))
                        } else if phase == 2 {
                            // Phase 2: Processing
                            ZStack {
                                Circle()
                                    .trim(from: 0.2, to: 1.0)
                                    .stroke(
                                        AngularGradient(gradient: Gradient(colors: [.blue, .cyan]), center: .center),
                                        style: StrokeStyle(lineWidth: 3, lineCap: .round)
                                    )
                                    .frame(width: 26, height: 26)
                                    .rotationEffect(.degrees(isSpinning ? 360 : 0))
                                    .onAppear {
                                        withAnimation(.linear(duration: 0.8).repeatForever(autoreverses: false)) {
                                            isSpinning = true
                                        }
                                    }
                            }
                            .transition(.scale.combined(with: .opacity))
                        } else if phase == 3 {
                            // Phase 3: Success
                            HStack(spacing: 8) {
                                Text("Done")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(.green)
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 26))
                                    .foregroundColor(.green)
                                    .scaleEffect(successPop ? 1.0 : 0.2)
                                    .onAppear {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                            successPop = true
                                        }
                                    }
                            }
                            .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
                        } else if phase == 4 {
                            // Phase 4: Failed
                            HStack(spacing: 8) {
                                Text("Error")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(.red)
                                
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 26))
                                    .foregroundColor(.red)
                            }
                            .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
                        }
                    }
                }
                .padding(.trailing, 24)
                .opacity(phase == 0 ? 0 : 1)
            }
        }
        // This width calculation ensures it always leaves the 125pt center dead-zone clear on any device!
        .frame(width: selectedCard != nil ? UIScreen.main.bounds.width - 24 : 125, height: selectedCard != nil ? 85 : 37)
        .background(
            Color.black
                // Burst of green glow exactly when phase 3 hits, red for phase 4
                .shadow(color: phase == 3 ? Color.green.opacity(0.6) : (phase == 2 ? Color.blue.opacity(0.4) : (phase == 4 ? Color.red.opacity(0.6) : .clear)), radius: phase >= 3 ? 40 : 20, x: 0, y: 15)
        )
        // A true capsule shape mimics the native island perfectly
        .clipShape(Capsule(style: .continuous))
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.65, blendDuration: 0.6), value: selectedCard?.id)
        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.5), value: phase)
        .onChange(of: selectedCard?.id) { newValue in
            if newValue != nil {
                triggerRealFaceID()
            } else {
                phase = 0
            }
        }
    }
    
    private func triggerRealFaceID() {
        // Reset states
        phase = 1
        scanLineY = -15
        successPop = false
        
        let context = LAContext()
        var error: NSError?
        
        // Wait a tiny bit for the island to expand before scanning
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Authenticate to complete your purchase of $999.00 at Apple Store."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                    DispatchQueue.main.async {
                        if success {
                            finishAuthentication(success: true)
                        } else {
                            finishAuthentication(success: false)
                        }
                    }
                }
            } else {
                // If simulator has no enrolled face, just simulate it anyway!
                finishAuthentication(success: true)
            }
        }
    }
    
    private func finishAuthentication(success: Bool) {
        if success {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                phase = 2 // Processing
            }
            playHaptic(style: .light)
            
            // Wait 1.2s for processing spinner
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                if phase != 0 {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        phase = 3 // Success
                    }
                    playSuccessHaptic()
                    insertNewTransaction()
                }
            }
        } else {
            // Failed
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                phase = 4
            }
            playErrorHaptic()
        }
    }
    
    private func insertNewTransaction() {
        guard let card = selectedCard else { return }
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            let newTx = Transaction(merchant: "Apple Store", category: "Electronics", amount: "$999.00", icon: "applelogo")
            
            // Use withAnimation so it pops into the list smoothly
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                cards[index].transactions.insert(newTx, at: 0)
                selectedCard = cards[index] // Re-assign to trigger UI updates
            }
        }
    }
}

#Preview {
    ContentView()
}
