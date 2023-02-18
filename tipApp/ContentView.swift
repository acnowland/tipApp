//
//  ContentView.swift
//  tipApp
//
//  Created by Adam Nowland on 2/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    
    var finalAmount: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipPercent = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipPercent
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    private let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Check Amount: ", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<99) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip Amount", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
                    Text(finalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                }
            }
            .navigationTitle("We Split")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
