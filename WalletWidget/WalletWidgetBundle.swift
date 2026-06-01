//
//  WalletWidgetBundle.swift
//  WalletWidget
//
//  Created by Hemang Solanki on 01/06/26.
//

import WidgetKit
import SwiftUI

@main
struct WalletWidgetBundle: WidgetBundle {
    var body: some Widget {
        WalletWidget()
        WalletWidgetControl()
        if #available(iOS 16.1, *) {
//            WalletWidgetLiveActivity()
        }
    }
}
