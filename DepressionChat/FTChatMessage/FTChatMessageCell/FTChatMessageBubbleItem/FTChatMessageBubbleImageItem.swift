//
//  FTChatMessageBubbleImageItem.swift
//  FTChatMessage
//
//  Created by liufengting on 16/5/7.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

class FTChatMessageBubbleImageItem: FTChatMessageBubbleItem {
  
  convenience init(frame: CGRect, aMessage : FTChatMessageModel, for indexPath: IndexPath) {
    self.init(frame:frame)
    self.backgroundColor = UIColor.clear
    message = aMessage
    
    let messageBubblePath = self.getBubbleShapePathWithSize(frame.size, isUserSelf: aMessage.isUserSelf, for: indexPath)
    
    let maskLayer = CAShapeLayer()
    maskLayer.path = messageBubblePath.cgPath
    maskLayer.frame = self.bounds
    
    let layer = CALayer()
    layer.mask = maskLayer
    layer.frame = self.bounds
    layer.contentsScale = UIScreen.main.scale
    layer.contentsGravity = kCAGravityResizeAspectFill
    layer.backgroundColor = aMessage.messageSender.isUserSelf ? FTDefaultOutgoingColor.cgColor : FTDefaultIncomingColor.cgColor
    self.layer.addSublayer(layer)
    
    if let image = UIImage(named : message.messageText) {
      layer.contents = image.cgImage
    }
    
  }
  
  
  
}
