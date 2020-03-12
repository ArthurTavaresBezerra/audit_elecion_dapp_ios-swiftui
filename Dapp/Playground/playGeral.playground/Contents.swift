enum Status : Hashable {
    
    case start
    case completed(String)

   //MARK: Hashable

    var hashValue: Int {
        
        return rawValue.hashValue
    }
 
    
    private var rawValue : String {
        
        let value : String
        switch self {
        case .start:
            value = "start"
        case .completed(_):
            value = "completed"
        }
        
        return value
    }
}
Status.start.hashValue

let s1 = Status.completed("A")
let s2 = Status.completed("B")

s1.hashValue == s2.hashValue //true

var statuses = [Status : String]()

statuses[s1] = "aaa"
statuses[s2] = "bbb"

print(statuses) //1 value
