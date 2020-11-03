//
//  NurseApp.swift
//  

import Foundation
import Combine
import ArgumentParser

@available(OSX 10.15, *)
struct Nurse: ParsableCommand {
    
    static let configuration = CommandConfiguration(abstract: "🏥 Nurse\n  A Toy for learning Swift programming language.")
    
    @Option(name: [.short], help: "Location to search for.")
    var query: String
    
    mutating func run() throws {
        
        var cancellable = Set<AnyCancellable>()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        MetaWeather.location(by: query).sink { locations in

            print("\n=== Locations ===")
            locations.forEach { outputLocation($0) }
            print("=== Total: \(locations.count) ===\n")
            
            semaphore.signal()

        }.store(in: &cancellable)
        
        semaphore.wait()
    }
}

func outputLocation(_ location: Location) {
    print("""
    Title: \(location.title)
    Location Type: \(location.locationType)
    Lattlong: \(location.lattLong)
    Woeid: \(location.woeid)
    Distance: \(location.distance ?? 0)
    """)
}
