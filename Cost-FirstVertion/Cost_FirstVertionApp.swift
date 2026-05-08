//
//  Cost_FistVirtionApp.swift
//  Cost-FistVirtion
//
//  Created by Yuxuan Cheng on 4/5/2026.
//

import SwiftUI

// MARK: - DATA MODEL

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let rentPrice: Int
    let buyPrice: Int
    let image: String
}

// MARK: - SAMPLE DATA

let items = [
    Item(
        name: "Re-Nylon Bomber Jacket",
        rentPrice: 15,
        buyPrice: 180,
        image: "jacket"
    ),
    
    Item(
        name: "Vintage Camera",
        rentPrice: 10,
        buyPrice: 120,
        image: "camera"
    )
]

// MARK: - MAIN APP VIEW

struct RenturnMainView: View {
    
    @State private var selectedTab = 0
    @State private var totalSaved = 65
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            ExploreView(totalSaved: $totalSaved)
                .tabItem {
                    Image(systemName: "safari")
                    Text("Explore")
                }
                .tag(0)
            
            InboxView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Inbox")
                }
                .tag(1)
            
            ProfileView(totalSaved: $totalSaved)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(2)
        }
        .accentColor(.blue)
    }
}

// MARK: - EXPLORE PAGE

struct ExploreView: View {
    
    @Binding var totalSaved: Int
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // HEADER
                    
                    HStack {
                        
                        Text("Renturn")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        Image(systemName: "bag")
                    }
                    .padding(.horizontal)
                    
                    
                    // SEARCH BAR
                    
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        Text("Search brands, styles...")
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    
                    // SAVING BANNER
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("🌱 Saving Garden")
                            .font(.headline)
                        
                        Text("You saved $\(totalSaved)")
                            .font(.title3)
                            .bold()
                        
                        Text("Rent instead of buy to grow your garden.")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green.opacity(0.15))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    
                    // ITEMS
                    
                    ForEach(items) { item in
                        
                        NavigationLink {
                            
                            ItemDetailView(
                                item: item,
                                totalSaved: $totalSaved
                            )
                            
                        } label: {
                            
                            VStack(alignment: .leading) {
                                
                                // IMAGE
                                
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(.systemGray5))
                                    .frame(height: 240)
                                    .overlay(
                                        Image(systemName: "photo")
                                            .font(.largeTitle)
                                            .foregroundColor(.gray)
                                    )
                                
                                
                                VStack(alignment: .leading, spacing: 10) {
                                    
                                    Text(item.name)
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.black)
                                    
                                    
                                    HStack {
                                        
                                        VStack(alignment: .leading) {
                                            
                                            Text("Rent")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                            
                                            Text("$\(item.rentPrice)")
                                                .font(.title2)
                                                .bold()
                                                .foregroundColor(.blue)
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .trailing) {
                                            
                                            Text("Buy")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                            
                                            Text("$\(item.buyPrice)")
                                                .font(.title3)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    
                                    Text("💰 Save $\(item.buyPrice - item.rentPrice)")
                                        .foregroundColor(.green)
                                        .bold()
                                }
                                .padding()
                            }
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius: 2)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - ITEM DETAIL

struct ItemDetailView: View {
    
    let item: Item
    
    @Binding var totalSaved: Int
    
    @State private var showConfirmation = false
    
    var savedAmount: Int {
        item.buyPrice - item.rentPrice
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color(.systemGray5))
                .frame(height: 320)
                .overlay(
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                )
                .padding()
            
            
            VStack(alignment: .leading, spacing: 15) {
                
                Text(item.name)
                    .font(.largeTitle)
                    .bold()
                
                
                HStack {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Rent")
                            .foregroundColor(.gray)
                        
                        Text("$\(item.rentPrice)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        
                        Text("Buy")
                            .foregroundColor(.gray)
                        
                        Text("$\(item.buyPrice)")
                            .font(.title2)
                    }
                }
                
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("💰 You Save $\(savedAmount)")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.green)
                    
                    Text("🌱 Renting helps grow your Saving Garden")
                        .foregroundColor(.green)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green.opacity(0.1))
                .cornerRadius(20)
            }
            .padding(.horizontal)
            
            
            Spacer()
            
            
            Button {
                
                totalSaved += savedAmount
                showConfirmation = true
                
            } label: {
                
                Text("Rent for $\(item.rentPrice)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.horizontal)
            }
            
            
            NavigationLink(
                destination: ConfirmationView(totalSaved: totalSaved),
                isActive: $showConfirmation
            ) {
                EmptyView()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - CONFIRMATION PAGE

struct ConfirmationView: View {
    
    let totalSaved: Int
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            Spacer()
            
            VStack(spacing: 15) {
                
                Text("🎉 Rental Confirmed!")
                    .font(.largeTitle)
                    .bold()
                
                Text("You saved $\(totalSaved)")
                    .font(.title2)
                    .foregroundColor(.green)
                
                Text("🌱 Your garden has grown!")
                    .font(.headline)
                    .foregroundColor(.green)
            }
            .padding()
            .background(Color.green.opacity(0.12))
            .cornerRadius(25)
            
            
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.green.opacity(0.2))
                .frame(height: 180)
                .overlay(
                    VStack {
                        
                        Text(gardenEmoji())
                            .font(.system(size: 70))
                        
                        Text(gardenLevel())
                            .font(.headline)
                    }
                )
            
            
            NavigationLink {
                
                ProfileView(totalSaved: .constant(totalSaved))
                
            } label: {
                
                Text("View Saving Garden")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
    }
    
    func gardenEmoji() -> String {
        
        if totalSaved < 100 {
            return "🌱"
        } else if totalSaved < 250 {
            return "🌿"
        } else {
            return "🌳"
        }
    }
    
    func gardenLevel() -> String {
        
        if totalSaved < 100 {
            return "Seedling Garden"
        } else if totalSaved < 250 {
            return "Growing Garden"
        } else {
            return "Saving Forest"
        }
    }
}

// MARK: - PROFILE PAGE

struct ProfileView: View {
    
    @Binding var totalSaved: Int
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                // PROFILE HEADER
                
                VStack(spacing: 10) {
                    
                    Circle()
                        .fill(Color.green.opacity(0.3))
                        .frame(width: 90, height: 90)
                        .overlay(
                            Text("🌱")
                                .font(.largeTitle)
                        )
                    
                    Text("VogueVintage")
                        .font(.title2)
                        .bold()
                    
                    Text("@gabe_curtiss")
                        .foregroundColor(.gray)
                }
                
                
                // GARDEN CARD
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Your Saving Garden")
                        .font(.headline)
                    
                    
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.green.opacity(0.15))
                        .frame(height: 160)
                        .overlay(
                            VStack(spacing: 12) {
                                
                                Text(gardenEmoji())
                                    .font(.system(size: 65))
                                
                                Text(gardenLevel())
                                    .font(.headline)
                            }
                        )
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("💰 Saved $\(totalSaved)")
                            .font(.title3)
                            .bold()
                        
                        Text("🌱 Grow your garden +1")
                            .foregroundColor(.green)
                        
                        Text("♻️ Reduced carbon footprint")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius: 2)
                .padding(.horizontal)
                
                
                // RECENT SAVINGS
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Recent Savings")
                        .font(.headline)
                    
                    savingCard(
                        title: "Prada Jacket",
                        amount: "$165 Saved"
                    )
                    
                    savingCard(
                        title: "Vintage Camera",
                        amount: "$110 Saved"
                    )
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
    }
    
    func savingCard(title: String, amount: String) -> some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(title)
                    .bold()
                
                Text(amount)
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            Text("🌱")
                .font(.title)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(18)
    }
    
    func gardenEmoji() -> String {
        
        if totalSaved < 100 {
            return "🌱"
        } else if totalSaved < 250 {
            return "🌿"
        } else {
            return "🌳"
        }
    }
    
    func gardenLevel() -> String {
        
        if totalSaved < 100 {
            return "Seedling Garden"
        } else if totalSaved < 250 {
            return "Growing Garden"
        } else {
            return "Saving Forest"
        }
    }
}

// MARK: - INBOX

struct InboxView: View {
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()
            
            Image(systemName: "message")
                .font(.system(size: 70))
                .foregroundColor(.blue)
            
            Text("Inbox")
                .font(.largeTitle)
                .bold()
            
            Text("Chat with renters and organise pickup times.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

// MARK: - PREVIEW

#Preview {
    RenturnMainView()
}
