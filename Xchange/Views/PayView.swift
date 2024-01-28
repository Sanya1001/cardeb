//
//  PayView.swift
//  Xchange
//
//  Created by Sania Sinha on 1/27/24.
//

import SwiftUI

struct PayView: View {
    let paymentHandler = PaymentHandler()
    var body: some View {
        Button(action: {
            self.paymentHandler.startPayment { (success) in
                if success {
                    print("Success")
                } else {
                    print("Failed")
                }
            }
        }, label: {
            Text("PAY WITH  APPLE")
                .font(Font.custom("HelveticaNeue-Bold", size: 16))
                .padding(10)
                .foregroundColor(.white)
        }
        )
    }
}

#Preview {
    PayView()
}
