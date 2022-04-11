//
//  FilterPacketProvider.swift
//  DataControl
//
//  Created by Apple on 28/03/22.
//

import NetworkExtension

class FilterPacketProvider: NEFilterPacketProvider {
    
    override func startFilter(completionHandler: @escaping (Error?) -> Void) {
		packetHandler = { (context, interface, direction, packetBytes, packetLength) in
            return .drop
		}
		completionHandler(nil)
    }
    
    override func stopFilter(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
