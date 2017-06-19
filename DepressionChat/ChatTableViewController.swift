//
//  ChatTableViewController.swift
//  FTChatMessage
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit
import FTIndicator
import IQKeyboardManager

let replySender = FTChatMessageUserModel.init(id: "1", name: "Someone", icon_url: "pet5.jpg", extra_data: nil, isSelf: false)
let customer = FTChatMessageUserModel.init(id: "2", name: "LiuFengting", icon_url: "http://ww3.sinaimg.cn/mw600/9d319f9agw1f3k8e4pixfj20u00u0ac6.jpg", extra_data: nil, isSelf: true)


class ChatTableViewController: FTChatMessageTableViewController, FTChatMessageRecorderViewDelegate{
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
    messageRecordView.recorderDelegate = self
    chatMessageDataArray = self.loadDefaultMessages()
    
    self.view.backgroundColor = UIColor.white
  }
  
 
  func loadDefaultMessages() -> [FTChatMessageModel] {
    
 
    let message3 = FTChatMessageImageModel(data: "pet1.jpg", time: "4.12 21:09:52", from: replySender, type: .image)
    
 
    
    let array = [message3]
    
    return array;
    
  }
  
  //MARK: - FTChatMessageRecorderViewDelegate
  
  func ft_chatMessageRecordViewDidStartRecording(){
    print("Start recording...")
    FTIndicator.showProgressWithmessage("Recording...")
  }
  func ft_chatMessageRecordViewDidCancelRecording(){
    print("Recording canceled.")
    FTIndicator.dismissProgress()
  }
  func ft_chatMessageRecordViewDidStopRecording(_ duriation: TimeInterval, file: Data?){
    print("Recording ended!")
    FTIndicator.showSuccess(withMessage: "Record done.")
    
    let message2 = FTChatMessageModel(data: "", time: "4.12 21:09:51", from: customer, type: .audio)
    
    self.customerAddNewMessage(message2)
    
  }
  
  
  
}
