//
//  FilterDataProvider.swift
//  DataFilter
//
//  Created by Apple on 28/03/22.
//

import NetworkExtension
import os.log
class FilterDataProvider: NEFilterDataProvider {
    override func startFilter(completionHandler: @escaping (Error?) -> Void) {
        let exampleRule = NENetworkRule(
            remoteNetwork: NWHostEndpoint(hostname: "https://www.vimeo.com/", port: "0"),
            remotePrefix: 0,
            localNetwork: nil,
            localPrefix: 0,
            protocol: .TCP,
            direction: .any
        )
        let filterRule = NEFilterRule(networkRule: exampleRule, action: .drop)

        let filterSettings = NEFilterSettings(rules: [filterRule], defaultAction: .drop)
        apply(filterSettings) { error in
            if let applyError = error {
                os_log("Failed to apply filter settings: %@", applyError.localizedDescription)
            }
            completionHandler(error)
        }
    }
    override func stopFilter(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    override func handleNewFlow(_ flow: NEFilterFlow) -> NEFilterNewFlowVerdict {
        return .drop()
    }
}
