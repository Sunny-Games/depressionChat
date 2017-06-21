//
//  FTChatMessageBubbleAudioItem.swift
//  FTChatMessage
//
//  Created by liufengting on 16/5/7.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

class FTChatMessageBubbleAudioItem: FTChatMessageBubbleItem {
    
    var playImageView : UIImageView!
    var mediaInfoLabel : UILabel!
    var bubleFrame = CGRect.zero
		
    convenience init(frame: CGRect, aMessage : FTChatMessageModel, for indexPath: IndexPath) {
        self.init(frame:frame)
        self.backgroundColor = UIColor.clear
        message = aMessage
        let messageBubblePath = self.getAudioBubblePath(frame.size, isUserSelf: aMessage.isUserSelf)
        
        messageBubbleLayer.path = messageBubblePath.cgPath
        messageBubbleLayer.fillColor = aMessage.messageSender.isUserSelf ? FTDefaultOutgoingColor.cgColor : FTDefaultIncomingColor.cgColor
        self.layer.addSublayer(messageBubbleLayer)
        
        let mediaImageRect = self.getPlayImageViewFrame(aMessage.isUserSelf)
        playImageView = UIImageView(frame : mediaImageRect)
        playImageView.backgroundColor = UIColor.clear
        playImageView.tintColor = aMessage.messageSender.isUserSelf ? UIColor.white : UIColor.black
        if let image = UIImage(named: "Media_Play") {
            playImageView.image = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        }
        self.addSubview(playImageView)
        
        let mediaInfoLabelRect = self.getMediaInfoLabelFrame(aMessage.isUserSelf)
        mediaInfoLabel = UILabel(frame : mediaInfoLabelRect)
        mediaInfoLabel.backgroundColor = UIColor.clear
        mediaInfoLabel.font = FTDefaultFontSize
        mediaInfoLabel.textColor = aMessage.messageSender.isUserSelf ? UIColor.white : UIColor.black
        mediaInfoLabel.textAlignment = aMessage.isUserSelf ? NSTextAlignment.left : NSTextAlignment.right
        mediaInfoLabel.text = "1′ 22″"
        self.addSubview(mediaInfoLabel)
        
    }
    
    fileprivate func getAudioBubblePath(_ size:CGSize , isUserSelf : Bool) -> UIBezierPath {
        bubleFrame = CGRect(x: !isUserSelf ? 0 : size.width - 120, y: 0, width: 120 , height: size.height)
        let path = UIBezierPath.init(roundedRect: bubleFrame, cornerRadius:  size.height/2)
        return path;
    }
    
    fileprivate func getPlayImageViewFrame(_ isUserSelf : Bool) -> CGRect {
        let margin = (FTDefaultMessageBubbleAudioHeight - FTDefaultMessageBubbleAudioIconHeight)/2
        return
          CGRect(x: bubleFrame.origin.x + margin, y: margin, width: FTDefaultMessageBubbleAudioIconHeight, height: FTDefaultMessageBubbleAudioIconHeight)
        
    }
    fileprivate func getMediaInfoLabelFrame(_ isUserSelf : Bool) -> CGRect {
        let margin = (FTDefaultMessageBubbleAudioHeight - FTDefaultMessageBubbleAudioIconHeight)/2
        return isUserSelf ?
            CGRect(x: FTDefaultMessageBubbleAudioHeight, y: margin, width: self.frame.size.width - FTDefaultMessageBubbleAudioHeight - FTDefaultMessageBubbleAngleWidth - margin, height: FTDefaultMessageBubbleAudioIconHeight) :
            CGRect( x: FTDefaultMessageBubbleAngleWidth + margin, y: margin, width: self.frame.size.width - FTDefaultMessageBubbleAudioHeight - FTDefaultMessageBubbleAngleWidth - margin, height: FTDefaultMessageBubbleAudioIconHeight)
    }
    
}
