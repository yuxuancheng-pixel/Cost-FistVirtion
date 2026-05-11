//
//  Cost_FistVirtionApp.swift
//  Cost-FistVirtion
//
//  Created by Yuxuan Cheng on 4/5/2026.
//

import SwiftUI

// ======================================
// MARK: - MAIN APP
// ======================================

@main
struct Cost_FirstVirtionApp: App {
    var body: some Scene {
        WindowGroup {
            IphoneFrameView()
        }
    }
}

// ======================================
// MARK: - IPHONE FRAME
// ======================================

struct IphoneFrameView: View {

    var body: some View {

        ZStack {

            Color.black
                .ignoresSafeArea()

            RoundedRectangle(cornerRadius: 55)
                .fill(Color(red: 248/255, green: 245/255, blue: 240/255))
                .frame(width: 390, height: 844)
                .overlay(

                    ZStack(alignment: .top) {

                        ContentView()

                        // Dynamic Island
                        Capsule()
                            .fill(Color.black)
                            .frame(width: 130, height: 38)
                            .padding(.top, 12)
                    }
                )
        }
    }
}

// ======================================
// MARK: - MAIN TAB VIEW
// ======================================

struct ContentView: View {

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
        .accentColor(.blue)
    }
}

// ======================================
// MARK: - ITEM MODEL
// ======================================

struct RentalItem: Identifiable {

    let id = UUID()

    let name: String
    let category: String
    let rentPrice: Int
    let buyPrice: Int
    let image: String
    let description: String
}

let sampleItems: [RentalItem] = [

    RentalItem(
        name: "Retro Camera",
        category: "Vintage",
        rentPrice: 12,
        buyPrice: 140,
        image: "camera.fill",
        description: "Perfect vintage camera for travel photography and retro aesthetics."
    ),

    RentalItem(
        name: "Prada Re-Nylon",
        category: "Fashion",
        rentPrice: 15,
        buyPrice: 180,
        image: "bag.fill",
        description: "Luxury designer rental piece for events and social outings."
    ),

    RentalItem(
        name: "Party Speaker",
        category: "Party",
        rentPrice: 20,
        buyPrice: 260,
        image: "speaker.wave.3.fill",
        description: "Portable bluetooth speaker with deep bass and outdoor mode."
    )
]

// ======================================
// MARK: - EXPLORE VIEW
// ======================================

struct ExploreView: View {

    @Binding var totalSaved: Int

    @State private var searchText = ""
    @State private var showPopup = false

    var body: some View {

        NavigationStack {

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading, spacing: 20) {

                    // HEADER
                    HStack {

                        Text("Renturn")
                            .font(.title2)
                            .bold()

                        Spacer()

                        Image(systemName: "bag")
                            .font(.title3)
                    }
                    .padding(.top, 70)

                    // SEARCH
                    HStack {

                        Image(systemName: "magnifyingglass")

                        TextField(
                            "Search brands, styles...",
                            text: $searchText
                        )
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(18)

                    // SAVING CARD
                    VStack(alignment: .leading, spacing: 10) {

                        Text("🌱 Saving Garden")
                            .bold()

                        Text("You saved $65")
                            .font(.title2)
                            .bold()

                        Text("Rent instead of buying to grow your garden.")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green.opacity(0.15))
                    .cornerRadius(25)

                    // ITEMS
                    LazyVStack(spacing: 18) {

                        ForEach(sampleItems) { item in

                            NavigationLink {

                                ProductDetailView(
                                    item: item,
                                    totalSaved: $totalSaved
                                )

                            } label: {

                                itemCard(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding()
            }
            .background(
                Color(
                    red: 248/255,
                    green: 245/255,
                    blue: 240/255
                )
            )
            .sheet(isPresented: $showPopup) {

                RentalPopup()
            }
        }
    }

    func itemCard(item: RentalItem) -> some View {

        VStack(alignment: .leading, spacing: 14) {

            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 220)
                .overlay(

                    Image(systemName: item.image)
                        .font(.system(size: 60))
                        .foregroundColor(.gray)
                )

            Text(item.category.uppercased())
                .font(.caption)
                .foregroundColor(.gray)

            Text(item.name)
                .font(.title3)
                .bold()

            HStack(alignment: .bottom) {

                VStack(alignment: .leading) {

                    Text("$\(item.rentPrice)")
                        .font(.title)
                        .bold()
                        .foregroundColor(.blue)

                    Text("DAILY RENT")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }

                Spacer()

                VStack(alignment: .trailing) {

                    Text("Buy $\(item.buyPrice)")
                        .foregroundColor(.gray)

                    Text("Save $\(item.buyPrice - item.rentPrice)")
                        .bold()
                        .foregroundColor(.green)
                }
            }

            Button {

                showPopup = true

            } label: {

                Text("Rent Now")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(16)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(30)
    }
}

// ======================================
// MARK: - PRODUCT DETAIL
// ======================================

struct ProductDetailView: View {

    let item: RentalItem

    @Binding var totalSaved: Int

    @State private var showPopup = false

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 22) {

                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 320)
                    .overlay(

                        Image(systemName: item.image)
                            .font(.system(size: 90))
                            .foregroundColor(.gray)
                    )

                Text(item.name)
                    .font(.largeTitle)
                    .bold()

                Text(item.description)
                    .foregroundColor(.gray)

                HStack {

                    VStack(alignment: .leading) {

                        Text("Rent")
                            .foregroundColor(.gray)

                        Text("$\(item.rentPrice)/day")
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
                            .bold()
                    }
                }

                VStack(alignment: .leading, spacing: 10) {

                    Text("🌱 Carbon + Cost Saving")
                        .bold()

                    Text("You save $\(item.buyPrice - item.rentPrice)")
                        .foregroundColor(.green)

                    Text("Reduced carbon emissions by renting instead of buying.")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.green.opacity(0.12))
                .cornerRadius(20)

                Button {

                    totalSaved += item.buyPrice - item.rentPrice
                    showPopup = true

                } label: {

                    Text("Rent Now")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(18)
                }
            }
            .padding()
        }
        .background(
            Color(
                red: 248/255,
                green: 245/255,
                blue: 240/255
            )
        )
        .sheet(isPresented: $showPopup) {

            RentalPopup()
        }
    }
}

// ======================================
// MARK: - RENTAL POPUP
// ======================================

struct RentalPopup: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {

        VStack(spacing: 25) {

            Spacer()

            Text("🎉 Rental Confirmed!")
                .font(.largeTitle)
                .bold()

            Text("You saved $65")
                .font(.title2)

            Text("🌱 Your garden has grown!")
                .foregroundColor(.green)

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

// ======================================
// MARK: - INBOX VIEW
// ======================================

struct InboxView: View {

    let chats = [

        "alex_curates",
        "sarah_style",
        "vogue_vintage"
    ]

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 20) {

                    Text("Inbox")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 90)

                    ForEach(chats, id: \.self) { name in

                        NavigationLink {

                            ChatDetailView(name: name)

                        } label: {

                            HStack(spacing: 16) {

                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 65, height: 65)

                                VStack(alignment: .leading, spacing: 6) {

                                    Text(name)
                                        .bold()

                                    Text("Hey! Is the rental still available?")
                                        .foregroundColor(.gray)
                                }

                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(22)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
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

// ======================================
// MARK: - CHAT DETAIL
// ======================================

struct ChatDetailView: View {

    let name: String

    @State private var message = ""

    var body: some View {

        VStack {

            ScrollView {

                VStack(spacing: 20) {

                    messageBubble(
                        text: "Hi! Is the item available this weekend?",
                        isUser: false
                    )

                    messageBubble(
                        text: "Yes! You can rent it tomorrow.",
                        isUser: true
                    )

                    messageBubble(
                        text: "Perfect, thank you!",
                        isUser: false
                    )
                }
                .padding(.top, 40)
                .padding()
            }

            HStack {

                TextField(
                    "Message...",
                    text: $message
                )
                .padding()

                Circle()
                    .fill(Color.blue)
                    .frame(width: 52, height: 52)
                    .overlay(

                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                    )
            }
            .padding()
        }
        .navigationTitle(name)
    }

    func messageBubble(
        text: String,
        isUser: Bool
    ) -> some View {

        HStack {

            if isUser {

                Spacer()
            }

            Text(text)
                .padding()
                .background(
                    isUser ?
                    Color.blue :
                    Color.white
                )
                .foregroundColor(
                    isUser ?
                    .white :
                    .black
                )
                .cornerRadius(18)

            if !isUser {

                Spacer()
            }
        }
    }
}

// ======================================
// MARK: - PROFILE VIEW
// ======================================

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

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading, spacing: 24) {

                    // HEADER
                    HStack {

                        Text("Renturn")
                            .font(.title2)
                            .bold()

                        Spacer()

                        Image(systemName: "bag")
                    }
                    .padding(.top, 70)

                    // PROFILE
                    VStack(alignment: .leading, spacing: 18) {

                        HStack(alignment: .top) {

                            ZStack {

                                Circle()
                                    .stroke(
                                        Color.green,
                                        lineWidth: 6
                                    )
                                    .frame(width: 110)

                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 90)

                                Text("👩")
                                    .font(.system(size: 45))
                            }

                            VStack(alignment: .leading, spacing: 10) {

                                Button {

                                    showImpact = true

                                } label: {

                                    Text("Carbon + Cost Saving")
                                        .bold()
                                        .foregroundColor(.green)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(
                                            Color.green.opacity(0.15)
                                        )
                                        .cornerRadius(14)
                                }

                                Button {

                                    showGarden = true

                                } label: {

                                    HStack {

                                        Image(systemName: "leaf.fill")

                                        Text("Saving Garden")
                                            .bold()
                                    }
                                    .foregroundColor(.green)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 10)
                                    .background(
                                        Color.green.opacity(0.15)
                                    )
                                    .cornerRadius(16)
                                }
                            }
                        }

                        Text("vogue_vintage")
                            .font(.largeTitle)
                            .bold()

                        Text("Vogue Vintage Boutique")
                            .foregroundColor(.gray)

                        HStack(spacing: 30) {

                            statView(number: "4.9", title: "RATING")
                            statView(number: "28", title: "LISTINGS")
                            statView(number: "1.2k", title: "FOLLOWERS")
                        }

                        Text("Curated designer rentals for the sustainable soul.")
                            .foregroundColor(.gray)

                        HStack {

                            profileButton(
                                title: "List Item",
                                color: .blue
                            )

                            profileButton(
                                title: "Edit Profile",
                                color: .gray.opacity(0.2)
                            )
                        }
                    }

                    // CALENDAR
                    VStack(alignment: .leading, spacing: 18) {

                        Text("Rental Planner")
                            .font(.title)
                            .bold()

                        LazyVGrid(columns: columns) {

                            ForEach(days, id: \.self) { day in

                                ZStack {

                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(
                                            highlighted(day: day) ?
                                            Color.blue :
                                            Color.white
                                        )
                                        .frame(height: 42)

                                    Text("\(day)")
                                        .foregroundColor(
                                            highlighted(day: day) ?
                                            .white :
                                            .black
                                        )
                                }
                            }
                        }

                        Text("Blue = Rental Period")
                            .foregroundColor(.blue)

                        Text("Green = Return Day")
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(28)
                }
                .padding()
            }
            .background(
                Color(
                    red: 248/255,
                    green: 245/255,
                    blue: 240/255
                )
            )
            .sheet(isPresented: $showGarden) {

                SavingGardenView(
                    totalSaved: totalSaved
                )
            }
            .sheet(isPresented: $showImpact) {

                SustainabilityImpactView(
                    totalSaved: totalSaved
                )
            }
        }
    }

    func highlighted(day: Int) -> Bool {

        day >= 10 && day <= 15
    }

    func statView(
        number: String,
        title: String
    ) -> some View {

        VStack {

            Text(number)
                .font(.title2)
                .bold()

            Text(title)
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }

    func profileButton(
        title: String,
        color: Color
    ) -> some View {

        Text(title)
            .foregroundColor(
                color == .blue ?
                .white :
                .black
            )
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .cornerRadius(16)
    }
}

// ======================================
// MARK: - SAVING GARDEN
// ======================================

struct SavingGardenView: View {

    let totalSaved: Int

    @Environment(\.dismiss) var dismiss

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 22) {

                    HStack {

                        Button {

                            dismiss()

                        } label: {

                            Image(systemName: "chevron.left")
                                .font(.title2)
                        }

                        Spacer()

                        Text("Saving Garden")
                            .font(.title)
                            .bold()

                        Spacer()
                    }

                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.green.opacity(0.12))
                        .frame(height: 220)
                        .overlay(

                            VStack(spacing: 18) {

                                Text("🌱🌿🌳")
                                    .font(.system(size: 70))

                                Text("Your garden is growing!")
                                    .bold()
                            }
                        )

                    VStack(alignment: .leading, spacing: 14) {

                        Text("Level: Growing 🌿")
                            .font(.title2)

                        Text("Total Saved: $\(totalSaved)")
                            .font(.title2)
                            .bold()

                        Divider()

                        Text("Saved $25")
                            .bold()

                        Text("From: Jacket Rental")
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                }
                .padding()
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

// ======================================
// MARK: - IMPACT VIEW
// ======================================

struct SustainabilityImpactView: View {

    let totalSaved: Int

    @Environment(\.dismiss) var dismiss

    var body: some View {

        NavigationStack {

            VStack(spacing: 24) {

                HStack {

                    Button {

                        dismiss()

                    } label: {

                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }

                    Spacer()

                    Text("Carbon + Cost Saving")
                        .font(.title3)
                        .bold()

                    Spacer()
                }

                RoundedRectangle(cornerRadius: 28)
                    .fill(Color.green.opacity(0.12))
                    .frame(height: 240)
                    .overlay(

                        VStack(spacing: 18) {

                            Text("5137.6kg")
                                .font(.largeTitle)
                                .bold()

                            Text("CO2 OFFSET")

                            Divider()

                            Text("Total saved: $\(totalSaved)")
                                .font(.title2)
                                .bold()
                        }
                    )

                Spacer()

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
            }
            .padding()
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
