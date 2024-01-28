//
//  PaymentHandler.swift
//  Xchange
//
//  Created by Sania Sinha on 1/27/24.
//

import Foundation
import PassKit
import SwiftUI

//class PaymentHandler: NSObject {
//    static let supportedNetworks: [PKPaymentNetwork] = [
//        .amex,
//        .discover,
//        .masterCard,
//        .visa
//    ]
//
//
//    class func applePayStatus() -> (canMakePayments: Bool, canSetupCards: Bool) {
//        return (PKPaymentAuthorizationController.canMakePayments(),
//                PKPaymentAuthorizationController.canMakePayments(usingNetworks: supportedNetworks))
//    }
//    
//    func shippingMethodCalculator() -> [PKShippingMethod] {
//        // Calculate the pickup date.
//        
//        let today = Date()
//        let calendar = Calendar.current
//        
//        let shippingStart = calendar.date(byAdding: .day, value: 3, to: today)!
//        let shippingEnd = calendar.date(byAdding: .day, value: 5, to: today)!
//        
//        let startComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingStart)
//        let endComponents = calendar.dateComponents([.calendar, .year, .month, .day], from: shippingEnd)
//         
//        let shippingDelivery = PKShippingMethod(label: "Delivery", amount: NSDecimalNumber(string: "0.00"))
//        shippingDelivery.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)
//        shippingDelivery.detail = "Ticket sent to you address"
//        shippingDelivery.identifier = "DELIVERY"
//        
//        let shippingCollection = PKShippingMethod(label: "Collection", amount: NSDecimalNumber(string: "0.00"))
//        shippingCollection.detail = "Collect ticket at festival"
//        shippingCollection.identifier = "COLLECTION"
//        
//        return [shippingDelivery, shippingCollection]
//    }
//}


typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {

static let supportedNetworks: [PKPaymentNetwork] = [
    .amex,
    .masterCard,
    .visa
]

var paymentController: PKPaymentAuthorizationController?
var paymentSummaryItems = [PKPaymentSummaryItem]()
var paymentStatus = PKPaymentAuthorizationStatus.failure
var completionHandler: PaymentCompletionHandler?

func startPayment(completion: @escaping PaymentCompletionHandler) {
    
    print("start payment")

    let amount = PKPaymentSummaryItem(label: "Amount", amount: NSDecimalNumber(string: "1.00"), type: .final)
    let tax = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(string: "0.01"), type: .final)
    let total = PKPaymentSummaryItem(label: "ToTal", amount: NSDecimalNumber(string: "1.01"), type: .pending)

    paymentSummaryItems = [amount, tax, total];
    completionHandler = completion

    // Create our payment request
    let request = PKPaymentRequest()
    request.paymentSummaryItems = paymentSummaryItems
    request.merchantIdentifier = "merchant.com.exchangeui"
    request.merchantCapabilities = .threeDSecure
    request.countryCode = "US"
    request.currencyCode = "USD"
    request.supportedNetworks = PaymentHandler.supportedNetworks
    let controller = PKPaymentAuthorizationController(paymentRequest: request)
    controller.delegate = self
    controller.present { [weak self] presented in
       // Apple Pay presented from scene window
    }
    
//    let paymentRequest = PKPaymentRequest()
//    paymentRequest.paymentSummaryItems = paymentSummaryItems
//    paymentRequest.merchantIdentifier = "merchant.exchangeui"
//    paymentRequest.merchantCapabilities = .threeDSecure
//    paymentRequest.countryCode = "US"
//    paymentRequest.currencyCode = "USD"
//    paymentRequest.requiredShippingContactFields = [.phoneNumber, .emailAddress]
//    paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks

    // Display our payment request
//    paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
//    paymentController?.delegate = self
//    paymentController?.present(completion: { (presented: Bool) in
//        if presented {
//            NSLog("Presented payment controller")
//        } else {
//            NSLog("Failed to present payment controller")
//            self.completionHandler!(false)
//         }
//     })
  }
}

/*
    PKPaymentAuthorizationControllerDelegate conformance.
*/
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {

func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {

    // Perform some very basic validation on the provided contact information
//    if payment.shippingContact?.emailAddress == nil || payment.shippingContact?.phoneNumber == nil {
//        paymentStatus = .failure
//    } else {
        // Here you would send the payment token to your server or payment provider to process
        // Once processed, return an appropriate status in the completion handler (success, failure, etc)
        paymentStatus = .success
//    }

    completion(paymentStatus)
}

func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
    controller.dismiss {
        DispatchQueue.main.async {
            if self.paymentStatus == .success {
                self.completionHandler!(true)
            } else {
                self.completionHandler!(false)
            }
        }
    }
}

}

