protocol AdvancedLifeSupport{
    func performCPR()
}


class EmergencyCallHendler{
    var delegate: AdvancedLifeSupport?
    
    func assessSituation(){
        print ("Can you tell me")
    }
    
    func medicalEmergency(){
        delegate?.performCPR()
    }
    
}

struct Paramedic: AdvancedLifeSupport{
    
    init(handler: EmergencyCallHendler){
        handler.delegate = self
    }
    
    func performCPR() {
        print ("THE PARAMEDIC DOES chest")
    }
    
    
}

let emilio = EmergencyCallHendler()
let pete = Paramedic(handler: emilio)

emilio.assessSituation()
emilio.medicalEmergency()
