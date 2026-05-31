# WalletMotion 💳✨

**WalletMotion** is a stunning, physics-driven, hyper-realistic Wallet UI built completely from scratch in **SwiftUI**. This project demonstrates advanced layout techniques, interactive gesture-driven physics, and beautiful premium UI components.

## ✨ Features

- **Hyper-Realistic Credit Cards**:
  - Detailed, multi-stop linear gradient backgrounds.
  - A glossy glassmorphism reflection overlay (diagonal light sheen).
  - Highly detailed, multi-layered gold EMV smart chip representation.
  - Embossed digit styling mimicking physical raised letters using dual-shadowing techniques.
  - Authentic, hand-drawn vector approximations of Mastercard and VISA logos.
  
- **Dynamic Data Models**:
  - Each card holds its own unique properties (Type, Number, Expiration, Cardholder Name).
  - Every card contains a unique list of realistic transactions mapped to specific merchants and categories.
  
- **Extraordinary Physics & Animations**:
  - **Hero Animation**: Smooth, flawless full-screen transitions from the stacked wallet into the detail view using `@Namespace` and `matchedGeometryEffect`.
  - **3D Interactive Swipe-to-Dismiss**: Dragging the expanded card downward dynamically scales it down and tilts it in 3D based on the drag offset, delivering an incredibly tangible feel.
  - **3D Parallax Stack**: Cards resting in the wallet stack are fanned out using 3D depth rotation and staggered offsets based on their position.
  - **Staggered 3D List Entrance**: The transaction list smoothly cascades in with a bouncing spring animation, utilizing `scaleEffect` and `rotation3DEffect` to make the rows literally flip into view.

## 🛠️ Technology Stack

- **Framework**: SwiftUI
- **Language**: Swift
- **Key APIs used**: 
  - `matchedGeometryEffect`
  - `.interactiveSpring`
  - `rotation3DEffect`
  - `DragGesture`

## 🚀 Getting Started

1. Open `ButtonAnimation.xcodeproj` in Xcode 15+.
2. Select `ContentView.swift`.
3. Start the **SwiftUI Preview** canvas (or build and run on an iOS Simulator).
4. Tap any card in the wallet stack to watch it expand.
5. Drag downwards on the expanded card to interactively dismiss it with full 3D physics!

---

*Designed and engineered with a focus on delivering a premium, state-of-the-art iOS user experience.*
