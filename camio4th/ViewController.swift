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
    var url_str = "https://js-bk1cfm.stackblitz.io/"
    let fn_url = "url.txt"
    var txtFields = [UITextField]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the WKWebView
        webView = WKWebView(frame: self.view.bounds)
        
        // Set the allowsDirectInteraction trait
        webView.accessibilityTraits.insert(UIAccessibilityTraits.allowsDirectInteraction)
        
        // Add the WKWebView to the view hierarchy
        self.view.addSubview(webView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            showImportTextDialog()
        }

        func showImportTextDialog() {
            let alertController = UIAlertController(title: "Import Web Page URL", message: "", preferredStyle: .alert)

            // Add a UITextField to the alert
            alertController.addTextField { (textField) in
//                textField.placeholder = "Enter text here"
                let txt = self.read_url()
                if txt.count > 3{
                    textField.text = txt
                } else {
                    textField.text = "https://js-bk1cfm.stackblitz.io/"
                }
            }

            // Add a cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)

            // Add a confirm action
            let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
                if let textField = alertController.textFields?.first, let text = textField.text {
                    if let url = URL(string: text) {
                        self.webView.load(URLRequest(url: url))
                        self.writeTo(fn:self.fn_url,  dat:text)
                    }
                }
            }
            alertController.addAction(confirmAction)

            // Present the alert
            present(alertController, animated: true, completion: nil)
        }

    func read_url() -> String{
        let dat = readFr(fn_url)
        if dat.count > 0{
            url_str = dat
        }
        return dat
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

extension UIViewController{
    func writeTo(fn:String,  dat:String){
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fn)
            //writing
            do {
                try dat.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
    }
    
    func readFr(_ fn:String) -> String{
        var text = ""
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fn)
            do {
                text = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {
                return ""
            }
        }
        return text
    }
}
