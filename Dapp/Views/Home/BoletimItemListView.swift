//
//  SwiftUIView.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 08/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import SwiftUI
 
struct BoletimItemListView: View {
 
    var title = "Boletim de urna # "
    var image = "Illustration1"
    var color = Color("background3")
    var shadowColor = Color("backgroundShadow3")
 
   var body: some View {
      return VStack(alignment: .leading) {
        Text(title)
           .font(.title)
           .fontWeight(.bold)
           .foregroundColor(.white)
           .padding(30)
           .lineLimit(4)
         Image(systemName: "plus")
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
            .foregroundColor(Color.gray)
      }
      .cornerRadius(30)
      .frame(minWidth: 300, idealWidth: 300, maxWidth: 300, minHeight: 200, idealHeight: 200, maxHeight: 200, alignment: Alignment.leading)
      .padding(.trailing, -20)
      .background(color)
      .cornerRadius(30)
      .shadow(color: shadowColor, radius: 20, x: 0, y: 30)
   }
}

#if DEBUG
struct BoletimItemListView_Previews: PreviewProvider {
   static var previews: some View {
    BoletimItemListView(title: "Build an app with SwiftUI",
            image: "Illustration1",
            color: Color("background3"),
            shadowColor: Color("backgroundShadow3"))
   }
}
#endif
