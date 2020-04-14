//
//  Home.swift
//  DesignCode
//
//  Created by Mithun x on 7/12/19.
//  Copyright © 2019 Mithun. All rights reserved.
//

import SwiftUI

let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
let screen = UIScreen.main.bounds

struct Home: View {

   @State var showMenuSideBar = false
   @State var showProfile = false
   @State var showAddBoletim = true

   var body: some View {
      
 
     return  ZStack(alignment: .top) {
        ScrollView {
           VStack {
            HomeTitle()
            BoletimList()
               .blur(radius: showMenuSideBar ? 20 : 0)
               .scaleEffect(showProfile ? 0.95 : 1)
               .animation(.default)
            }
            CertificateRow()
        }
        .padding(.top, 58)

         HStack {
             MenuButton(show: $showMenuSideBar)
                .offset(x: -40)
                 Spacer()

             MenuRight(show: $showProfile)
                .offset(x: -16)
         }
         .offset(y: showProfile ? statusBarHeight : 54)
         .animation(.spring())

         MenuView(show: $showMenuSideBar)
      }
//      .onAppear(perform: {
//        }).sheet(isPresented: self.$showAddBoletim , content: {
//            return AddBoletimView(qrCode: PListHelper.readProperty("qrCodeExample"))
//        })
      .background(Color("background"))
      .edgesIgnoringSafeArea(.all)
   }
}

#if DEBUG
struct Home_Previews: PreviewProvider {
   static var previews: some View {
      Home()
         .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
   }
}
#endif


struct HomeTitle: View {
    
    var totalCandidates = 12
    var totalVotes = 80
    
    var body : some View {
        return
            HStack {
               VStack(alignment: .leading) {
                  Text("Audit Election")
                     .font(.title)
                     .fontWeight(.heavy)
                HStack {
                    Text("\(totalCandidates) Candidatos")
                       .foregroundColor(.gray)
                        .padding(.trailing, 10)
                     Text("\(totalVotes) Votos")
                        .foregroundColor(.gray)
                }
           }
           Spacer()
        }
        .padding(.leading, 60.0)
    }
}

struct MenuRow: View {

   var image = "creditcard"
   var text = "My Account"

   var body: some View {
      return HStack {
         Image(systemName: image)
            .imageScale(.large)
            .foregroundColor(Color("icons"))
            .frame(width: 32, height: 32)

         Text(text)
            .font(.headline)
            .foregroundColor(.primary)

         Spacer()
      }
   }
}

struct Menu: Identifiable {
   var id = UUID()
   var title: String
   var icon: String
}

let menuData = [
   Menu(title: "My Account", icon: "person.crop.circle"),
   Menu(title: "Settings", icon: "gear"),
   Menu(title: "Billing", icon: "creditcard"),
   Menu(title: "Team", icon: "person.2"),
   Menu(title: "Sign out", icon: "arrow.uturn.down")
]

struct MenuView: View {

   var menu = menuData
   @Binding var show: Bool
   @State var showSettings = false

   var body: some View {
      return HStack {
         VStack(alignment: .leading) {
            ForEach(menu) { item in
               if item.title == "Settings" {
                  Button(action: { self.showSettings.toggle() }) {
                     MenuRow(image: item.icon, text: item.title)
                        .sheet(isPresented: self.$showSettings) { Settings() }
                  }
               } else {
                  MenuRow(image: item.icon, text: item.title)
               }
            }
            Spacer()
         }
         .padding(.top, 20)
         .padding(30)
         .frame(minWidth: 0, maxWidth: 360)
         .background(Color("button"))
         .cornerRadius(30)
         .padding(.trailing, 60)
         .shadow(radius: 20)
         .rotation3DEffect(Angle(degrees: show ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
         .animation(.default)
         .offset(x: show ? 0 : -UIScreen.main.bounds.width)
         .onTapGesture {
            self.show.toggle()
         }
         Spacer()
      }
      .padding(.top, statusBarHeight)
   }
}

struct CircleButton: View {

   var icon = "person.crop.circle"

   var body: some View {
      return HStack {
         Image(systemName: icon)
            .foregroundColor(.primary)
      }
      .frame(width: 44, height: 44)
      .background(Color("button"))
      .cornerRadius(30)
      .shadow(color: Color("buttonShadow"), radius: 20, x: 0, y: 20)
   }
}

struct MenuButton: View {
   @Binding var show: Bool

   var body: some View {
      return ZStack(alignment: .topLeading) {
         Button(action: { self.show.toggle() }) {
            HStack {
               Spacer()

               Image(systemName: "list.dash")
                  .foregroundColor(.primary)
            }
            .padding(.trailing, 18)
            .frame(width: 90, height: 60)
            .background(Color("button"))
            .cornerRadius(30)
            .shadow(color: Color("buttonShadow"), radius: 20, x: 0, y: 20)
         }
         Spacer()
      }
   }
}

struct MenuRight: View {

   @Binding var show: Bool
   @State var showUpdate = false
 
    var qrCode = "QRBU:1:7 VRQR:1.5 VRCH:20180830 ORIG:VOTA ORLC:LEG PROC:3081 DTPL:20181007 PLEI:3113 TURN:1 FASE:S UNFE:AC MUNI:1031 ZONA:3 SECA:72 IDUE:1651904 IDCA:803113519490917326566415 VERS:6.32.0.4 LOCA:1031 APTO:303 COMP:303 FALT:0 DTAB:20181007 HRAB:121226 DTFC:20181007 HRFC:185733 IDEL:3191 CARG:6 TIPO:1 VERC:201808301320 PART:10 1001:1 1002:1 1003:1 1004:1 1005:1 1006:1 1007:1 1008:1 1009:1 1010:1 1011:1 1012:1 1013:1 1014:1 1015:1 1016:1 LEGP:1 TOTP:17 PART:11 1101:1 1102:1 1103:1 1104:1 1105:1 1106:1 1107:1 1108:1 1109:1 1110:1 1111:1 1112:1 1113:2 1114:1 1115:1 1116:1 LEGP:1 TOTP:18 PART:12 1201:1 1202:1 1203:1 1204:1 1205:1 1206:1 1207:1 1208:1 1209:1 1210:1 1211:1 1212:1 1213:1 1214:1 1215:1 1216:1 LEGP:1 TOTP:17 PART:14 1401:1 LEGP:1 TOTP:2 PART:15 1502:1 1516:1 LEGP:1 TOTP:3 PART:16 1603:1 LEGP:1 TOTP:2 PART:17 1704:1 LEGP:1 TOTP:2 PART:18 HASH:D28E999FA923AD00933EFE7F7F65B2BBD9B0C2D1F726BE2C9AFF4197E611412F93631F55948A4C562D0C381A8F58DFC6CC312E7EB46FD832F28AD074AAA03C48QRBU:2:7 VRQR:1.5 VRCH:20180830 1805:1 LEGP:1 TOTP:2 PART:19 1906:1 LEGP:1 TOTP:2 PART:20 2007:1 LEGP:1 TOTP:2 PART:21 2108:1 LEGP:1 TOTP:2 PART:22 2209:1 LEGP:1 TOTP:2 PART:23 2310:1 LEGP:1 TOTP:2 PART:25 2511:1 LEGP:1 TOTP:2 PART:27 2712:1 LEGP:1 TOTP:2 PART:28 2813:1 LEGP:2 TOTP:3 PART:31 3114:1 LEGP:1 TOTP:2 PART:33 3315:1 LEGP:1 TOTP:2 PART:35 3501:1 3502:1 3503:1 3504:1 3505:1 3506:1 3507:1 3508:1 LEGP:1 TOTP:9 PART:36 3609:1 3610:1 3611:1 3612:1 3613:1 3614:1 3615:1 3616:1 LEGP:1 TOTP:9 PART:44 4401:1 4402:1 4403:1 4404:1 4405:1 4406:1 4407:1 4408:1 LEGP:1 TOTP:9 PART:45 4509:1 4510:1 4511:2 4512:1 4513:1 4514:1 4515:1 4516:1 LEGP:1 TOTP:10 PART:50 5001:1 5002:1 5003:1 5004:1 5005:1 5006:1 5007:1 5008:1 LEGP:1 TOTP:9 PART:51 5109:1 5110:1 5111:1 5112:1 5113:1 5114:1 5115:1 5116:1 LEGP:1 TOTP:9 PART:77 7701:1 7702:2 7703:1 7704:1 HASH:EC3F07758B40F058E89B9935FC6513C6E3C324B66BFE5B0B1AE00ED6CE170D2B35CE7E20815308C6018224320C637F013E9A9ED4080EAC1C201E363BFF798FBAQRBU:3:7 VRQR:1.5 VRCH:20180830 7705:1 7706:1 7707:1 7708:1 7709:1 7710:2 7711:1 7712:1 7713:1 7714:1 7715:2 7716:1 LEGP:2 TOTP:21 APTA:303 NOMI:133 LEGC:27 BRAN:143 NULO:0 TOTC:303 CARG:7 TIPO:1 VERC:201808301320 PART:10 10001:1 10002:1 10003:1 10004:1 10005:1 10006:1 10007:2 10008:1 10009:1 10010:1 10011:1 10012:1 10013:1 10014:2 10015:1 10016:1 10017:2 10018:1 10019:1 10020:1 10021:2 10022:1 10023:1 10024:1 10025:1 10026:1 10027:1 10028:1 10029:1 10030:1 10031:1 10032:2 10033:1 10034:1 10035:1 10036:1 LEGP:0 TOTP:41 PART:11 11001:1 11002:1 11003:1 11004:1 11005:1 11006:1 11007:1 11008:1 11009:1 11010:1 11011:1 11012:1 11013:1 11014:1 11015:1 11016:1 11017:1 11018:1 11019:1 11020:1 11021:1 11022:1 11023:1 11024:1 11025:1 11026:1 11027:1 11028:1 11029:1 11030:1 11031:1 11032:1 11033:1 11034:1 11035:1 11036:1 LEGP:0 TOTP:36 PART:12 12001:1 HASH:4AEA4B1EA680EE0D05BC825E1E45766FE3D131B3D39762409CC7CE1F48CDB73F8A3A5071C2E268C2779FF285C5F39DEAD89091366A7D50F6028C1E386F7BA93CQRBU:4:7 VRQR:1.5 VRCH:20180830 12002:1 12003:1 12004:1 12005:1 12006:1 12007:1 12008:1 12009:1 12010:1 12011:1 12012:1 12013:1 12014:1 12015:3 12016:1 12017:1 12018:1 12019:1 12020:1 12021:1 12022:1 12023:1 12024:1 12025:1 12026:1 12027:1 12028:1 12029:1 12030:1 12031:1 12032:1 12033:1 12034:1 12035:1 12036:1 LEGP:0 TOTP:38 PART:13 13001:1 13002:1 13003:1 13004:1 13005:1 13006:1 13007:1 13008:1 13009:1 13010:1 13011:1 13012:1 13013:1 13014:1 13015:1 13016:1 13017:1 13018:1 13019:1 13020:1 13021:1 13022:1 13023:1 13024:1 13025:1 13026:1 13027:1 13028:1 13029:1 13030:1 13031:2 13032:1 13033:1 13034:1 13035:1 13036:1 LEGP:0 TOTP:37 PART:14 14001:1 14002:2 LEGP:0 TOTP:3 PART:15 15003:1 15004:1 15031:1 LEGP:0 TOTP:3 PART:16 16005:2 16006:1 16032:1 LEGP:0 TOTP:4 PART:17 17007:1 17008:1 17033:1 LEGP:0 TOTP:3 PART:18 18009:1 18010:1 18034:1 LEGP:0 HASH:98E3175408FF4BCED789DEF4FFEBEE863A2A1A744A3259DC91B9D581AAAD401C5AD1A7806DFFB866293F02CB807DAA01E9F58047DA8CF2AEB6E91DE2DC72E7D6QRBU:5:7 VRQR:1.5 VRCH:20180830 TOTP:3 PART:19 19011:1 19012:1 19035:1 LEGP:0 TOTP:3 PART:20 20013:1 20014:1 20036:1 LEGP:0 TOTP:3 PART:21 21015:2 21016:1 LEGP:0 TOTP:3 PART:22 22017:1 22018:1 LEGP:0 TOTP:2 PART:23 23019:1 23020:1 LEGP:0 TOTP:2 PART:25 25021:1 25022:1 LEGP:0 TOTP:2 PART:27 27023:1 27024:1 LEGP:0 TOTP:2 PART:28 28025:1 28026:1 LEGP:0 TOTP:2 PART:31 31027:1 31028:1 LEGP:0 TOTP:2 PART:33 33029:1 33030:1 LEGP:0 TOTP:2 PART:35 35001:2 35002:1 35003:1 35004:1 35005:1 35006:1 35007:1 35008:1 35009:1 35010:1 35011:1 35012:1 35013:1 35014:1 35015:1 35016:1 35017:1 35018:1 LEGP:0 TOTP:19 PART:36 36019:1 36020:1 36021:1 36022:1 36023:1 36024:1 36025:1 36026:1 36027:1 36028:1 36029:1 36030:1 36031:1 36032:1 36033:1 36034:1 36035:1 36036:1 LEGP:0 TOTP:18 PART:44 44001:1 44002:1 44003:1 44004:1 44005:1 44006:1 44007:1 44008:1 44009:1 HASH:4203065E1892F19CE65DA97739EAB525206E4BB28E9CA22FB190F154681572191BA562420D5D6E10153A86899D1D2FEBCDC11EE33C44C7B86AC6BD8CC9EA8DAAQRBU:6:7 VRQR:1.5 VRCH:20180830 44010:1 44011:1 44012:1 44013:1 44014:1 44015:1 44016:1 44017:1 44018:1 LEGP:0 TOTP:18 PART:45 45019:1 45020:2 45021:1 45022:1 45023:1 45024:1 45025:1 45026:1 45027:1 45028:1 45029:1 45030:2 45031:1 45032:1 45033:1 45034:1 45035:1 45036:1 LEGP:0 TOTP:20 PART:50 50001:1 50002:1 50003:1 50004:1 50005:1 50006:1 50007:1 50008:1 50009:1 50010:1 50011:1 50012:1 50013:1 50014:1 50015:1 50016:1 50017:2 50018:1 LEGP:0 TOTP:19 PART:51 51019:1 51020:2 51021:1 51022:1 51023:1 51024:1 51025:1 51026:1 51027:1 51028:1 51029:2 51030:1 51031:1 51032:1 51033:1 51034:1 LEGP:0 TOTP:18 APTA:303 NOMI:303 LEGC:0 BRAN:0 NULO:0 TOTC:303 CARG:5 TIPO:0 VERC:201808301320 100:3 110:5 120:4 130:4 140:4 350:2 400:2 500:2 770:3 APTA:303 NOMI:29 BRAN:571 NULO:6 TOTC:606 CARG:3 TIPO:0 VERC:201808301320 10:2 11:3 12:2 13:1 14:2 40:2 50:1 77:1 HASH:19A0FEC64A88230A724B6EC734AF0BE666DC19314A86532F120A82EEB2F493BEAAEA3879440FCD48287172EB16D10472823338902FF44EC6028F2227CDDB85F3QRBU:7:7 VRQR:1.5 VRCH:20180830 APTA:303 NOMI:14 BRAN:286 NULO:3 TOTC:303 IDEL:3189 CARG:1 TIPO:0 VERC:201808301239 10:1 11:1 12:1 13:1 14:2 35:1 40:1 44:1 50:1 51:1 54:1 55:1 65:1 77:3 APTA:303 NOMI:17 BRAN:283 NULO:3 TOTC:303 HASH:39CC7880915FE1591DBD1D8AE3D1700DF4C154B6EB3758CDF910222BC0BC29187FA935CD8DA8B9D065822496ABA46E4EFA949B680DA4A106DDAC469E2F802C75 ASSI:8122AA8FE7C4CE05BE6AF46A888565CCD2B913D6F9BA5B0827560731808C83945F6B42E8FF8A73F41DDFFE5294BA6C1110D735E39143C07927D77BFD3FD23102"

   var body: some View {
    return ZStack(alignment: Alignment.topTrailing) {
         HStack {
            Button(action: { self.showUpdate.toggle() }) {
               CircleButton(icon: "plus")
                  .sheet(isPresented: self.$showUpdate) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: self.qrCode) { result in
                        switch result {
                        case .success(let code):
                            print("Found code: \(code)")
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    //UpdateList()
                    
                }
            }
         }
         Spacer()
      }
   }
}
