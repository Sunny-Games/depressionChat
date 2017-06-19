//
//  FTChatMessageHeader.swift
//  FTChatMessage
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit

protocol FTChatMessageHeaderDelegate {
  func ft_chatMessageHeaderDidTappedOnIcon(_ messageSenderModel : FTChatMessageUserModel)
}

class FTChatMessageHeader: UILabel {
  
  var iconButton : UIButton!
  var messageSenderModel : FTChatMessageUserModel!
  var headerViewDelegate : FTChatMessageHeaderDelegate?
  
  lazy var messageSenderNameLabel: UILabel! = {
    let label = UILabel(frame: CGRect.zero)
    label.font = FTDefaultTimeLabelFont
    label.textAlignment = .center
    label.textColor = UIColor.lightGray
    return label
  }()
  
  
  
  convenience init(frame: CGRect, senderModel: FTChatMessageUserModel ) {
    self.init(frame : frame)
    
    
    messageSenderModel = senderModel;
    self.setupHeader( senderModel, isSender: senderModel.isUserSelf)
  }
  
  
  
  fileprivate func setupHeader(_ user : FTChatMessageUserModel, isSender: Bool){
    self.backgroundColor = UIColor.clear
    
    let iconRect = isSender ? CGRect(x: self.frame.width-FTDefaultMargin-FTDefaultIconSize, y: FTDefaultMargin, width: FTDefaultIconSize, height: FTDefaultIconSize) : CGRect(x: FTDefaultMargin, y: FTDefaultMargin, width: FTDefaultIconSize, height: FTDefaultIconSize)
    iconButton = UIButton(frame: iconRect)
    iconButton.backgroundColor = isSender ? FTDefaultOutgoingColor : FTDefaultIncomingColor
    iconButton.layer.cornerRadius = FTDefaultIconSize/2;
    iconButton.clipsToBounds = true
    iconButton.isUserInteractionEnabled = true
    iconButton.addTarget(self, action: #selector(self.iconTapped), for: UIControlEvents.touchUpInside)
    self.addSubview(iconButton)
    
    iconButton.imageView?.contentMode = .scaleAspectFill
    if let url = user.senderIconUrl {
      let image = UIImage(named: url)
      iconButton.setImage(image, for: .normal)
    }
    
    
    
    
  }
  
  
  
  
  @objc func iconTapped() {
    if (headerViewDelegate != nil) {
      headerViewDelegate?.ft_chatMessageHeaderDidTappedOnIcon(messageSenderModel)
    }
  }
  
  
  
}
