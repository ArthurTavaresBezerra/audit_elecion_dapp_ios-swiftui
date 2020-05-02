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
            NavigationView{
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        Image("Illustration5")
                            .resizable()
                            .frame(width: 70, height: 70, alignment: .leading)
                        ForEach(viewModel.boletim.boletimCargos) { cargo in
                            Section(header: AddBoletimListHeaderView(nameCargo: cargo.name)) {
                                ForEach(cargo.boletimDetalhes) { det in
                                    AddBoletimRowView(det: det)
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle(Text("Boletim de Urna"))
                .navigationBarItems(trailing:
                    Button(action: {
                        self.viewModel.saveLocalAndBlockChain()
                    }){
                        AddBoletimBtnBlockChainView(isProcessing: viewModel.isProcessing, isAlreadyExists: viewModel.isAlreadyExists, qtdToProcess: viewModel.qtdToProcess, qtdProcessed: viewModel.qtdProcessed)
                    }
                    .disabled(viewModel.isAlreadyExists || viewModel.isProcessing)
                )
            }
            .onAppear(perform: {
                self.viewModel.decodeBoletim(qrCode: self.qrCode)
            })
            .blur(radius: show ? 20 : 0)
            .animation(.default)
    }
}

#if DEBUG
struct AddBoletimView_Previews: PreviewProvider {
   static var previews: some View {
        AddBoletimView(qrCode: PListHelper.readProperty("qrCodeExample"))
   }
}
#endif

struct AddBoletimListHeaderView: View {
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

struct AddBoletimBtnBlockChainView : View {
    var isProcessing : Bool = false
    var isAlreadyExists : Bool = false
    var qtdToProcess : Int = 0
    var qtdProcessed : Int = 0
    var body: some View {
        HStack {
           if isProcessing {
               Text("\(qtdProcessed)")
                    .fontWeight(.semibold)
                    .font(.footnote)
                    .foregroundColor(Color(UIColor.darkGray))
                Text(" de   \(qtdToProcess)")
                     .fontWeight(.semibold)
                     .font(.footnote)
                     .foregroundColor(Color(UIColor.darkGray))
                ActivityIndicator(isAnimating: .constant(true), style: .medium)
                    .frame(width: 25, height: 20, alignment: .trailing)
           }
           else {
               Image(systemName: "tray.and.arrow.up")
                   .font(.footnote)
                Text(isAlreadyExists ?  "Já enviado" : "Blockchain")
                   .fontWeight(.semibold)
                   .font(.footnote)
           }
          }
          .padding(10)
          .foregroundColor(.white)
        .background( isAlreadyExists ? Color.gray : isProcessing ? Color(UIColor.lightGray) : Color("background7"))
          .cornerRadius(40)
          .animation(.easeOut(duration: 0.3))
    }
}

struct AddBoletimRowView : View {
    var det : BoletimDetalheVM = BoletimDetalheVM(
        id: "id",
        boletim: BoletimVM(id: "", cUF: 11, cMum: 22),
        cPartido: 1,
        namePartido: "Nome Partido",
        cCargo: 2,
        nameCargo: "Nome Cargo",
        cCandidato: 23,
        qtdVoto: 3,
        idTransactionBlockchain: "",
        isProcessado: false)
    
    var body: some View {
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
        }.padding(.horizontal, 10)
    }
}
