//
//  Cost_FistVirtionApp.swift
//  Cost-FistVirtion
//
//  Created by Yuxuan Cheng on 4/5/2026.
//

import SwiftUI
import Foundation
import SwiftUI

@main
struct Cost_FistVirtionApp: App {
    
    var body: some Scene {
        
        WindowGroup {
            RenturnHomeView()
        }
    }
}

// MARK: - User

struct User: Identifiable {
    let id: String
    var name: String
    var location: String
    var totalSaved: Double
    var gardenLevel: Int
}

// MARK: - Item

struct Item: Identifiable {
    let id: String
    var name: String
    var category: String
    var rentPrice: Double
    var buyPrice: Double
    var location: String
    var ownerId: String
    var isAvailable: Bool
}

// MARK: - Rental

struct Rental: Identifiable {
    let id: String
    var userId: String
    var itemId: String
    var startDate: Date
    var endDate: Date
    var status: RentalStatus
}

// MARK: - Rental Status Enum

enum RentalStatus: String {
    case pending
    case active
    case completed
    case cancelled
}

// MARK: - Payment

struct Payment: Identifiable {
    let id: String
    var rentalId: String
    var amount: Double
    var method: PaymentMethod
    var paymentDate: Date
}

// MARK: - Payment Method Enum

enum PaymentMethod: String {
    case card
    case paypal
    case applePay
    case cash
}

// MARK: - Saving Record

struct Saving: Identifiable {
    let id: String
    var userId: String
    var amountSaved: Double
    var carbonEquivalent: Double
    var date: Date
}

// MARK: - Saving Garden

struct SavingGarden {
    var userId: String
    var totalPlants: Int
    var level: Int
    var coins: Int
}

// MARK: - Saving Farm

struct SavingFarm {
    var plantType: String
    var growthPeriod: Int
    var seedPrice: Int
    var savingCoinReward: Int
}

// MARK: - Message

struct Message: Identifiable {
    let id: String
    var senderId: String
    var receiverId: String
    var content: String
    var timestamp: Date
}

// MARK: - Calendar

struct RentalCalendar {
    var userId: String
    var rentals: [Rental]
}

// MARK: - Notification

struct AppNotification: Identifiable {
    let id: String
    var userId: String
    var message: String
    var date: Date
    var isRead: Bool
}

// MARK: - Sample Data

let sampleItems: [Item] = [
    
    Item(
        id: "1",
        name: "Prada Jacket",
        category: "Fashion",
        rentPrice: 20,
        buyPrice: 180,
        location: "Sydney",
        ownerId: "owner1",
        isAvailable: true
    ),
    
    Item(
        id: "2",
        name: "Camping Tent",
        category: "Outdoor",
        rentPrice: 15,
        buyPrice: 120,
        location: "Sydney",
        ownerId: "owner2",
        isAvailable: true
    ),
    
    Item(
        id: "3",
        name: "Speaker",
        category: "Electronics",
        rentPrice: 10,
        buyPrice: 90,
        location: "Sydney",
        ownerId: "owner3",
        isAvailable: true
    )
]

// MARK: - Main Home View

struct RenturnHomeView: View {
    
    @State private var totalSaved: Double = 0
    @State private var gardenLevel: Int = 1
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 20) {
                
                // Saving Garden Section
                
                VStack(spacing: 12) {
                    
                    Text("🌱 Saving Garden")
                        .font(.title2)
                        .bold()
                    
                    Text("You Saved: $\(Int(totalSaved))")
                        .font(.headline)
                    
                    Text(gardenEmoji())
                        .font(.system(size: 60))
                    
                    Text(gardenText())
                        .foregroundColor(.green)
                        .font(.headline)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.15))
                .cornerRadius(20)
                .padding(.horizontal)
                
                
                // Item List
                
                List(sampleItems) { item in
                    
                    NavigationLink(destination:
                        ItemDetailView(
                            item: item,
                            totalSaved: $totalSaved,
                            gardenLevel: $gardenLevel
                        )
                    ) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text(item.name)
                                .font(.headline)
                            
                            Text("Rent: $\(Int(item.rentPrice))")
                                .foregroundColor(.blue)
                            
                            Text("Buy: $\(Int(item.buyPrice))")
                                .foregroundColor(.gray)
                            
                            Text("💰 Save $\(Int(item.buyPrice - item.rentPrice))")
                                .foregroundColor(.green)
                                .bold()
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("Renturn")
        }
    }
    
    // MARK: - Garden Emoji
    
    func gardenEmoji() -> String {
        
        if totalSaved < 50 {
            return "🌱"
        } else if totalSaved < 150 {
            return "🌿"
        } else {
            return "🌳"
        }
    }
    
    // MARK: - Garden Text
    
    func gardenText() -> String {
        
        if totalSaved < 50 {
            return "Your garden is growing"
        } else if totalSaved < 150 {
            return "Your garden is blooming"
        } else {
            return "Your saving forest is thriving"
        }
    }
}

// MARK: - Item Detail View

struct ItemDetailView: View {
    
    var item: Item
    
    @Binding var totalSaved: Double
    @Binding var gardenLevel: Int
    
    @State private var showConfirmation = false
    
    var savedAmount: Double {
        item.buyPrice - item.rentPrice
    }
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            Spacer()
            
            Text(item.name)
                .font(.largeTitle)
                .bold()
            
            Text(item.category)
                .foregroundColor(.gray)
            
            VStack(spacing: 10) {
                
                Text("Rent Price: $\(Int(item.rentPrice))")
                    .font(.title2)
                    .foregroundColor(.blue)
                
                Text("Buy Price: $\(Int(item.buyPrice))")
                    .foregroundColor(.gray)
                
                Text("💰 You Save $\(Int(savedAmount))")
                    .font(.title2)
                    .foregroundColor(.green)
                    .bold()
                
                Text("🌱 This rental grows your saving garden")
                    .foregroundColor(.green)
            }
            .padding()
            
            
            // Rent Button
            
            Button(action: {
                
                totalSaved += savedAmount
                
                if totalSaved > 50 {
                    gardenLevel = 2
                }
                
                if totalSaved > 150 {
                    gardenLevel = 3
                }
                
                showConfirmation = true
                
            }) {
                
                Text("Rent Now")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
            }
            .padding(.horizontal)
            
            
            Spacer()
        }
        .padding()
        .navigationDestination(isPresented: $showConfirmation) {
            ConfirmationView(savedAmount: savedAmount)
        }
    }
}

// MARK: - Confirmation View

struct ConfirmationView: View {
    
    var savedAmount: Double
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            Spacer()
            
            Text("🎉 Rental Confirmed!")
                .font(.largeTitle)
                .bold()
            
            Text("You saved $\(Int(savedAmount))")
                .font(.title2)
                .foregroundColor(.green)
            
            Text("🌱 Your Saving Garden has grown!")
                .font(.title3)
                .foregroundColor(.green)
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Preview

#Preview {
    RenturnHomeView()
}
