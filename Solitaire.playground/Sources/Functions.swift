import UIKit
import PlaygroundSupport
import Darwin
import Foundation

public var containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 400, height: 600))

public var generationLabel = UILabel(frame: CGRect(x : 20, y : 400, width : 180, height : 30))
public var bestFitnessLabel = UILabel(frame: CGRect(x : 20, y : 430, width : 180, height : 30))
public var averageFitnessLabel = UILabel(frame: CGRect(x : 200, y : 400, width : 180, height : 30))
public var historicalBestFitLabel = UILabel(frame: CGRect(x : 200, y : 430, width : 180, height : 30))

public class sliderWithLabel{
    var slider : UISlider
    var label : UILabel
    var text : String
    var value : Float

    
    @objc func changeVal(){
        self.value = self.slider.value
        self.label.text = self.text + String(floor(self.slider.value*100)/100)
        
    }
    
    init(frame: CGRect, labelText: String, initvalue: Float, max: Float, min : Float){
        self.label = UILabel(frame: frame);
        self.value = initvalue
        var framelabel = frame;
        framelabel.origin.x += 180

        self.slider = UISlider(frame: framelabel);
        self.slider.isContinuous = true;
        
        self.slider.maximumValue = max
        self.slider.minimumValue = min
        
        self.slider.value = initvalue
        
        self.text = labelText
        self.label.text = labelText + String(Int(initvalue))
        
        
        containerView.addSubview(self.slider);
        containerView.addSubview(self.label);
        
        self.slider.addTarget(self, action: #selector(self.changeVal), for: .valueChanged)
        
        
        
    }
    init(){
        self.slider = UISlider()
        self.label = UILabel()
        self.text = ""
        self.value = 100
    }

}


public var ColorField = [
    "darkBlue": UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.0),
    "lightBlue": UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.0),
    "lightGray": UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.0),
    "green" : UIColor(red:0.18, green:0.80, blue:0.44, alpha:1.0),
    "red" : UIColor(red:0.91, green:0.30, blue:0.24, alpha:1.0),
    "yellow" : UIColor(red:0.95, green:0.77, blue:0.06, alpha:1.0)
]

public func random0and1() -> Double{
    return Double(arc4random_uniform(UInt32.max))/Double(UInt32.max)
}

public class Direction {
    var up: Int?
    var left: Int?
    var right: Int?
    var down: Int?
    
    init(u: Int?, l: Int?, r: Int?, d: Int?){
        self.up = u
        self.down = d
        self.left = l
        self.right = r
    }
    subscript(name: String) -> Dot? {
        switch name {
        case "up":
            return (self.up == nil) ? nil : mapDot[self.up!]
        case "left":
            return (self.left == nil) ? nil : mapDot[self.left!]
        case "right":
            return (self.right == nil) ? nil :mapDot[self.right!]
        case "down":
            return (self.down == nil) ? nil : mapDot[self.down!]
        default:
            return Dot()
        }
    }
}
public class Circle : UIView {
    init(pos: CGPoint, dia: CGFloat){
        super.init(frame: CGRect(x: pos.x, y: pos.y, width: dia, height: dia))
        self.layer.cornerRadius = dia/2+1
        self.backgroundColor = ColorField["lightBlue"]
        containerView.addSubview(self);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




public class Dot {
    var stat: Bool
    var dotAjd: Direction
    var id : Int
    var action : [String]
    var view : Circle
    
    init(){
        self.stat = true
        self.dotAjd = Direction(u: nil,l: nil,r: nil,d: nil)
        self.id = 0
        self.action = []
        self.view = Circle(pos: CGPoint(),dia: 0.0)
        
        
    }
    
}


public var mapDot : [Dot] = []
public var dotPlay: [Dot] = []
public var compt = 0
public var completementBloque = false
public var numberOfCase = 33
public var popSize = 100
public var popSlider = sliderWithLabel()
public var bestFit = ["value" : 0, "index" : 0]
public var leastFit = 33
public var mutationRate: Double = 0.01
public var mutationSlider = sliderWithLabel()
public var strangers:Double = 0.1
public var strangerSlider = sliderWithLabel()
public let crossOverOffset: Double = 4.0
public let TheorethicalBestFit = 31
public var historicalBestFit = 0
public let crossOverPower : Double = 3

public func createField(){
    containerView.addSubview(generationLabel);
    containerView.addSubview(averageFitnessLabel);
    containerView.addSubview(historicalBestFitLabel);
    containerView.addSubview(bestFitnessLabel);
    
    popSlider = sliderWithLabel(frame: CGRect(x : 20, y : 500, width : 180, height : 20), labelText: "Population : " , initvalue: 100, max : 200, min: 20 )
    
    mutationSlider = sliderWithLabel(frame: CGRect(x : 20, y : 530, width : 180, height : 20), labelText: "Mutation : " , initvalue: 0.01, max : 1, min: 0 )
    
    strangerSlider = sliderWithLabel(frame: CGRect(x : 20, y : 560, width : 180, height : 20), labelText: "Strangers : " , initvalue: 0.1, max : 1, min: 0 )
    
    let w: CGFloat = containerView.frame.size.width;
    let rdot: CGFloat =  w/15.0;
    let milieuDot: CGFloat = w/2.0;
    let centralDots = 21
    let coteGauche = 27
    let coteDots = 6
    let cotes = 2
    let centerNumber = 10
    
    
    for _ in 0..<numberOfCase {
        mapDot.append(Dot())
    }
    
    
    for i in 0..<centralDots {
        let posX: CGFloat = milieuDot-rdot*(2.5-CGFloat((i%3)*2))
        let posY: CGFloat = rdot*(1+floor(CGFloat(i)/3.0)*2)
        
        
        let pos = CGPoint(x: posX, y : posY )
        mapDot[i].id = i;
        mapDot[i].view = Circle(pos: pos,dia: rdot)
        //Centre
        if(i==centerNumber){
            mapDot[i].stat = false;
            mapDot[i].view.backgroundColor = ColorField["darkBlue"];
        }
        
        
        
        
    }
    
    
    for i in 0..<coteDots {
        for j in 0..<cotes {
            let k=centralDots+i*2+j;
            
            
            
            let posY = milieuDot-rdot*(2.5-CGFloat(i%3)*2);
            var posX: CGFloat
            if(i>2){
                posX = milieuDot+rdot*3.5+CGFloat(j)*2.0*rdot;
            }else{
                posX = rdot+CGFloat(j)*rdot*2;
            }
            let pos = CGPoint(x: posX, y : posY )
            
            
            mapDot[k].id = k;
            mapDot[k].view = Circle(pos: pos,dia: rdot)
        }
    }
    
    for i in 0..<numberOfCase{
        
        if(i<centralDots){
            if(i%3==0){
                
                mapDot[i].dotAjd = Direction(
                    u : (i==0) ? nil: i-3,
                    l : (i<6 || i>12) ? nil : (((i/3)-1)*2)+20,
                    r : i+1,
                    d : (i==18) ? nil : i+3)
                
                
            }else if(i%3==1){
                
                mapDot[i].dotAjd = Direction(
                    u :  (i==1) ? nil : i-3,
                    l : i-1,
                    r : i+1,
                    d : (i==19) ? nil : i+3
                )
                
                
            }else{
                mapDot[i].dotAjd = Direction(
                    u : (i==2) ? nil : i-3,
                    l : i-1,
                    r : (i<6 || i>14) ? nil : ((((i-2)/3)-1)*2)+25,
                    d : (i==20) ? nil : i+3
                    
                )
                
            }
            
            
        }else if(i<coteGauche){
            if(i%2==1){
                mapDot[i].dotAjd = Direction(
                    u : (i==21) ? nil : i-2,
                    l : nil,
                    r : i+1,
                    d : (i==25) ? nil : i+2
                    
                    
                )
                
            }else{
                mapDot[i].dotAjd = Direction(
                    u : (i==22) ? nil : i-2,
                    l : i-1,
                    r : ((((i-20)/2)+1)*3),
                    d : (i==26) ? nil : i+2
                )
            }
        }else{
            if(i%2==1){
                mapDot[i].dotAjd = Direction(
                    u : (i==27) ? nil : i-2,
                    l : (((((i-25)/2)+1)*3)+2),
                    r : i+1,
                    d : (i==31) ? nil : i+2
                )
                
            }else{
                mapDot[i].dotAjd = Direction(
                    u : (i==28) ? nil : i-2,
                    l : i-1,
                    r : nil,
                    d : (i==32) ? nil : i+2
                )
                
                
            }
            
        }
    }
}

public func joue_coup(d1: Dot, dir: String){
    let couleur1 = d1.view;
    let couleur2 = d1.dotAjd[dir]!.dotAjd[dir]!.view;
    d1.stat = false;
    d1.dotAjd[dir]!.stat = false;
    d1.dotAjd[dir]!.dotAjd[dir]!.stat = true;
    
    dotPlay = [];
    colorise();
    
    couleur1.backgroundColor = ColorField["red"];
    couleur2.backgroundColor = ColorField["green"];
    
}

public func colorise(){
    actionZero();
    var compt = 0;
    
    for i in 0..<numberOfCase {
        if(!mapDot[i].stat){
            mapDot[i].view.backgroundColor = ColorField["darkBlue"];
        }else if(to_play(dot: mapDot[i])){
            compt += 1;
            mapDot[i].view.backgroundColor = ColorField["yellow"];
        }else {
            compt += 1;
            mapDot[i].view.backgroundColor = ColorField["lightBlue"];
            
        }
        
    }
}


public func playArray(arr: [Double]) -> Int{
    var k = 0;
    remiseAZero();
    actionZero();
    colorise();
    
    while(!is_blocked()){
        let i = Int(arr[2*k]*Double(dotPlay.count));
        let j = Int(arr[2*k+1]*Double(dotPlay[i].action.count));
        
        joue_coup(d1: dotPlay[i], dir: dotPlay[i].action[j]);
        k += 1;
        
    }
    return k;
}
public func is_blocked()->Bool{
    if(dotPlay.isEmpty || completementBloque){
        return true;
    }
    else {
        return false;
    }
}
public func remiseAZero(){
    completementBloque = false;
    for i in 0..<numberOfCase {
        if(i != 10){
            mapDot[i].stat = true;
            
        }else{
            mapDot[i].stat = false;
        }
    }
}
public func actionZero() {
    dotPlay = [];
    for i in 0..<numberOfCase {
        mapDot[i].action = [];
        
    }
}
public func to_play(dot: Dot) -> Bool {
    var play = false;
    let dir = ["up", "left", "right", "down"];
    
    var localementBloque = true;
    for d in dir {
        // Playable
        if(test_exist(t: dot, dir: d) && dot.dotAjd[d]!.stat && !dot.dotAjd[d]!.dotAjd[d]!.stat){
            play = true;
            dot.action.append(d);
            dotPlay.append(dot);
        }
        
        // Completely isolated
        if(dot.dotAjd[d] != nil){
            let cur = dot.dotAjd[d]!;
            if(!cur.stat){
                for secondDir in dir {
                    let secondNeighbourg = cur.dotAjd[secondDir];
                    if(secondNeighbourg != nil && secondNeighbourg!.id != dot.id){
                        if(secondNeighbourg!.stat){
                            localementBloque = false;
                        }
                    }
                }
            }else{
                localementBloque = false;
            }
        }
    }
    
    if(localementBloque){
        completementBloque = true;
    }
    return play;
}
public func test_exist(t : Dot, dir: String) -> Bool {
    if(t.dotAjd[dir] != nil){
        if t.dotAjd[dir]!.dotAjd[dir] != nil {
            return true;
        }
    }
    
    return false;
}
public func actualiseValueFromSlider(){
    if(Int(popSlider.value) != popSize){
        
        var newPop: [DNA] = []
        for i in 0..<Int(popSlider.value){
            if(i<popSize){
                newPop.append(population[i]);
            }else{
                newPop.append(DNA());
            }

        }
        population = newPop
        popSize = Int(popSlider.value)
    }
    if(Double(mutationSlider.value) != mutationRate){
        mutationRate = Double(mutationSlider.value)
    }
    if(Double(strangerSlider.value) != strangers){
       strangers = Double(strangerSlider.value)
    }
    
    
}
public class DNA {
    var fitness = 0
    var length = 62
    var code : [Double]
    
    init(){
        self.code = []
        for _ in 0..<self.length {
            self.code.append(random0and1())
        }
    }
    public func mutate(){
        for i in 0..<self.length {
            if( random0and1() < mutationRate){
                self.code[i] = random0and1();
            }
        }
        
    }
};
public var population : [DNA] = []
public var matingPool : [DNA] = []


public func createPopulation(){
    for _ in 0..<popSize {
        population.append(DNA())
    }
}


public func evaluate(){
    actualiseValueFromSlider()
    bestFit = ["value" : 0, "index" : 0];
    leastFit = TheorethicalBestFit;
    var moyenne : Double = 0;
    for i in 0..<popSize {
        population[i].fitness = playArray(arr: population[i].code);
       
        moyenne += Double(population[i].fitness)/Double(popSize);
        if(bestFit["value"]! <  population[i].fitness){
            bestFit["value"] = population[i].fitness;
            bestFit["index"] = i;
        }
        if(leastFit > population[i].fitness){
            leastFit = population[i].fitness;
        }
    }
    
    if(bestFit["value"]! > historicalBestFit){
        historicalBestFit = bestFit["value"]!;
    }
    bestFitnessLabel.text = "Best Fitness : " + String(bestFit["value"]!)
    averageFitnessLabel.text = "Average Fitness : " + String((floor(Double(moyenne*100))/100))
    historicalBestFitLabel.text = "Historical Best Fit : " + String(historicalBestFit)
  
    
    _ = playArray(arr: population[bestFit["index"]!].code);

    
}

public func createMatingPool(){
    matingPool = []
    for i in 0..<popSize {
        if(bestFit["value"]!-leastFit != 0){
            
            let n = (population[i].fitness+1-leastFit)/(bestFit["value"]!+1-leastFit)*5;
            for _ in 0..<n {
                matingPool.append(population[i])
            }
        }else{
            matingPool.append(population[i])
        }
    }

}
public func crossOver(mother: DNA, father: DNA) -> DNA{
    let child = DNA();
    
    //traditionnal
    var randomIndex: Int = Int(floor(random0and1()*Double(child.length)));
    
    //my style
    let randomNum : Int = Int(floor(pow(random0and1(),crossOverPower)*Double(popSize))+crossOverOffset);
    
    randomIndex = 2*(mother.fitness-randomNum);
    
    
    for i in 0..<child.length {
        if(i < randomIndex){
            child.code[i] = mother.code[i];
        }else{
            child.code[i] = father.code[i];
        }
    }
    return child;
}


public func reproduction(){
    for i in 0..<popSize {
        if(Double(i) < (1-strangers)*Double(popSize)){
            let mother = matingPool[Int(floor(random0and1()*Double(matingPool.count)))];
            let father = matingPool[Int(floor(random0and1()*Double(matingPool.count)))];
        
            let child = crossOver(mother: mother,father: father);
            
            child.mutate();
            
            population[i] = child;
        }else {
            population[i] = DNA();
        }
        
        
    }
}

