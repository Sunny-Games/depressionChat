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

class ChatTableViewController: FTChatMessageTableViewController, FTChatMessageRecorderViewDelegate{
  
  let sender1 = FTChatMessageUserModel.init(id: "1", name: "Someone", icon_url: "http://ww3.sinaimg.cn/mw600/6cca1403jw1f3lrknzxczj20gj0g0t96.jpg", extra_data: nil, isSelf: false)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.setRightBarButton(UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.addNewIncomingMessage)), animated: true)
    
    
    messageRecordView.recorderDelegate = self
    chatMessageDataArray = self.loadDefaultMessages()
    
    self.view.backgroundColor = UIColor.white
  }
  
  //MARK: - addNewIncomingMessage
  
  func addNewIncomingMessage() {
    
    let message8 = FTChatMessageModel(data: "New Message added, try something else.", time: "4.12 22:42", from: sender1, type: .text)
    self.addNewMessage(message8)
    
  }
  
  func loadDefaultMessages() -> [FTChatMessageModel] {
    
    let message1 = FTChatMessageModel(data: "最近有点无聊，抽点时间写了这个聊天的UI框架。", time: "4.12 21:09:50", from: sender1, type: .text)
    let message2 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:51", from: sender1, type: .video)
    let message3 = FTChatMessageImageModel(data: "http://ww2.sinaimg.cn/mw600/6aa09e8fgw1f8iquoznw2j20dw0bv0uk.jpg", time: "4.12 21:09:52", from: sender1, type: .image)
    message3.imageUrl = "http://ww2.sinaimg.cn/mw600/6aa09e8fgw1f8iquoznw2j20dw0bv0uk.jpg"
    
    
    let message8 = FTChatMessageImageModel(data: "http://wx3.sinaimg.cn/mw600/9e745efdly1fbmfs45minj20tg0xcq6v.jpg", time: "4.12 21:09:56", from: sender1, type: .image)
    message8.imageUrl = "http://wx3.sinaimg.cn/mw600/9e745efdly1fbmfs45minj20tg0xcq6v.jpg"
    
    
    let message7 = FTChatMessageModel(data: "哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈", time: "4.12 21:09:55", from: sender1, type: .text)
    
    
    let array = [message1,message2,message3, message8,message7]
    
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
    
    let message2 = FTChatMessageModel(data: "", time: "4.12 21:09:51", from: sender2, type: .audio)
    
    self.addNewMessage(message2)
    
  }
  
  
}
