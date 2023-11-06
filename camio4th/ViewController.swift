//
//  ViewController.swift
//  WebApp
//
//  Created by Huiying Shen on 6/28/23.
//

import UIKit
import WebKit


class ViewController: UIViewController {
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the WKWebView
        webView = WKWebView(frame: self.view.bounds)
        
        // Set the allowsDirectInteraction trait
        webView.accessibilityTraits.insert(UIAccessibilityTraits.allowsDirectInteraction)
        
        // Add the WKWebView to the view hierarchy
        self.view.addSubview(webView)
        if let url = URL(string: "https://js-bk1cfm.stackblitz.io/") {
            self.webView.load(URLRequest(url: url))
        }
    }
}

extension WKWebView{
    override public var isAccessibilityElement: Bool {
        get {
            return true
        }
        set {
            super.isAccessibilityElement = newValue
        }
    }

    override public var accessibilityLabel: String? {
        get {
            return "Custom drawing canvas. Double tap to interact directly."
        }
        set {
            super.accessibilityLabel = newValue
        }
    }
}
