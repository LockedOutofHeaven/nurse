//
//  NurseApp.swift
//  

import Foundation
import Combine

@available(OSX 10.15, *)
struct NurseApp {
    
    static func main() {
        
        var cancellable = Set<AnyCancellable>()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        MetaWeather.location(by: "san").sink { locations in
            print("\n=== Locations ===")
            locations.forEach { location in
                print(locationString(location: location))
            }
            print("=== Total: \(locations.count) ===\n")
            semaphore.signal()
        }.store(in: &cancellable)
        
        semaphore.wait()
    }
}

func locationString(location: Location) -> String {
    return """
            Title: \(location.title)
            Location Type: \(location.locationType)
            Lattlong: \(location.lattLong)
            Woeid: \(location.woeid)
            Distance: \(location.distance ?? 0)
            """
}
