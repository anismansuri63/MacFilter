//
//  ViewController.swift
//  Mac test 1
//
//  Created by Anis Mansuri on 11/03/22.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    @IBOutlet var connectButton, openButton: NSButton!
    @IBOutlet var viewContainer: NSView!
    var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        connectButton.action = #selector(ViewController.go)
        openButton.action = #selector(ViewController.open)
    }
    @objc func open() {
        if let url = URL(string: "http://www.google.com/") {
        //http://www.internetbadguys.com/
        //http://www.exampleadultsite.com/
            webview = WKWebView(frame: viewContainer.bounds)
            
            viewContainer.addSubview(webview)
            webview.load(URLRequest(url: url))
        }
    }
    @objc func go() {
        if connectButton.title == "Connect" {
            PhishingFilter.shared.enable(allowBrowser: true, allowSocket: true) { error in
                if error == nil {
                    self.connectButton.title = "Connected"
                }
                print(error)
            }
        } else {
            PhishingFilter.shared.disable { error in
                self.connectButton.title = "Connect"
            }
        }
     }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

