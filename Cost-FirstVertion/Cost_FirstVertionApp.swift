//
//  Cost_FistVirtionApp.swift
//  Cost-FistVirtion
//
//  Created by Yuxuan Cheng on 4/5/2026.
//

import SwiftUI

// =======================================
// RENTURN APP
// =======================================

@main
struct RenturnApp: App {

    var body: some Scene {

        WindowGroup {

            iPhoneFrame {

                MainTabView()
            }
        }
    }
}

// =======================================
// DATA MODEL
// =======================================

struct Product: Identifiable {

    let id = UUID()

    let name: String
    let category: String
    let rentPrice: Int
    let buyPrice: Int
    let carbonSaved: Int
}

// =======================================
// SAMPLE DATA
// =======================================

let products = [

    Product(
        name: "Prada Re-Nylon Jacket",
        category: "Vintage",
        rentPrice: 45,
        buyPrice: 180,
        carbonSaved: 12
    ),

    Product(
        name: "Retro Camera",
        category: "Photography",
        rentPrice: 12,
        buyPrice: 140,
        carbonSaved: 6
    ),

    Product(
        name: "Party Speaker",
        category: "Party",
        rentPrice: 20,
        buyPrice: 260,
        carbonSaved: 9
    )
]

// =======================================
// MAIN TAB VIEW
// =======================================

struct MainTabView: View {

    @State private var totalSaved = 120

    var body: some View {

        TabView {

            ExploreView(totalSaved: $totalSaved)
                .tabItem {

                    Image(systemName: "safari")
                    Text("Explore")
                }

            InboxView()
                .tabItem {

                    Image(systemName: "message")
                    Text("Inbox")
                }

            ProfileView(totalSaved: $totalSaved)
                .tabItem {

                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .tint(
            Color(
                red: 20/255,
                green: 63/255,
                blue: 150/255
            )
        )
    }
}

// =======================================
// EXPLORE VIEW
// =======================================

struct ExploreView: View {

    @Binding var totalSaved: Int

    @State private var searchText = ""

    let tags = [
        "Prada",
        "Wedding",
        "Vintage",
        "Camera",
        "Party"
    ]

    var body: some View {

        NavigationStack {

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading, spacing: 24) {

                    // HEADER

                    HStack {

                        Text("Renturn")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.blue)

                        Spacer()

                        Image(systemName: "bag")
                            .font(.title2)
                    }

                    // SEARCH BAR

                    HStack {

                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField(
                            "Search brands, styles...",
                            text: $searchText
                        )
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)

                    // TAGS

                    ScrollView(.horizontal, showsIndicators: false) {

                        HStack(spacing: 12) {

                            ForEach(tags, id: \.self) { tag in

                                Text(tag)
                                    .font(.subheadline)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(Color.white)
                                    .cornerRadius(20)
                            }
                        }
                    }

                    // SAVING GARDEN

                    VStack(alignment: .leading, spacing: 12) {

                        Text("🌱 Saving Garden")
                            .font(.headline)

                        Text("You saved $\(totalSaved)")
                            .font(.largeTitle)
                            .bold()

                        Text("Rent instead of buying to grow your garden.")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green.opacity(0.12))
                    .cornerRadius(30)

                    // PRODUCTS

                    ForEach(products) { product in

                        NavigationLink {

                            ProductDetailView(
                                product: product,
                                totalSaved: $totalSaved
                            )

                        } label: {

                            VStack(alignment: .leading, spacing: 18) {

                                RoundedRectangle(cornerRadius: 28)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 250)
                                    .overlay(

                                        Image(systemName: "photo")
                                            .font(.system(size: 45))
                                            .foregroundColor(.gray)
                                    )

                                VStack(alignment: .leading, spacing: 12) {

                                    Text(product.category.uppercased())
                                        .font(.caption)
                                        .foregroundColor(.gray)

                                    Text(product.name)
                                        .font(.title2)
                                        .bold()
                                        .foregroundColor(.black)

                                    HStack {

                                        VStack(alignment: .leading) {

                                            Text("$\(product.rentPrice)")
                                                .font(.largeTitle)
                                                .bold()
                                                .foregroundColor(.blue)

                                            Text("DAILY RENT")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }

                                        Spacer()

                                        VStack(alignment: .trailing) {

                                            Text("Buy $\(product.buyPrice)")
                                                .foregroundColor(.gray)

                                            Text("Save $\(product.buyPrice - product.rentPrice)")
                                                .foregroundColor(.green)
                                                .bold()
                                        }
                                    }

                                    Text("🌿 Save \(product.carbonSaved)kg carbon")
                                        .foregroundColor(.green)

                                    Text("Renting helps reduce fashion waste and unnecessary purchasing.")
                                        .foregroundColor(.gray)

                                    Text("Tap to view product details")
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(30)
                        }
                    }
                }
                .padding()
                .padding(.bottom, 100)
            }
            .background(
                Color(
                    red: 248/255,
                    green: 245/255,
                    blue: 240/255
                )
            )
        }
    }
}

// =======================================
// PRODUCT DETAIL VIEW
// =======================================

struct ProductDetailView: View {

    let product: Product

    @Binding var totalSaved: Int

    @State private var showConfirmation = false

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {

                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 360)
                    .overlay(

                        Image(systemName: "photo")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                    )

                VStack(alignment: .leading, spacing: 18) {

                    Text(product.name)
                        .font(.largeTitle)
                        .bold()

                    Text(product.category)
                        .foregroundColor(.gray)

                    HStack {

                        VStack(alignment: .leading, spacing: 8) {

                            Text("$\(product.rentPrice)")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.blue)

                            Text("DAILY RENT")
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 8) {

                            Text("Buy $\(product.buyPrice)")
                                .foregroundColor(.gray)

                            Text("Save $\(product.buyPrice - product.rentPrice)")
                                .foregroundColor(.green)
                                .bold()
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {

                        Text("Sustainability Impact")
                            .font(.headline)

                        HStack {

                            Image(systemName: "leaf.fill")
                                .foregroundColor(.green)

                            Text("\(product.carbonSaved)kg carbon emission reduced")
                        }

                        HStack {

                            Image(systemName: "dollarsign.circle.fill")
                                .foregroundColor(.green)

                            Text("Save $\(product.buyPrice - product.rentPrice)")
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(20)

                    Text("Renting this item helps reduce overconsumption and extends the product lifecycle.")
                        .foregroundColor(.gray)

                    Button {

                        totalSaved += (product.buyPrice - product.rentPrice)

                        showConfirmation = true

                    } label: {

                        Text("Rent Now")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                }
                .padding()
            }
            .padding(.bottom, 100)
        }
        .background(
            Color(
                red: 248/255,
                green: 245/255,
                blue: 240/255
            )
        )
        .sheet(isPresented: $showConfirmation) {

            RentConfirmationView(
                product: product
            )
        }
    }
}

// =======================================
// RENT CONFIRMATION
// =======================================

struct RentConfirmationView: View {

    @Environment(\.dismiss) var dismiss

    let product: Product

    var body: some View {

        VStack(spacing: 30) {

            Spacer()

            VStack(spacing: 20) {

                Text("🎉 Rental Confirmed!")
                    .font(.largeTitle)
                    .bold()

                Text("You saved $\(product.buyPrice - product.rentPrice)")
                    .font(.title2)
                    .bold()

                Text("🌱 Your garden has grown!")
                    .foregroundColor(.green)

                Text("🌿 Reduced \(product.carbonSaved)kg carbon emission")
                    .foregroundColor(.green)

                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.green.opacity(0.1))
                    .frame(height: 180)
                    .overlay(

                        Text("🌱 🌿 🌳")
                            .font(.system(size: 60))
                    )
            }
            .padding()

            Button {

                dismiss()

            } label: {

                Text("Continue")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
            }
            .padding()

            Spacer()
        }
    }
}

// =======================================
// IPHONE FRAME
// =======================================

struct iPhoneFrame<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {

        self.content = content()
    }

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            ZStack(alignment: .top) {

                RoundedRectangle(cornerRadius: 60)
                    .fill(Color.black)
                    .frame(width: 410, height: 880)

                content
                    .frame(width: 393, height: 852)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 45)
                    )

                Capsule()
                    .fill(Color.black)
                    .frame(width: 140, height: 36)
                    .padding(.top, 12)
            }
        }
    }
}

// =======================================
// INBOX
// =======================================

struct InboxView: View {

    var body: some View {

        NavigationStack {

            VStack {

                Text("Inbox")
                    .font(.largeTitle)
                    .bold()

                Spacer()
            }
            .padding()
        }
    }
}

// =======================================
// PROFILE
// =======================================

struct ProfileView: View {

    @Binding var totalSaved: Int

    var body: some View {

        NavigationStack {

            VStack {

                Text("Profile")
                    .font(.largeTitle)
                    .bold()

                Text("Total Saved: $\(totalSaved)")
                    .font(.title2)

                Spacer()
            }
            .padding()
        }
    }
}
