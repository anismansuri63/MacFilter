//
//  PhishingFilter.swift
//  PhishingFilterSDK
//
//  Created by Anis Mansuri on 19/02/22.
//

import Foundation
import NetworkExtension

public class PhishingFilter: NSObject {
    public static let shared: PhishingFilter = PhishingFilter()

    override public init() {
        super.init()
    }

    /// returns `NEFilterManager.shared().isEnabled`
    public var isEnabled: Bool {
        return NEFilterManager.shared().isEnabled
    }

    /// load data and returns `NEFilterManager.shared().isEnabled`
    public func getFilterStatus(completionHandler: @escaping BoolHandler) {
        loadConfig { [weak self] _ in
            guard let strongSelf = self else { return }
            completionHandler(strongSelf.isEnabled)
        }
    }

    public func enable(allowBrowser: Bool, allowSocket: Bool, completionHandler: @escaping ErrorHandler) {
        if isEnabled {
            completionHandler(nil)
            return
        }
        loadConfig { error in
            if let err = error {
                NSLog("Error loadFromPreferences", "\(err)")
            }
            if NEFilterManager.shared().providerConfiguration == nil {
                let newConfiguration = NEFilterProviderConfiguration()
                //            newConfiguration.username = "Sift"
                //            newConfiguration.organization = "Sift App"
                newConfiguration.filterSockets = allowSocket
                newConfiguration.filterPackets = allowSocket
                NEFilterManager.shared().providerConfiguration = newConfiguration
            }
            NEFilterManager.shared().isEnabled = true
            NEFilterManager.shared().saveToPreferences { error in
                if let err = error {
                    NSLog("Error Enabling Filter", "\(err)")
                }
                completionHandler(error)
            }
        }
    }

    public func disable(completionHandler: @escaping ErrorHandler) {
        NEFilterManager.shared().isEnabled = false
        NEFilterManager.shared().saveToPreferences { error in
            if let err = error {
                NSLog("Error Disabling Filter", "\(err)")
            }
            completionHandler(error)
        }
    }

    public func loadConfig(completionHandler: ErrorHandler? = nil) {
        NEFilterManager.shared().loadFromPreferences { error in
            completionHandler?(error)
        }
    }
}
