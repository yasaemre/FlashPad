//
//  Store.swift
//  FlashPad
//
//  Created by Emre Yasa on 9/17/21.
//

import StoreKit
import SwiftUI

typealias FetchCompletionHandler = (([SKProduct]) -> Void)
typealias PurchaseCompletionHandler = ((SKPaymentTransaction?) -> Void)

class Store: NSObject, ObservableObject {
    
   // @Published var allRecipes = [Recipe]()
    @Published var allProducts = [SKProduct]()

    private let allProductIdentifiers = Set([
        "emre.FlashPad.donation"
    ])

    private var completedPurchases = [String]() {
        didSet {
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
               
                !self.completedPurchases.contains(self.allProducts.description)
                
            }
        }
    }

    private var productsRequest: SKProductsRequest?
    private var fetchedProducts = [SKProduct]()
    private var fetchedCompletionHandler: FetchCompletionHandler?
    private var purchaseCompletionHandler: PurchaseCompletionHandler?
    override init() {
        super.init()
        startObservingPaymentQueue()
        fetchProducts { products in
            self.allProducts = products.map({ product in
                product
            })
            print(products)
        }
    }

    private func startObservingPaymentQueue() {
        SKPaymentQueue.default().add(self)
    }

    private func fetchProducts(_ completion: @escaping FetchCompletionHandler) {
        guard self.productsRequest == nil else { return }

        fetchedCompletionHandler = completion
        productsRequest = SKProductsRequest(productIdentifiers: allProductIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }

    private func buy(_ product: SKProduct, completion: @escaping PurchaseCompletionHandler) {
        purchaseCompletionHandler = completion
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
//    private var fetchedProducts = [SKProduct]()
//
//    func fetchProducts() {
//        async {
//            do {
//                let products = try await Product.request(with:"emre.FlashPad.donation")
//                print(products)
//                self.products = products
//            }
//            catch {
//                print("error")
//            }
//        }
//    }
//
//    func purchase() {
//        async {
//            guard let product = products.first else { return }
//            do {
//                let result = try await product.purchase()
//            }
//            catch {
//                print(error)
//            }
//        }
//    }
}

extension Store {
    
    func product(for identifier: String) -> SKProduct? {
        return fetchedProducts.first(where: {$0.productIdentifier == identifier})
    }
    
    func purchaseProduct(_ product: SKProduct) {
        startObservingPaymentQueue()
        buy(product) { _ in
            //
        }
    }
}

extension Store: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            var shouldFinishTransaction = false
            switch transaction.transactionState {
            case .purchased, .restored:
                completedPurchases.append(transaction.payment.productIdentifier)
                shouldFinishTransaction = true
            case .failed:
                shouldFinishTransaction = true
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }

            if shouldFinishTransaction {
                SKPaymentQueue.default().finishTransaction(transaction)
                DispatchQueue.main.async {
                    self.purchaseCompletionHandler?(transaction)
                    self.purchaseCompletionHandler = nil
                }
            }
        }
    }


}
extension Store:SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let loadedProducts = response.products
        let invalidProducts = response.invalidProductIdentifiers

        guard !loadedProducts.isEmpty else {
            print("Could not load the products!")

            if !invalidProducts.isEmpty {
                print("Invalid products found: \(invalidProducts)")
            }
            productsRequest = nil
            return
        }

        //Cache the fetched products
        fetchedProducts = loadedProducts

        //Notify anyone waiting on the product load
        DispatchQueue.main.async {
            self.fetchedCompletionHandler?(loadedProducts)

            self.fetchedCompletionHandler = nil
            self.productsRequest = nil
        }
    }


}
