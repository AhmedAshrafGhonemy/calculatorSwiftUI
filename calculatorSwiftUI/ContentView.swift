//
//  ContentView.swift
//  calculatorSwiftUI
//
//  Created by macbook on 08/12/2021.
//

import SwiftUI

enum CalcButton : String {
    
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor : Color {
        switch self {
        case .divide , .multiply, .subtract, .add, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default :
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
 
        }
    }
    
}

enum operation{
    case add , subtract , multiply , divide , none
}

struct ContentView: View {
    
    @State var Value = "0"
    @State var runningNumber = 0
    @State var CurrentOperation: operation = .none
    
    let buttons : [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
        
    ]
    var body: some View {
        
        ZStack {
            Color.black.ignoresSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(Value)
                        .foregroundColor(.white)
                        .font(.system(size: 90))
                        .bold()
                }
                .padding()
                
                ForEach(buttons, id: \.self){row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self){item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 33))
                                    .frame(width: self.buttonWidth(item: item),
                                           height: self.buttonHight())
                                    .foregroundColor(.white)
                                    .background(item.buttonColor)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                                
                            })
                        }
                    }
                    .padding(.bottom ,3)
                }
            }
        }
    }
    func didTap (button: CalcButton){
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add {
                self.CurrentOperation = .add
                self.runningNumber = Int(self.Value) ?? 0
            }
            else if button == .subtract {
                self.CurrentOperation = .subtract
                self.runningNumber = Int(self.Value) ?? 0
            }
            else if button == .multiply {
                self.CurrentOperation = .multiply
                self.runningNumber = Int(self.Value) ?? 0
            }
            else if button == .divide {
                self.CurrentOperation = .divide
                self.runningNumber = Int(self.Value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.Value) ?? 0
                switch self.CurrentOperation{
                case .add : self.Value = "\(runningValue + currentValue)"
                case .subtract : self.Value = "\(runningValue - currentValue)"
                case .multiply : self.Value = "\(runningValue * currentValue)"
                case .divide : self.Value = "\(runningValue / currentValue)"
                case .none :
                    break
                }
            }
            if button != .equal {
                self.Value = "0"
            }
        case .negative , .decimal, .percent:
            break
        case .clear:
            self.Value = "0"
        default :
            let number = button.rawValue
            if self.Value == "0" {
                Value = number
            }
            else{
                self.Value = "\(self.Value)\(number)"
        }
        }}
    func buttonWidth(item: CalcButton) -> CGFloat{
        if item == .zero{
            return(UIScreen.main.bounds.width - (4*12)) / 2
        }
        return(UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHight()-> CGFloat{
        return(UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
