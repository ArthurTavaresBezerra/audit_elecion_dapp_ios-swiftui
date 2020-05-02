import Foundation
import SwiftUI
import Combine

struct TestView: View {
    @ObservedObject var mypeople: People = People()

    var body: some View {
        VStack{
            ForEach(mypeople.boletimDetalhes){ person in
                Text("\(person.namePartido)-\(person.isProcessado ? "true" : "false")")
            }
            Button(action: {
                self.mypeople.boletimDetalhes[0].namePartido="Jaime"
                self.mypeople.boletimDetalhes[0].isProcessado.toggle()
            }) {
                Text("Add/Change name")
            }
        }
    }
}
class People: ObservableObject{
    @Published var boletimDetalhes: [BoletimDetalheVVM] = []

    init(){
        self.boletimDetalhes = [
            BoletimDetalheVVM(
                id: "a2",
                cPartido: 1,
                namePartido: "a2",
                cCargo: 3,
                nameCargo: "4",
                cCandidato: 2,
                qtdVoto: 3,
                idTransactionBlockchain: "",
                isProcessado: false),
            BoletimDetalheVVM(
                id: "a3",
                cPartido: 1,
                namePartido: "a3",
                cCargo: 3,
                nameCargo: "4",
                cCandidato: 2,
                qtdVoto: 3,
                idTransactionBlockchain: "",
                isProcessado: false),
            BoletimDetalheVVM(
                id: "a4",
                cPartido: 1,
                namePartido: "a4",
                cCargo: 3,
                nameCargo: "4",
                cCandidato: 2,
                qtdVoto: 3,
                idTransactionBlockchain: "",
                isProcessado: false),
            BoletimDetalheVVM(
                id: "a5",
                cPartido: 1,
                namePartido: "a5",
                cCargo: 3,
                nameCargo: "4",
                cCandidato: 2,
                qtdVoto: 3,
                idTransactionBlockchain: "",
                isProcessado: false)

        ]
    }
}
 
struct BoletimDetalheVVM : Identifiable{
  
    var id : String
    var cPartido: Int
    var namePartido : String
    var cCargo : Int
    var nameCargo : String
    var cCandidato: Int
    var qtdVoto: Int
    var idTransactionBlockchain: String
    var isProcessado: Bool
    
    init(id : String, cPartido: Int, namePartido : String, cCargo : Int, nameCargo : String, cCandidato: Int, qtdVoto: Int, idTransactionBlockchain: String, isProcessado: Bool) {
        self.id = id
        self.cPartido = cPartido
        self.namePartido = namePartido
        self.cCargo = cCargo
        self.nameCargo = nameCargo
        self.cCandidato = cCandidato
        self.qtdVoto = qtdVoto
        self.idTransactionBlockchain = idTransactionBlockchain
        self.isProcessado = isProcessado
    }
}

