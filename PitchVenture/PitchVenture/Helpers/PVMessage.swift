//
//  BodyFixersMessage.swift
//  BodyFixers
//
//

import UIKit
import SwiftMessages

class PVMessage: NSObject {
    class func showBannerWith(_ title:String?, body: String?, theme: Theme) {
        let view: MessageView
        view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: title, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "", buttonTapHandler: { _ in SwiftMessages.hide() })
        view.titleLabel?.font = FontManager.montserratFont(fontName: .semiBold, size: 17)
        view.bodyLabel?.font = FontManager.montserratFont(fontName: .semiBold, size: 16)
        let iconStyle: IconStyle
        iconStyle = .default
        view.configureTheme(theme, iconStyle: iconStyle)
        view.configureDropShadow()
        view.button?.isHidden = true
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.duration = .seconds(seconds: 3)
        config.interactiveHide = true
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: view)
    }
    
    class func showBannerWith(_ title:String?, body: String?, theme: Theme, duration: Int) {
        let view: MessageView
        view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: title, body: body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "", buttonTapHandler: { _ in SwiftMessages.hide() })
        view.titleLabel?.font = FontManager.montserratFont(fontName: .semiBold, size: 16)
        view.bodyLabel?.font = FontManager.montserratFont(fontName: .semiBold, size: 16)
        let iconStyle: IconStyle
        iconStyle = .default
        view.configureTheme(theme, iconStyle: iconStyle)
        view.configureDropShadow()
        view.button?.isHidden = true
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .bottom
        config.duration = .seconds(seconds: TimeInterval(duration))
        config.interactiveHide = true
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: view)
    }
    
    
    class func showSuccessWithMessage(message: String?) {
        PVMessage.showBannerWith(kSuccess, body: message, theme: .success)
    }
    
    class func showWarningWithMessage(message: String?) {
        PVMessage.showBannerWith(kWarning, body: message, theme: .warning)
    }
    
    class func showErrorWithMessage(message: String?) {
        PVMessage.showBannerWith(kError, body: message, theme: .error)
    }
    
    class func showInfoWithMessage(message: String?) {
        PVMessage.showBannerWith(kInfo, body: message, theme: .info)
    }
}
