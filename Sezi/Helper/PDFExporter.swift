//
//  PDFExporter.swift
//  Sezi
//
//  Created by Yimei Winata on 15/09/26.
//

import Foundation
import SwiftUI

enum PDFExporter {
    static func export(palette: ColorPalette, pairing: FontPairing) {
        let content = PDFBentoView(palette: palette, pairing: pairing)
        
        let renderer = ImageRenderer(content: content)
        
        let pageSize = CGSize(width: 842, height: 595)
        
        let url = URL.documentsDirectory.appending(path: "sezi-design-system.pdf")
        
        renderer.render { _, context in
            var box = CGRect(origin: .zero, size: pageSize)
            
            guard let pdf = CGContext(url as CFURL, mediaBox: &box, nil) else {
                return
            }
            
            pdf.beginPDFPage(nil)
            context(pdf)
            pdf.endPDFPage()
            pdf.closePDF()
        }
        presentShareSheet(url: url)
    }
    
    private static func presentShareSheet(url: URL) {
        guard let windowScene = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }),
              let rootViewController = windowScene.windows
            .first(where: { $0.isKeyWindow })?
            .rootViewController
        else {
            return
        }
        
        let shareController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        var presenter = rootViewController
        
        while let presented = presenter.presentedViewController {
            presenter = presented
        }
        
        presenter.present(shareController, animated: true)
    }
}
