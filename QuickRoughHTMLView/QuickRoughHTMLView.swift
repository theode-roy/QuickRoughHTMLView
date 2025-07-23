import Foundation
import SwiftUI
import WebKit

public struct QuickRoughHTMLViewContainer: View {
    @Binding private var htmlFilename: String
    
    public init(htmlFilename: Binding<String>) {
        self._htmlFilename = htmlFilename
    }
    
    public init(htmlFilename: String) {
        self._htmlFilename = .constant(htmlFilename)
    }
    
    public var body: some View {
        #if os(iOS)
        QuickRoughHTMLWebView_iOS(htmlFilename: htmlFilename)
            .ignoresSafeArea()
        #elseif os(macOS)
        QuickRoughHTMLWebView_macOS(htmlFilename: htmlFilename)
        #else
        Text("Platform not supported.")
        #endif
    }
}

#if os(iOS)
private struct QuickRoughHTMLWebView_iOS: UIViewRepresentable {
    let htmlFilename: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        // Attempt to load HTML file from Bundle.main
        if let url = Bundle.main.url(forResource: htmlFilename, withExtension: "html"),
           let data = try? Data(contentsOf: url),
           let htmlString = String(data: data, encoding: .utf8) {
            webView.loadHTMLString(htmlString, baseURL: url.deletingLastPathComponent())
        } else {
            let errorMessage = "<html><body><h2 style='color:red;'>File not found: \(htmlFilename).html</h2></body></html>"
            print("QuickRoughHTMLWebView_iOS: Unable to find or load HTML file named '\(htmlFilename).html' in Bundle.main.")
            webView.loadHTMLString(errorMessage, baseURL: nil)
        }
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
#endif

#if os(macOS)
private struct QuickRoughHTMLWebView_macOS: NSViewRepresentable {
    let htmlFilename: String

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        // Attempt to load HTML file from Bundle.main
        if let url = Bundle.main.url(forResource: htmlFilename, withExtension: "html"),
           let data = try? Data(contentsOf: url),
           let htmlString = String(data: data, encoding: .utf8) {
            webView.loadHTMLString(htmlString, baseURL: url.deletingLastPathComponent())
        } else {
            let errorMessage = "<html><body><h2 style='color:red;'>File not found: \(htmlFilename).html</h2></body></html>"
            print("QuickRoughHTMLWebView_macOS: Unable to find or load HTML file named '\(htmlFilename).html' in Bundle.main.")
            webView.loadHTMLString(errorMessage, baseURL: nil)
        }
        
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {}
}
#endif
