//
//  Cost_SavingGarden__IOSappApp.swift
//  Cost-SavingGarden- IOSapp
//
//  Created by Yuxuan Cheng on 12/5/2026.
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

                    Image(systemName: "safari.fill")
                    Text("Explore")
                }

            InboxView()
                .tabItem {

                    Image(systemName: "bubble.left.and.bubble.right.fill")
                    Text("Inbox")
                }

            ProfileView(totalSaved: $totalSaved)
                .tabItem {

                    Image(systemName: "person.crop.circle.fill")
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
        .safeAreaInset(edge: .bottom) {

            Color.clear
                .frame(height: 8)
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

                    // SAVING CARD

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
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(30)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .padding(.top, 20)
                .padding(.bottom, 90)
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

                VStack(alignment: .leading, spacing: 18) {

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

                    Button {

                        totalSaved += (product.buyPrice - product.rentPrice)
                        showConfirmation = true

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
            .padding(.bottom, 90)
        }
        .background(
            Color(
                red: 248/255,
                green: 245/255,
                blue: 240/255
            )
        )
        .navigationTitle(product.name)
        .sheet(isPresented: $showConfirmation) {

            RentConfirmationView(product: product)
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

        VStack(spacing: 28) {

            Spacer()

            Text("🎉 Rental Confirmed!")
                .font(.largeTitle)
                .bold()

            Text("You saved $\(product.buyPrice - product.rentPrice)")
                .font(.title2)

            Text("🌱 Your garden has grown!")
                .foregroundColor(.green)

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
        .background(Color.white)
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

            // Background

            Color.black
                .ignoresSafeArea()

            ZStack {

                // iPhone 17 Pro Body

                RoundedRectangle(cornerRadius: 72)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.16, green: 0.16, blue: 0.18),
                                Color.black
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 440, height: 930)
                    .shadow(
                        color: .black.opacity(0.45),
                        radius: 40,
                        y: 20
                    )

                // Screen

                content
                    .frame(width: 408, height: 884)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 58)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 58)
                            .stroke(
                                Color.white.opacity(0.06),
                                lineWidth: 1
                            )
                    )

                // Dynamic Island

                VStack {

                    Capsule()
                        .fill(Color.black)
                        .frame(width: 130, height: 36)
                        .padding(.top, 16)

                    Spacer()
                }
            }
        }
    }
}

// =======================================
// INBOX
// =======================================

struct InboxView: View {

    let chats = [

        (
            name: "alex_curates",
            item: "Retro Camera",
            preview: "Hi! Can I rent this camera for Friday?"
        ),

        (
            name: "sarah_style",
            item: "Prada Re-Nylon Jacket",
            preview: "Is pickup available near CBD?"
        ),

        (
            name: "vogue_vintage",
            item: "Party Speaker",
            preview: "Could I extend the rental by 1 day?"
        )
    ]

    var body: some View {

        NavigationStack {

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading, spacing: 22) {

                    // HEADER

                    HStack {

                        Text("Inbox")
                            .font(.largeTitle)
                            .bold()

                        Spacer()

                        Image(systemName: "paperplane")
                            .font(.title2)
                    }
                    .padding(.top, 30)

                    // CHAT LIST

                    ForEach(chats, id: \.name) { chat in

                        NavigationLink {

                            ChatDetailView(
                                name: chat.name,
                                item: chat.item
                            )

                        } label: {

                            HStack(spacing: 16) {

                                Circle()
                                    .fill(Color.blue.opacity(0.12))
                                    .frame(width: 68, height: 68)
                                    .overlay(

                                        Image(systemName: "person.fill")
                                            .foregroundColor(.blue)
                                            .font(.title3)
                                    )

                                VStack(
                                    alignment: .leading,
                                    spacing: 7
                                ) {

                                    HStack {

                                        Text(chat.name)
                                            .bold()
                                            .foregroundColor(.black)

                                        Spacer()

                                        Text("2m")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }

                                    Text(chat.item)
                                        .font(.caption)
                                        .foregroundColor(.blue)

                                    Text(chat.preview)
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(26)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
                .padding(.bottom, 90)
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
// CHAT DETAIL
// =======================================

struct ChatDetailView: View {

    let name: String
    let item: String

    @State private var message = ""

    var body: some View {

        VStack(spacing: 0) {

            Spacer()
                .frame(height: 65)

            // PRODUCT HEADER

            HStack(spacing: 16) {

                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 85, height: 85)
                    .overlay(

                        Image(systemName: "shippingbox.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    )

                VStack(alignment: .leading, spacing: 8) {

                    Text(item)
                        .font(.headline)
                        .bold()

                    Text("$15/day rental")
                        .foregroundColor(.blue)

                    Text("Owner: \(name)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()
            }
            .padding()
            .background(Color.white)

            Divider()

            // CHAT AREA

            ScrollView(showsIndicators: false) {

                VStack(spacing: 18) {

                    messageBubble(
                        text: "Hi! Is this item still available for this weekend?",
                        isUser: true
                    )

                    messageBubble(
                        text: "Yes 😊 It's available Friday to Sunday.",
                        isUser: false
                    )

                    messageBubble(
                        text: "Perfect! Could I pick it up Friday afternoon?",
                        isUser: true
                    )

                    messageBubble(
                        text: "Sure! Pickup near Central Station works for me.",
                        isUser: false
                    )

                    messageBubble(
                        text: "Amazing. Is the charger included as well?",
                        isUser: true
                    )

                    messageBubble(
                        text: "Yep! Charger and protective bag are included.",
                        isUser: false
                    )

                    messageBubble(
                        text: "Great thank you 🙌 I'll confirm the booking tonight.",
                        isUser: true
                    )
                }
                .padding()
                .padding(.top, 18)
            }

            // MESSAGE INPUT

            HStack(spacing: 14) {

                TextField(
                    "Message...",
                    text: $message
                )
                .padding()
                .background(Color.white)
                .cornerRadius(20)

                Circle()
                    .fill(Color.blue)
                    .frame(width: 56, height: 56)
                    .overlay(

                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                    )
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
        .background(
            Color(
                red: 248/255,
                green: 245/255,
                blue: 240/255
            )
        )
        .navigationTitle(name)
    }

    // MESSAGE BUBBLE

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
                .foregroundColor(
                    isUser ?
                    .white :
                    .black
                )
                .background(
                    isUser ?
                    Color.blue :
                    Color.white
                )
                .cornerRadius(22)
                .frame(
                    maxWidth: 270,
                    alignment: isUser ?
                    .trailing :
                    .leading
                )

            if !isUser {

                Spacer()
            }
        }
    }
}


// =======================================
// PROFILE
// =======================================

struct ProfileView: View {

    @Binding var totalSaved: Int

    @State private var showGarden = false
    @State private var showImpact = false

    let days = Array(1...30)

    let columns = Array(
        repeating: GridItem(.flexible()),
        count: 7
    )

    var body: some View {

        NavigationStack {

            ScrollView(showsIndicators: false) {

                VStack(alignment: .leading, spacing: 28) {

                    // HEADER

                    HStack {

                        Text("Profile")
                            .font(.largeTitle)
                            .bold()

                        Spacer()

                        Image(systemName: "gearshape")
                    }
                    .padding(.top, 28)

                    // PROFILE CARD

                    VStack(alignment: .leading, spacing: 22) {

                        HStack(alignment: .top, spacing: 18) {

                            // PROFILE IMAGE + RING

                            ZStack {

                                Circle()
                                    .stroke(
                                        LinearGradient(
                                            colors: [.green, .blue],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 8
                                    )
                                    .frame(width: 120, height: 120)

                                Circle()
                                    .fill(Color.gray.opacity(0.25))
                                    .frame(width: 96, height: 96)

                                Text("👩")
                                    .font(.system(size: 46))
                            }
                            .onTapGesture {

                                showImpact = true
                            }

                            // SIDE BUTTONS

                            VStack(spacing: 14) {

                                Button {

                                    showImpact = true

                                } label: {

                                    HStack {

                                        Image(systemName: "leaf.fill")

                                        Text("Carbon + Cost Saving Ring")
                                            .font(.caption)
                                            .bold()
                                    }
                                    .foregroundColor(.green)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 12)
                                    .background(
                                        Color.green.opacity(0.15)
                                    )
                                    .cornerRadius(18)
                                }

                                Button {

                                    showGarden = true

                                } label: {

                                    HStack {

                                        Text("🌱")

                                        Text("Saving Garden")
                                            .font(.caption)
                                            .bold()
                                    }
                                    .foregroundColor(.green)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 14)
                                    .background(
                                        Color.green.opacity(0.15)
                                    )
                                    .cornerRadius(20)
                                }
                            }
                        }

                        // USER INFO

                        Text("green.renter")
                            .font(.largeTitle)
                            .bold()

                        Text("Sustainable Rental Explorer")
                            .foregroundColor(.gray)

                        // STATS

                        HStack(spacing: 34) {

                            statView(
                                number: "4.9",
                                title: "RATING"
                            )

                            statView(
                                number: "28",
                                title: "LISTINGS"
                            )

                            statView(
                                number: "1.2k",
                                title: "FOLLOWERS"
                            )
                        }

                        // BIO

                        Text("Reducing waste through smarter renting and sustainable living.")
                            .foregroundColor(.gray)

                        // BUTTONS

                        HStack {

                            profileButton(
                                title: "List Item",
                                color: .blue
                            )

                            profileButton(
                                title: "Edit Profile",
                                color: Color.gray.opacity(0.15)
                            )
                        }
                    }

                    // RENTAL CALENDAR

                    VStack(alignment: .leading, spacing: 18) {

                        Text("Rental Calendar")
                            .font(.title2)
                            .bold()

                        LazyVGrid(columns: columns) {

                            ForEach(days, id: \.self) { day in

                                ZStack {

                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(
                                            rentalDay(day) ?
                                            Color.blue :
                                            returnDay(day) ?
                                            Color.green :
                                            Color.white
                                        )
                                        .frame(height: 44)

                                    Text("\(day)")
                                        .foregroundColor(
                                            rentalDay(day) || returnDay(day) ?
                                            .white :
                                            .black
                                        )
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 8) {

                            HStack {

                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 10)

                                Text("Rental Period")
                            }

                            HStack {

                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 10)

                                Text("Return Day")
                            }
                        }
                        .font(.caption)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30)
                }
                .padding()
                .padding(.bottom, 90)
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

    // CALENDAR DAYS

    func rentalDay(_ day: Int) -> Bool {

        day >= 10 && day <= 14
    }

    func returnDay(_ day: Int) -> Bool {

        day == 15
    }

    // STATS

    func statView(
        number: String,
        title: String
    ) -> some View {

        VStack {

            Text(number)
                .font(.title3)
                .bold()

            Text(title)
                .font(.caption2)
                .foregroundColor(.gray)
        }
    }

    // BUTTONS

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
            .cornerRadius(18)
    }
}

// =======================================
// IMPACT VIEW
// =======================================

struct SustainabilityImpactView: View {

    let totalSaved: Int

    @Environment(\.dismiss) var dismiss

    var body: some View {

        VStack(spacing: 30) {

            // HEADER

            HStack {

                Button {

                    dismiss()

                } label: {

                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.title3)
                }

                Spacer()

                Text("Carbon + Cost Saving")
                    .font(.headline)
                    .bold()

                Spacer()
            }
            .padding(.top, 70)

            Spacer()

            // MAIN IMPACT RING

            ZStack {

                // OUTER GLOW

                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.green.opacity(0.25),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 40,
                            endRadius: 140
                        )
                    )
                    .frame(width: 300, height: 300)

                // BACKGROUND RING

                Circle()
                    .stroke(
                        Color.green.opacity(0.12),
                        lineWidth: 24
                    )
                    .frame(width: 250)

                // MAIN RING

                Circle()
                    .trim(from: 0, to: 0.82)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(
                                colors: [
                                    .green,
                                    .mint,
                                    .blue,
                                    .green
                                ]
                            ),
                            center: .center
                        ),
                        style: StrokeStyle(
                            lineWidth: 24,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: 250)

                // INNER WHITE CIRCLE

                Circle()
                    .fill(Color.white)
                    .frame(width: 185)

                // CENTER CONTENT

                VStack(spacing: 14) {

                    Text("5137")
                        .font(.system(size: 42))
                        .bold()

                    Text("kg CO₂ Saved")
                        .foregroundColor(.gray)

                    Divider()
                        .frame(width: 120)

                    Text("$\(totalSaved)")
                        .font(.title)
                        .bold()

                    Text("Money Saved")
                        .foregroundColor(.gray)

                    HStack(spacing: 6) {

                        Image(systemName: "leaf.fill")

                        Text("Eco Level 8")
                            .bold()
                    }
                    .foregroundColor(.green)
                }
            }

            // IMPACT CARDS

            HStack(spacing: 18) {

                impactCard(
                    icon: "leaf.fill",
                    title: "Carbon Reduced",
                    value: "5.1T"
                )

                impactCard(
                    icon: "dollarsign.circle.fill",
                    title: "Money Saved",
                    value: "$\(totalSaved)"
                )
            }

            // ACHIEVEMENT CARD

            VStack(alignment: .leading, spacing: 14) {

                Text("Achievements")
                    .font(.headline)
                    .bold()

                achievementRow(
                    emoji: "🌱",
                    title: "Eco Beginner"
                )

                achievementRow(
                    emoji: "🌿",
                    title: "100kg Carbon Reduced"
                )

                achievementRow(
                    emoji: "🌳",
                    title: "Top Sustainable Renter"
                )
            }
            .padding()
            .background(Color.white)
            .cornerRadius(28)

            Spacer()
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

    // =======================================
    // IMPACT CARD
    // =======================================

    func impactCard(
        icon: String,
        title: String,
        value: String
    ) -> some View {

        VStack(spacing: 12) {

            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.green)

            Text(value)
                .font(.title3)
                .bold()

            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(24)
    }

    // =======================================
    // ACHIEVEMENT ROW
    // =======================================

    func achievementRow(
        emoji: String,
        title: String
    ) -> some View {

        HStack(spacing: 16) {

            Circle()
                .fill(Color.green.opacity(0.12))
                .frame(width: 50, height: 50)
                .overlay(

                    Text(emoji)
                        .font(.title3)
                )

            Text(title)
                .bold()

            Spacer()
        }
    }
}

// =======================================
// saving-graden
// =======================================

struct SavingGardenView: View {

    let totalSaved: Int

    @Environment(\.dismiss) var dismiss

    // GARDEN LEVEL

    var gardenLevel: String {

        if totalSaved < 100 {

            return "Seed 🌱"

        } else if totalSaved < 300 {

            return "Sprout 🌿"

        } else if totalSaved < 700 {

            return "Growing 🌳"

        } else {

            return "Forest 🍃"
        }
    }

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(alignment: .leading, spacing: 26) {

                // HEADER

                HStack {

                    Button {

                        dismiss()

                    } label: {

                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.title3)
                    }

                    Spacer()

                    Text("Your Savings Garden")
                        .font(.headline)
                        .bold()

                    Spacer()
                }
                .padding(.top, 70)

                // MAIN GARDEN CARD

                VStack(spacing: 20) {

                    Text("🌱 Sustainable Growth")
                        .font(.title2)
                        .bold()

                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.green.opacity(0.12),
                                    Color.mint.opacity(0.08)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 240)
                        .overlay(

                            VStack(spacing: 16) {

                                Text("🌱 🌷 🌿 🌳 🍃")
                                    .font(.system(size: 58))

                                Text(gardenLevel)
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.green)

                                Text("Your sustainable lifestyle is evolving")
                                    .foregroundColor(.gray)
                            }
                        )

                    Text("Every rental helps your garden grow and reduces unnecessary waste.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(32)

                // ECO LEVEL

                VStack(alignment: .leading, spacing: 16) {

                    HStack {

                        Text("Eco Progress")
                            .font(.headline)

                        Spacer()

                        Text("82%")
                            .bold()
                            .foregroundColor(.green)
                    }

                    GeometryReader { geo in

                        ZStack(alignment: .leading) {

                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.gray.opacity(0.12))
                                .frame(height: 14)

                            RoundedRectangle(cornerRadius: 14)
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            .green,
                                            .mint
                                        ],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(
                                    width: geo.size.width * 0.82,
                                    height: 14
                                )
                        }
                    }
                    .frame(height: 14)

                    Divider()

                    Text("Garden Level: \(gardenLevel)")
                        .font(.title3)
                        .bold()

                    Text("Total Saved: $\(totalSaved)")
                        .font(.title2)
                        .bold()

                    Text("You are currently ranked in the top eco renters this month.")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(30)

                // PLANT COLLECTION

                VStack(alignment: .leading, spacing: 18) {

                    Text("Your Plant Collection")
                        .font(.headline)
                        .bold()

                    plantCard(
                        emoji: "🌷",
                        amount: "$25",
                        item: "Prada Jacket Rental",
                        time: "3 days ago"
                    )

                    plantCard(
                        emoji: "🌵",
                        amount: "$18",
                        item: "Retro Camera Rental",
                        time: "1 week ago"
                    )

                    plantCard(
                        emoji: "🌳",
                        amount: "$22",
                        item: "Party Speaker Rental",
                        time: "2 weeks ago"
                    )

                    plantCard(
                        emoji: "🍀",
                        amount: "$15",
                        item: "Wedding Decor Rental",
                        time: "3 weeks ago"
                    )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(30)

                // SUSTAINABILITY JOURNEY

                VStack(alignment: .leading, spacing: 18) {

                    Text("Your Sustainability Journey")
                        .font(.headline)
                        .bold()

                    journeyRow(
                        emoji: "🌱",
                        title: "First rental completed",
                        date: "March 2026"
                    )

                    journeyRow(
                        emoji: "🌿",
                        title: "Saved first $100",
                        date: "April 2026"
                    )

                    journeyRow(
                        emoji: "🌳",
                        title: "Reduced 100kg carbon",
                        date: "May 2026"
                    )

                    journeyRow(
                        emoji: "🍃",
                        title: "Reached Eco Level 8",
                        date: "May 2026"
                    )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(30)

                // MEMO

                VStack(alignment: .leading, spacing: 12) {

                    Text("🌱 Your Memo")
                        .font(.headline)

                    Text("Keep renting, keep growing!")
                        .bold()

                    Text("Small sustainable choices create long-term environmental impact.")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.green.opacity(0.08))
                .cornerRadius(24)
            }
            .padding()
            .padding(.bottom, 90)
        }
        .background(
            Color(
                red: 248/255,
                green: 245/255,
                blue: 240/255
            )
        )
    }

    // =======================================
    // PLANT CARD
    // =======================================

    func plantCard(
        emoji: String,
        amount: String,
        item: String,
        time: String
    ) -> some View {

        HStack(spacing: 16) {

            RoundedRectangle(cornerRadius: 18)
                .fill(Color.green.opacity(0.1))
                .frame(width: 75, height: 75)
                .overlay(

                    Text(emoji)
                        .font(.title)
                )

            VStack(alignment: .leading, spacing: 6) {

                Text("Saved \(amount)")
                    .bold()

                Text("From: \(item)")
                    .foregroundColor(.gray)

                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }

    // =======================================
    // JOURNEY ROW
    // =======================================

    func journeyRow(
        emoji: String,
        title: String,
        date: String
    ) -> some View {

        HStack(spacing: 16) {

            Circle()
                .fill(Color.green.opacity(0.12))
                .frame(width: 54, height: 54)
                .overlay(

                    Text(emoji)
                        .font(.title3)
                )

            VStack(alignment: .leading, spacing: 4) {

                Text(title)
                    .bold()

                Text(date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
    }
}
