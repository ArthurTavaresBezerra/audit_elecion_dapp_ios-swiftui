//
//  HomeList.swift
//  DesignCode
//
//  Created by Mithun x on 7/13/19.
//  Copyright © 2019 Mithun. All rights reserved.
//

import SwiftUI

struct BoletimList: View {

    var candidates = boletinsData
    @State var showContent = false

   var body: some View {


            ScrollView(.horizontal, showsIndicators: false) {
               HStack(spacing: 30.0) {
                  ForEach(candidates) { item in
                     Button(action: { self.showContent.toggle() }) {
                        GeometryReader { geometry in
                           BoletimItemListView(
                                      title: item.title,
                                      image: item.image,
                                      color: item.color,
                                      shadowColor: item.shadowColor)
                              .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -40), axis: (x: 0, y: 10.0, z: 0))
                              .sheet(isPresented: self.$showContent) { ContentView() }
                        }
                        .frame(width: 250, height: 200)
                        Spacer()
                     
                     }
                  }
               }
               .padding(.leading, 30)
               .padding(.top, 30)
               .padding(.bottom, 70)
               Spacer()
            }

   }
}

#if DEBUG
struct BoletimList_Previews: PreviewProvider {
   static var previews: some View {
      BoletimList()
   }
}
#endif
 

struct Boletim: Identifiable {
    var id = UUID()
    var number: Int
    var title: String
    var image: String
    var color: Color
    var shadowColor: Color
}

let boletinsData = [
    Boletim(number: 1,
          title: "Build an app with SwiftUI",
          image: "Illustration1",
          color: Color("background3"),
          shadowColor: Color("backgroundShadow3")),
   Boletim(number: 2,
          title: "Design and animate your UI",
          image: "Illustration2",
          color: Color("background4"),
          shadowColor: Color("backgroundShadow4")),
   Boletim(number: 3,
          title: "Swift UI Advanced",
          image: "Illustration3",
          color: Color("background7"),
          shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
   Boletim(number: 4,
          title: "Framer Playground",
          image: "Illustration4",
          color: Color("background8"),
          shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
   Boletim(number: 5,
          title: "Flutter for Designers",
          image: "Illustration5",
          color: Color("background9"),
          shadowColor: Color(hue: 0.677, saturation: 0.701, brightness: 0.788, opacity: 0.5)),
]
