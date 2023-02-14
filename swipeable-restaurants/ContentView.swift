//
//  ContentView.swift
//  swipeable-restaurants
//
//  Created by Jared Cortez on 2/14/23.
//

import SwiftUI

struct Restaurant: CustomStringConvertible, Hashable {
    var id: Int
    
    let imageName: String
    let name: String
    let address: String
    let info: String
    
    var description: String {
        return "\(name), id: \(id)"
    }
}

struct ContentView: View {
    
    // List of restaurants
    @State var restaurants: [Restaurant] = [
        Restaurant(id: 0, imageName: "masiso", name: "Masiso Cupbap", address: "4809 34th St, Lubbock, TX 79410", info: "To-go style Korean BBQ."),
        Restaurant(id: 1, imageName: "kokio", name: "Kokio Chicken", address: "3211 50th St A, Lubbock, TX 79413", info: "Korean restaurant"),
        Restaurant(id: 2, imageName: "jazz", name: "Jazz A Louisiana Kitchen", address: "3703 19th St, Lubbock, TX 79410", info: "Relaxed Cajun-Creole chain serving classic fare, including po' boys, gumbo & blackened catfish."),
        Restaurant(id: 3, imageName: "canes", name: "Raising Cane's Chicken Fingers", address: "5702 4th St, Lubbock, TX 79416", info: "Fast-food chain specializing in fried chicken fingers, crinkle-cut fries & Texas toast."),
        Restaurant(id: 4, imageName: "cfa", name: "Chick-fil-A", address: "5705 4th St, Lubbock, TX 79416", info: "Fast-food chain serving chicken sandwiches & nuggets along with salads & sides."),
        Restaurant(id: 5, imageName: "subway", name: "Subway", address: "4412 50th St B, Lubbock, TX 79414", info: "Casual counter-serve chain for build-your-own sandwiches & salads, with health-conscious options."),
        Restaurant(id: 6, imageName: "jimmyjohns", name: "Jimmy John's", address: "4730 Slide Rd, Lubbock, TX 79414", info: "Counter-serve chain specializing in sub & club sandwiches, plus signature potato chips."),
        Restaurant(id: 7, imageName: "fiveguys", name: "Five Guys", address: "4410 19th St Suite 100, Lubbock, TX 79407", info: "Fast-food chain with made-to-order burgers, fries & hot dogs, plus free peanuts while you wait."),
        Restaurant(id: 8, imageName: "wingstop", name: "Wingstop", address: "5510 4th St Suite 220, Lubbock, TX 79416", info: "Casual counter-serve chain serving a variety of chicken wings & sides."),
        Restaurant(id: 9, imageName: "whataburger", name: "Whataburger", address: "5512 4th St, Lubbock, TX 79416", info: "Circa-1950 fast-food chain for counter-serve burgers, some stacked with multiple patties."),
        Restaurant(id: 10, imageName: "mcdonalds", name: "McDonald's", address: "5201 4th St, Lubbock, TX 79416", info: "Classic, long-running fast-food chain known for its burger & fries."),
        Restaurant(id: 11, imageName: "mcalister", name: "McAlister's Deli", address: "4210 82nd St Suite 212, Lubbock, TX 79423", info: "Easygoing counter-service chain known for its sandwiches, stuffed baked potatoes & sweet tea."),
        Restaurant(id: 12, imageName: "madeleine", name: "la Madeleine", address: "8201 Quaker Ave #118, Lubbock, TX 79424", info: "Quaint French cafe chain serving rustic country fare, espresso & fresh-baked baguettes."),
        Restaurant(id: 13, imageName: "burgerking", name: "Burger King", address: "5212 4th St, Lubbock, TX 79416", info: "Well-known fast-food chain serving grilled burgers, fries & shakes."),
        Restaurant(id: 14, imageName: "teapioca", name: "Teapioca Lounge", address: "6620 Milwaukee Ave Suite 200, Lubbock, TX 79424", info: "Modern hangout with a wide range of cream teas, coffee & smoothies, plus desserts & board games."),
        Restaurant(id: 15, imageName: "rosas", name: "Rosa's Café & Tortilla Factory", address: "4407 4th St, Lubbock, TX 79416", info: "Fast-food chain featuring classic Mexican dishes & housemade tortillas in festive surroundings."),
        Restaurant(id: 16, imageName: "bangkok", name: "Bangkok Thai Restaurant", address: "4624 34th St, Lubbock, TX 79410", info: "Low-key Thai joint in snug, homey confines serving familiar eats such as noodle soups & curries."),
        Restaurant(id: 17, imageName: "braums", name: "Braum's Ice Cream & Dairy Store", address: "905 University Ave, Lubbock, TX 79401", info: "Longtime Oklahoma-based chain offering fast-food burgers, ice cream & a full range of groceries."),
        Restaurant(id: 18, imageName: "autlan", name: "Taquería Autlán", address: "2722 50th St, Lubbock, TX 79413", info: "Spacious, family-friendly place offering an extensive menu of classic Mexican eats, plus a full bar."),
        Restaurant(id: 19, imageName: "sonic", name: "Sonic Drive-In", address: "4401 4th St, Lubbock, TX 79416", info: "Fast-food burger & fries joint with an old-school feel, including retro drive-in service."),
        Restaurant(id: 20, imageName: "weiner", name: "Weenie World", address: "5510 4th St Suite 300, Lubbock, TX 79416", info: "Fast-food chain featuring a variety of hot dogs, plus chili burgers & sandwiches."),
        Restaurant(id: 21, imageName: "chipotle", name: "Chipotle Mexican Grill", address: "2411 Glenna Goodacre Blvd, Lubbock, TX 79401", info: "Fast-food chain offering Mexican fare, including design-your-own burritos, tacos & bowls."),
        Restaurant(id: 22, imageName: "dions", name: "Dion's", address: "6410 82nd St, Lubbock, TX 79424", info: "Casual Southwestern counter-serve chain, offering specialty pies, subs & salads, plus soft drinks."),
        Restaurant(id: 23, imageName: "jalisco", name: "Taqueria Jalisco", address: "2211 Avenue Q, Lubbock, TX 79411", info: "Tacos, enchiladas & other Mexican staples dished alongside margaritas in a modest space."),
        Restaurant(id: 24, imageName: "hotjuicy", name: "Hot & Juicy Seafood & Bar", address: "5004 Frankford Ave Suite 100, Lubbock, TX 79424", info: "Cajun boiling seafood bar food.")
    ]
    
    // Return the CardViews width for the given offset in the array
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(restaurants.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    // Return the CardViews frame offset for the given offset in the array
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return CGFloat(restaurants.count - 1 - id) * 10
    }
    
    // Compute what the max ID in the given restaurants array is.
    private var maxID: Int {
        return self.restaurants.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                LinearGradient(gradient: Gradient(colors: [Color.init(#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)), Color.init(#colorLiteral(red: 1, green: 0.9882352941, blue: 0.862745098, alpha: 1))]), startPoint: .bottom, endPoint: .top)
                                    .frame(width: geometry.size.width * 1.5, height: geometry.size.height)
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                    .offset(x: -geometry.size.width / 4, y: -geometry.size.height / 2)
                VStack(spacing: 24) {
                    DateView()
                    ZStack {
                        ForEach(self.restaurants, id: \.self) { restaurant in
                            Group {
                                // Range Operator
                                if (self.maxID - 3)...self.maxID ~= restaurant.id {
                                    CardView(restaurant: restaurant, onRemove: { removedRestaurant in
                                        // Remove that restaurant from array
                                        self.restaurants.removeAll { $0.id == removedRestaurant.id }
                                    })
//                                    .animation(.spring())
                                    .frame(width: self.getCardWidth(geometry, id: restaurant.id), height: 475)
                                    .offset(x: 0, y: self.getCardOffset(geometry, id: restaurant.id))
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }.padding()
    }
}

struct DateView: View {
    
    @State var dateString = ""
    @State var timeString = ""
    

    var body: some View {
        // Container to add background and corner radius
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(dateString)")
                        .font(.title)
                        .bold()
                    Text("\(timeString)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .onAppear {
                    dateString = Date.now.formatted(.dateTime.weekday(.wide).month(.wide).day())
                    timeString = Date.now.formatted(.dateTime.hour().minute())
                }
                Spacer()
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
