//
//  AddBoletimView.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 09/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import SwiftUI
 
struct AddBoletimView: View {

    var qrCode : String
    
    @State var show = false
    @State var viewState = CGSize.zero
    
    @ObservedObject var viewModel = AddBoletimViewModel()
    
    var body: some View {
        NavigationView {
            NavigationView{
                VStack {
                    Rectangle().frame(width: 0, height: 80, alignment: .center)
                    ScrollView {
                        Image("Illustration5")
                            .resizable()
                            .frame(width: 70, height: 70, alignment: .leading)
                        ForEach(viewModel.boletim.boletimCargos) { cargo in
                            Section(header: AddBoletimListHeader(nameCargo: cargo.name)) {
                                ForEach(cargo.boletimDetalhes) { det in
                                    HStack {
                                        VStack {
                                            HStack {
                                                Image(uiImage: UIImage(systemName: "number.square")!)
                                                Text("Candidato \(det.cCandidato)")
                                                    .font(.footnote)
                                            }
                                            Text("Partido: \(det.namePartido)").foregroundColor(.gray)
                                                .font(.footnote)
                                        }
                                        Spacer()
                                        HStack {
                                            Image(systemName: "person.3")
                                                .font(.footnote)
                                            Text("\(det.qtdVoto)")
                                                .font(.footnote)
                                        }
                                        .padding(15)
                                        .foregroundColor(.white)
                                        .background(det.isProcessado ? Color("greenPrimary"): Color("icons"))
                                        .cornerRadius(20)
//                                        .padding(.top, 10)
                                        
                                    }
                                }
                            }
                        }
                    }
                }.padding()
            }
            .onAppear(perform: {
                self.viewModel.fetchDogs()
                self.viewModel.decodeBoletim(qrCode: self.qrCode)
            })
            .navigationBarTitle(Text("Boletim de Urna"))
            .edgesIgnoringSafeArea([.top, .bottom])
            .navigationBarItems(trailing:
                Button(action: { self.viewModel.saveLocalAndBlockChain() }){
                   HStack {
                    if viewModel.isProcessing {
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                            .frame(width: 60, height: 50, alignment: .center)

                    }
                    else {
                        Image(systemName: "tray.and.arrow.up")
                            .font(.body)
                        Text("Blockchain")
                            .fontWeight(.semibold)
                            .font(.footnote)
                    }
                   }
                   .padding()
                   .foregroundColor(.white)
                   .background(viewModel.isProcessing ? Color.clear : Color("background7"))
                   .cornerRadius(40)
                   .animation(.easeOut(duration: 0.3))

               }
           )
            .blur(radius: show ? 20 : 0)
            .animation(.default)
        }.background(Color("gray"))
//        .edgesIgnoringSafeArea([.top, .bottom])

    }
}

#if DEBUG
struct AddBoletimView_Previews: PreviewProvider {
   static var previews: some View {
        AddBoletimView(qrCode: PListHelper.readProperty("qrCodeExample"))
   }
}
#endif

struct AddBoletimListHeader: View {
    var nameCargo : String = "Cago Político"
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")//.foregroundColor(.white)
            Text(nameCargo)//.foregroundColor(.white)
            Spacer()
        }
        .padding(6)
        .padding(.leading,0)
     
        .background(Color("gray"))
    }
}
