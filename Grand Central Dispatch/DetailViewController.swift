//
//  DetailViewController.swift
//  Grand Central Dispatch
//
//  Created by Yohannes Wijaya on 10/29/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: [String: String]!
    
    override func loadView() {
        self.webView = WKWebView()
        self.view = self.webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        guard self.detailItem != nil else { return }
        if let body = self.detailItem["body"] {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
            html += "<style> body { font-size: 150%; } </style>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
}

