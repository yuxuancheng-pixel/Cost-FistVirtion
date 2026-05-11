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
                .padding(.top, 55)
                .padding(.bottom, 120)
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
            .padding(.bottom, 120)
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

            Color(
                red: 248/255,
                green: 245/255,
                blue: 240/255
            )
            .ignoresSafeArea()

            ZStack(alignment: .top) {

                RoundedRectangle(cornerRadius: 60)
                    .fill(Color.black)
                    .frame(width: 410, height: 880)

                content
                    .frame(width: 393, height: 852)
                    .background(
                        Color(
                            red: 248/255,
                            green: 245/255,
                            blue: 240/255
                        )
                    )
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
                    .padding(.top, 95)

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
                    .padding(.top, 75)

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
                .padding(.bottom, 120)
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

        VStack(spacing: 28) {

            HStack {

                Button {

                    dismiss()

                } label: {

                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }

                Spacer()

                Text("Carbon + Cost Saving")
                    .font(.headline)
                    .bold()

                Spacer()
            }
            .padding(.top, 70)

            Spacer()

            ZStack {

                Circle()
                    .stroke(
                        Color.green.opacity(0.2),
                        lineWidth: 20
                    )
                    .frame(width: 240)

                Circle()
                    .trim(from: 0, to: 0.78)
                    .stroke(
                        LinearGradient(
                            colors: [.green, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(
                            lineWidth: 20,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: 240)

                VStack(spacing: 14) {

                    Text("5137.6kg")
                        .font(.largeTitle)
                        .bold()

                    Text("Carbon Offset")
                        .foregroundColor(.gray)

                    Divider()

                    Text("$\(totalSaved)")
                        .font(.title)
                        .bold()

                    Text("Money Saved")
                        .foregroundColor(.gray)
                }
            }

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
}

// =======================================
// SAVING GARDEN VIEW
// =======================================

struct SavingGardenView: View {

    let totalSaved: Int

    @Environment(\.dismiss) var dismiss

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack(alignment: .leading, spacing: 24) {

                HStack {

                    Button {

                        dismiss()

                    } label: {

                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }

                    Spacer()

                    Text("Your Savings Garden")
                        .font(.headline)
                        .bold()

                    Spacer()
                }
                .padding(.top, 70)

                VStack(spacing: 18) {

                    Text("🎉 Rental Confirmed!")
                        .font(.title2)
                        .bold()

                    Text("You saved $65")
                        .font(.title3)
                        .bold()

                    Text("🌱 Your garden has grown!")
                        .foregroundColor(.green)

                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.green.opacity(0.08))
                        .frame(height: 180)
                        .overlay(

                            VStack(spacing: 12) {

                                Text("🌱 🌿 🌳")
                                    .font(.system(size: 65))

                                Text("Your garden is evolving")
                                    .foregroundColor(.green)
                                    .bold()
                            }
                        )
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(32)

                VStack(alignment: .leading, spacing: 14) {

                    Text("Level: Growing 🌿")
                        .font(.title3)
                        .bold()

                    Text("Total Saved: $\(totalSaved)")
                        .font(.title2)
                        .bold()

                    Text("Every rental grows your sustainable garden and reduces waste.")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(28)
            }
            .padding()
            .padding(.bottom, 120)
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
