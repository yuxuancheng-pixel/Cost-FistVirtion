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
// MODELS
// =======================================

struct Product: Identifiable {

    let id = UUID()

    let name: String
    let category: String
    let rentPrice: Int
    let buyPrice: Int
    let carbonSaved: Int
}

struct ChatUser: Identifiable {

    let id = UUID()

    let name: String
    let message: String
    let time: String
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

let chats = [

    ChatUser(
        name: "@alex_curates",
        message: "Hey! Is the Prada jacket available this weekend?",
        time: "1m ago"
    ),

    ChatUser(
        name: "@sarah_style",
        message: "Can I extend the rental for one more day?",
        time: "12m ago"
    ),

    ChatUser(
        name: "@camera_house",
        message: "Please return before Friday 😊",
        time: "1h ago"
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

                    HStack {

                        Text("Renturn")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.blue)

                        Spacer()

                        Image(systemName: "bag")
                            .font(.title2)
                    }

                    // SEARCH

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
                    .cornerRadius(20)

                    // TAGS

                    ScrollView(.horizontal, showsIndicators: false) {

                        HStack(spacing: 12) {

                            ForEach(tags, id: \.self) { tag in

                                Text(tag)
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
// PRODUCT DETAIL
// =======================================

struct ProductDetailView: View {

    let product: Product

    @Binding var totalSaved: Int

    @State private var showPopup = false

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {

                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 350)

                VStack(alignment: .leading, spacing: 20) {

                    Text(product.name)
                        .font(.largeTitle)
                        .bold()

                    Text(product.category)
                        .foregroundColor(.gray)

                    HStack {

                        VStack(alignment: .leading) {

                            Text("$\(product.rentPrice)")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.blue)

                            Text("DAILY RENT")
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

                    VStack(alignment: .leading, spacing: 12) {

                        Text("Carbon + Cost Saving")
                            .font(.headline)

                        Text("🌱 \(product.carbonSaved)kg CO₂ reduced")

                        Text("💰 Save $\(product.buyPrice - product.rentPrice)")
                    }
                    .padding()
                    .background(Color.green.opacity(0.12))
                    .cornerRadius(20)

                    Button {

                        totalSaved += (product.buyPrice - product.rentPrice)

                        showPopup = true

                    } label: {

                        Text("Rent Now")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                }
                .padding()
            }
        }
        .background(
            Color(
                red: 248/255,
                green: 245/255,
                blue: 240/255
            )
        )
        .sheet(isPresented: $showPopup) {

            ConfirmationPopup(product: product)
        }
    }
}

// =======================================
// RENT POPUP
// =======================================

struct ConfirmationPopup: View {

    @Environment(\.dismiss) var dismiss

    let product: Product

    var body: some View {

        VStack(spacing: 30) {

            Spacer()

            Text("🎉 Rental Confirmed!")
                .font(.largeTitle)
                .bold()

            Text("You saved $\(product.buyPrice - product.rentPrice)")
                .font(.title2)

            Text("🌱 Reduced \(product.carbonSaved)kg carbon")

            RoundedRectangle(cornerRadius: 30)
                .fill(Color.green.opacity(0.1))
                .frame(height: 180)
                .overlay(

                    Text("🌱 🌿 🌳")
                        .font(.system(size: 60))
                )

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

            Spacer()
        }
        .padding()
    }
}

// =======================================
// INBOX VIEW
// =======================================

struct InboxView: View {

    var body: some View {

        NavigationStack {

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading, spacing: 24) {

                    HStack {

                        Text("Inbox")
                            .font(.largeTitle)
                            .bold()

                        Spacer()

                        Image(systemName: "paperplane")
                    }

                    Text("RECENT ACTIVITY")
                        .font(.caption)
                        .foregroundColor(.gray)

                    activityCard(
                        title: "Rental Confirmed",
                        subtitle: "You saved $65 🌱"
                    )

                    activityCard(
                        title: "Garden Grew +1",
                        subtitle: "Your garden has grown 🌿"
                    )

                    Text("MESSAGES")
                        .font(.caption)
                        .foregroundColor(.gray)

                    ForEach(chats) { chat in

                        NavigationLink {

                            ChatDetailView(chat: chat)

                        } label: {

                            HStack(spacing: 16) {

                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 62, height: 62)

                                VStack(alignment: .leading, spacing: 8) {

                                    HStack {

                                        Text(chat.name)
                                            .bold()
                                            .foregroundColor(.black)

                                        Spacer()

                                        Text(chat.time)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }

                                    Text(chat.message)
                                        .foregroundColor(.gray)
                                        .lineLimit(2)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(24)
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

    func activityCard(
        title: String,
        subtitle: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 10) {

            Text(title)
                .font(.headline)

            Text(subtitle)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(24)
    }
}

// =======================================
// CHAT DETAIL
// =======================================

struct ChatDetailView: View {

    let chat: ChatUser

    @State private var messageText = ""

    var body: some View {

        VStack {

            ScrollView {

                VStack(spacing: 18) {

                    HStack {

                        Text(chat.message)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)

                        Spacer()
                    }

                    HStack {

                        Spacer()

                        Text("Thanks! I’ll return it 😊")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
                .padding()
            }

            HStack {

                TextField(
                    "Message...",
                    text: $messageText
                )
                .padding()
                .background(Color.white)
                .cornerRadius(18)

                Button {

                } label: {

                    Circle()
                        .fill(Color.blue)
                        .frame(width: 52, height: 52)
                        .overlay(

                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.white)
                        )
                }
            }
            .padding()
        }
        .navigationTitle(chat.name)
        .background(
            Color(
                red: 248/255,
                green: 245/255,
                blue: 240/255
            )
        )
    }
}

// =======================================
// PROFILE VIEW
// =======================================

struct ProfileView: View {

    @Binding var totalSaved: Int

    @State private var showGarden = false
    @State private var showImpact = false

    let days = Array(1...28)

    let columns = Array(
        repeating: GridItem(.flexible()),
        count: 7
    )

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 24) {

                    HStack {

                        Text("Renturn")
                            .font(.title)
                            .bold()
                            .foregroundColor(.blue)

                        Spacer()

                        Image(systemName: "bag")
                    }

                    HStack(alignment: .top) {

                        Button {

                            showImpact = true

                        } label: {

                            ZStack {

                                Circle()
                                    .stroke(
                                        LinearGradient(
                                            colors: [.green, .mint],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 8
                                    )
                                    .frame(width: 120, height: 120)

                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 95, height: 95)
                            }
                        }

                        Spacer()

                        Button {

                            showGarden = true

                        } label: {

                            Circle()
                                .fill(Color.green.opacity(0.15))
                                .frame(width: 60, height: 60)
                                .overlay(

                                    Text("🌱")
                                )
                        }
                    }

                    Text("vogue_vintage")
                        .font(.title)
                        .bold()

                    Text("Vogue Vintage Boutique")
                        .foregroundColor(.gray)

                    HStack(spacing: 40) {

                        statView(
                            value: "4.9",
                            title: "RATING"
                        )

                        statView(
                            value: "28",
                            title: "LISTINGS"
                        )

                        statView(
                            value: "1.2k",
                            title: "FOLLOWERS"
                        )
                    }

                    HStack {

                        Button {

                        } label: {

                            Text("List Item")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(20)
                        }

                        Button {

                        } label: {

                            Text("Edit Profile")
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(20)
                        }
                    }

                    Text("Rental Planner")
                        .font(.title)
                        .bold()

                    VStack(alignment: .leading, spacing: 20) {

                        Text("February 2026")
                            .font(.title2)
                            .bold()

                        LazyVGrid(columns: columns) {

                            ForEach(days, id: \.self) { day in

                                if day == 24 {

                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.green)
                                        .frame(height: 40)
                                        .overlay(

                                            Text("\(day)")
                                                .foregroundColor(.white)
                                        )

                                } else if day == 27 {

                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.orange)
                                        .frame(height: 40)
                                        .overlay(

                                            Text("\(day)")
                                                .foregroundColor(.white)
                                        )

                                } else {

                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.gray.opacity(0.08))
                                        .frame(height: 40)
                                        .overlay(

                                            Text("\(day)")
                                                .foregroundColor(.gray)
                                        )
                                }
                            }
                        }

                        Text("📅 Rent Date: Feb 24")
                            .foregroundColor(.green)

                        Text("📦 Return Date: Feb 27")
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
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
            .sheet(isPresented: $showGarden) {

                SavingGardenView(totalSaved: totalSaved)
            }
            .sheet(isPresented: $showImpact) {

                SustainabilityPopup(totalSaved: totalSaved)
            }
        }
    }

    func statView(
        value: String,
        title: String
    ) -> some View {

        VStack {

            Text(value)
                .bold()

            Text(title)
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }
}

// =======================================
// SAVING GARDEN
// =======================================

struct SavingGardenView: View {

    @Environment(\.dismiss) var dismiss

    let totalSaved: Int

    var body: some View {

        VStack(spacing: 25) {

            HStack {

                Button {

                    dismiss()

                } label: {

                    Image(systemName: "chevron.left")
                }

                Spacer()

                Text("Saving Garden")
                    .font(.title)
                    .bold()

                Spacer()
            }

            RoundedRectangle(cornerRadius: 30)
                .fill(Color.green.opacity(0.1))
                .frame(height: 250)
                .overlay(

                    Text("🌱 🌿 🌳")
                        .font(.system(size: 70))
                )

            Text("Total Saved: $\(totalSaved)")
                .font(.title2)

            Text("Level: Growing 🌿")

            Spacer()
        }
        .padding()
    }
}

// =======================================
// IMPACT POPUP
// =======================================

struct SustainabilityPopup: View {

    @Environment(\.dismiss) var dismiss

    let totalSaved: Int

    var body: some View {

        VStack(spacing: 25) {

            HStack {

                Text("Carbon+Cost-Saving")
                    .font(.title2)
                    .bold()

                Spacer()

                Button {

                    dismiss()

                } label: {

                    Image(systemName: "xmark")
                }
            }

            VStack(alignment: .leading, spacing: 15) {

                Text("🌱 CO₂ Saved: 5137kg")

                Text("💰 Total Saved: $\(totalSaved)")

                ProgressView(value: 0.8)
                    .tint(.green)
            }
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(24)

            Button {

                dismiss()

            } label: {

                Text("Keep it Green")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(20)
            }

            Spacer()
        }
        .padding()
    }
}
