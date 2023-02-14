//
//  CardView.swift
//  swipeable-restaurants
//
//  Created by Jared Cortez on 2/14/23.
//

import Foundation
import SwiftUI

struct CardView: View {
    
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: LikeDislike = .none
    
    private var restaurant: Restaurant
    private var onRemove: (_ restaurant: Restaurant) -> Void
    
    // When the user has dragged 50% the width of the screen in either direction
    private var thresholdPercentage: CGFloat = 0.5
    
    private enum LikeDislike: Int {
        case like, dislike, none
    }
    
    init(restaurant: Restaurant, onRemove: @escaping (_ restaurant: Restaurant) -> Void) {
        self.restaurant = restaurant
        self.onRemove = onRemove
    }
    
    // What percentage of our own width have we swiped
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ZStack(alignment: self.swipeStatus == .like ? .topLeading : .topTrailing) {
                    Image(self.restaurant.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.65)
                        .clipped()
                    
                    if self.swipeStatus == .like {
                        Text("LIKE")
                            .font(.headline)
                            .padding()
                            .cornerRadius(10)
                            .foregroundColor(Color.green)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 3.0)
                            )
                            .padding(24)
                            .rotationEffect(Angle.degrees(-45))
                    } else if self.swipeStatus == .dislike {
                        Text("DISLIKE")
                            .font(.headline)
                            .padding()
                            .cornerRadius(10)
                            .foregroundColor(Color.red)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 3.0)
                            )
                            .padding(.top, 45)
                            .rotationEffect(Angle.degrees(45))
                    }
                }
                    
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(self.restaurant.name)
                            .font(.title)
                            .bold()
                        Text(self.restaurant.address)
                            .font(.subheadline)
                            .bold()
                        Text(self.restaurant.info)
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.gray)
                    }
                    // Add a radius to push HStack to the left, spacer fills the empty space
                    Spacer()
                        
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
            }
            // Add padding, corner radius, and shadow with blue radius
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
//            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.translation = value.translation
                    }.onEnded { value in
                        // Determine snap distance > 0.5 aka half the width of the screen
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                            self.onRemove(self.restaurant)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(restaurant: Restaurant(id: 1, imageName: "masiso", name: "Masiso Cupbap", address: "4809 34th St, Lubbock, TX 79410", info: "To-go style Korean BBQ."),
                 onRemove: { _ in
            // Do nothing
        })
        .frame(height: 400)
        .padding()
    }
}
