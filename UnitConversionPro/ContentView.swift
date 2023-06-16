//
//  ContentView.swift
//  UnitConversionPro
//
//  Created by Jaymond Richardson on 6/15/23.
//

import SwiftUI

// TODO: finish computing volume, make keyboard a number pad

struct ContentView: View {
    
    // MARK: - WRAPPED PROPERTIES
    @State private var selectedUnit: Unit = .temperature
    
    // MARK: - PROPERTIES
    var units = Unit.allCases.map { ($0)}
    
    // MARK: - VIEWS
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Converting", selection: $selectedUnit) {
                        ForEach(units, id: \.self) { Text($0.rawValue) }
                    }
                    .pickerStyle(.automatic)
                }
                switch selectedUnit {
                case .temperature:
                    TemperatureView()
                case .time:
                    TimeView()
                case .volume:
                    VolumeView()
                case .length:
                    LengthView()
                }
            }
            .navigationTitle("Unit Conversion")
        }
    }
}

// MARK: - VOLUME VIEW
struct VolumeView: View {
    // MARK: - WRAPPED PROPERTIES
    @State private var input: Double = 0
    @State private var inputUnit: VolumeUnit = .milliliters
    @State private var outputUnit: VolumeUnit = .milliliters
    
    // MARK: - PROPERTIES
    var units = VolumeUnit.allCases.map { ($0) }
    
    // MARK: - VIEWS
    var body: some View {
        Section {
            Picker("Input", selection: $inputUnit) {
                ForEach(units, id: \.self) { Text($0.rawValue) }
            }
            
            TextField("", value: $input, format: .number)
        } header: {
            Text("Volume")
                .padding(.leading, -20)
        }
        
        Section {
            Picker("Output", selection: $outputUnit) {
                ForEach(units, id: \.self) { Text($0.rawValue) }
            }
            Text(calulateVolume(input: input, inputUnit: inputUnit, outputUnit: outputUnit))
        } header: {
            Text("Volume")
                .padding(.leading, -20)
        }
    }
    
    // MARK: - FUNCTIONS
    func calulateVolume(input: Double, inputUnit: VolumeUnit, outputUnit: VolumeUnit) -> String {
        var inputInMilliliters: Double
        var output: Double
        
        switch inputUnit {
        case .milliliters:
            inputInMilliliters = input
        case .liters:
            inputInMilliliters = input * 1000
        case .cups:
            inputInMilliliters = input * 236.588
        case .pints:
            inputInMilliliters = input * 473.176
        case .gallons:
            inputInMilliliters = input * 3785.41
        }
        
        switch outputUnit {
        case .milliliters:
            output = inputInMilliliters
        case .liters:
            output = inputInMilliliters / 1000
        case .cups:
            output = inputInMilliliters / 236.588
        case .pints:
            output = inputInMilliliters / 473.176
        case .gallons:
            output = inputInMilliliters / 3785.41
        }
        
        return String(format: "%.2f", output)
    }
}


// MARK: - TIME VIEW
struct TimeView: View {
    // MARK: - WRAPPED PROPERTIES
    @State private var inputUnit: TimeUnit = .seconds
    @State private var outputUnit: TimeUnit = .seconds
    @State private var input: Double = 0
    @State private var output: Double = 0
    
    
    // MARK: - PROPERTIES
    var units = TimeUnit.allCases.map { $0 }
    
    // MARK: - VIEWS
    var body: some View {
        Section {
            Picker("", selection: $inputUnit) {
                ForEach(units, id: \.self) { Text($0.rawValue) }
            }
            .pickerStyle(.segmented)
            
            TextField("", value: $input, format: .number)
        } header: {
            Text("Input")
                .padding(.leading, -20)
        }
        
        Section {
            Picker("", selection: $outputUnit) {
                ForEach(units, id: \.self) { Text($0.rawValue) }
            }
            .pickerStyle(.segmented)
            Text(calculateTime(input: input, inputUnit: inputUnit, outputUnit: outputUnit))
        } header: {
            Text("Output")
                .padding(.leading, -20)
        }
    }
    
    // MARK: - FUNCTIONS
    func calculateTime(input: Double, inputUnit: TimeUnit, outputUnit: TimeUnit) -> String {
        var timeInSeconds: Double
        var output: Double
        
        switch inputUnit {
        case .seconds:
            timeInSeconds = input
        case .minutes:
            timeInSeconds = input * 60
        case .hours:
            timeInSeconds = input * 60 * 60
        case .days:
            timeInSeconds = input * 60 * 60 * 24
        }
        
        switch outputUnit {
        case .seconds:
            output = timeInSeconds
        case .minutes:
            output = timeInSeconds / 60
        case .hours:
            output = timeInSeconds / 60 / 60
        case .days:
            output = timeInSeconds / 60 / 60 / 24
        }
        
        return String(format: "%.2f", output)
    }
}

// MARK: - LENGTH VIEW
struct LengthView: View {
    // MARK: - WRAPPED PROPERTIES
    @State private var input: Double = 0
    @State private var inputUnit: LengthUnit = .feet
    @State private var outputUnit: LengthUnit = .feet
    
    
    // MARK: - PROPERTIES
    var units = LengthUnit.allCases.map { $0 }
    
    // MARK: - VIEWS
    var body: some View {
        Section {
            Picker("Input", selection: $inputUnit) {
                ForEach(units, id:\.self) { Text($0.rawValue) }
            }
            
            TextField("Input", value: $input, format: .number)
        } header: {
            Text("Length")
                .padding(.leading, -20)
        }
        
        Section {
            Picker("Output", selection: $outputUnit) {
                ForEach(units, id: \.self) { Text($0.rawValue) }
            }
            Text(calculateLength(input: input, inputUnit: inputUnit, outputUnit: outputUnit))
            
        } header: {
            Text("Length")
                .padding(.leading, -20)
        }
    }

    // MARK: - FUNCTIONS
    func calculateLength(input: Double, inputUnit: LengthUnit, outputUnit: LengthUnit) -> String {
        var inputInFeet: Double
        var output: Double
        
        // get input in millimeters
        switch inputUnit {
        case .feet:
            inputInFeet = input
        case .yards:
            inputInFeet = input * 3
        case .miles:
            inputInFeet = input * 5280
        case .meters:
            inputInFeet = input * 3.28084
        case .kilometers:
            inputInFeet = input * 3280.84
        }
        
        switch outputUnit {
        case .feet:
            output = inputInFeet
        case .yards:
            output = inputInFeet / 3
        case .miles:
            output = inputInFeet / 5280
        case .meters:
            output = inputInFeet / 3.28084
        case .kilometers:
            output = inputInFeet / 3280.84
        }
        return String(format: "%.2f", output)
    }
}


// MARK: - TEMPERATURE VIEW
struct TemperatureView: View {
    // MARK: - WRAPPED PROPERTIES
    @State private var input = 0
    @FocusState private var inputIsFocused: Bool
    @State private var conversionUnit = "Fahrenheit"
    
    // MARK: - PROPERTIES
    var units = ["Fahrenheit", "Celsius"]
    var inputSymbol: String {
        return conversionUnit == "Fahrenheit" ? "℃" : "℉"
    }
    var outputSymbol: String {
        return conversionUnit != "Fahrenheit" ? "℃" : "℉"
    }
    var output: String {
        if conversionUnit == "Fahrenheit" {
            return String((input * 9/5) + 32)
        } else {
            return String((input - 32) * 5 / 9)
        }
    }
    
    // MARK: - VIEWS
    var body: some View {
        Section {
            TextField("Input", value: $input, format: .number)
                .keyboardType(.decimalPad)
                .focused($inputIsFocused)
        } header: {
            Text("Input Temperature \(inputSymbol)")
                .padding(.leading, -20)
        }
        
        Section {
            Text("\(output)\(outputSymbol)")
            Picker("Input Unit", selection: $conversionUnit) {
                ForEach(units, id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
            
        } header: {
            Text("Output")
                .padding(.leading, -20)
        }
    }
}

// MARK: - ENUMS
enum Unit: String, CaseIterable {
    case temperature = "Temperature"
    case time = "Time"
    case volume = "Volume"
    case length = "Length"
}

enum VolumeUnit: String, CaseIterable {
    case milliliters = "Milliliters"
    case liters = "Liters"
    case cups = "Cups"
    case pints = "Pints"
    case gallons = "Gallons"
}

enum TimeUnit: String, CaseIterable {
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
}

enum LengthUnit: String, CaseIterable {
    case feet = "Feet"
    case yards = "Yards"
    case miles = "Miles"
    case meters = "Meters"
    case kilometers = "Kilometers"
}


// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
