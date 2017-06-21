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
let customer = FTChatMessageUserModel.init(id: "2", name: "LiuFengting", icon_url: "pet2.jpg", extra_data: nil, isSelf: true)



class ChatTableViewController: FTChatMessageTableViewController, FTChatMessageRecorderViewDelegate{
  var quotes: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    messageRecordView.recorderDelegate = self
    chatMessageDataArray = self.loadDefaultMessages()
    
    self.view.backgroundColor = UIColor.white
    
    readTxt()
  }
  
  override func findAReply(inMessage: FTChatMessageModel) -> FTChatMessageModel {
    let randomIndex = Int(arc4random_uniform(UInt32(quotes.count)))
    let text = quotes[randomIndex]
    let reply = FTChatMessageModel(data: text, time: "x", from: replySender, type: .text)
    return reply
  }
  
  func readTxt() {
    if let path = Bundle.main.path(forResource: "quotes", ofType: "txt") {
      do {
        let data = try String(contentsOfFile: path, encoding: .utf8)
        let array = data.components(separatedBy: .newlines)
        
        for one in array {
          if !one.isEmpty {
            quotes.append(one)
          }
        }
      } catch {
        print(error)
      }
    }
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
