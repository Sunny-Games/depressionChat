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
import SnapKit

let replySender = FTChatMessageUserModel.init(id: "1", name: "Someone", icon_url: "image35.jpg", extra_data: nil, isSelf: false)
let customer = FTChatMessageUserModel.init(id: "2", name: "LiuFengting", icon_url: "image40.jpg", extra_data: nil, isSelf: true)


class ChatTableViewController: FTChatMessageTableViewController, FTChatMessageRecorderViewDelegate{
  var quotes: [String] = []
  let titleHeartBtn = UIButton()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    buildTitleView()
    
    messageRecordView.recorderDelegate = self
    
    readTxt()
    
    view.backgroundColor = DesignColor.white
  }
  
  func showLoveRain() {
    var beginFrame = titleHeartBtn.frame
    beginFrame.size = CGSize(width: 30, height: 30)
    beginFrame.origin.y = titleHeartBtn.frame.origin.y + 20
    beginFrame.origin.x = view.frame.size.width / 2 - 30 / 2
    
    
    let oneIV = UIImageView()
    oneIV.image = UIImage(named: "RedHeart")
    oneIV.clipsToBounds = true
    view.addSubview(oneIV)

    oneIV.frame = beginFrame

    var tt = oneIV.frame
    tt.origin.y = view.frame.size.height
    UIView.animate(withDuration: 1, animations: {
      oneIV.frame = tt
    }, completion: { _ in
      oneIV.removeFromSuperview()
    })
  }
  
  func showGreeting() {
    let name = DataContainer.shared.name ?? ""
    let message2 = FTChatMessageModel(data: "Dear \(name), how are you today? Quite enjoy listening to you.", time: "x", from: replySender, type: .text)
    
    addNewMessage(message2)
  }
  
  func loadInitMessages() -> [FTChatMessageModel] {
    let message1 = FTChatMessageImageModel(data: "image36.jpg", time: "4.12 21:09:52", from: replySender, type: .image)
    
    let name = DataContainer.shared.name ?? ""
    let message2 = FTChatMessageModel(data: "Dear \(name), how are you? I will be a very good listener, and keep the secret.", time: "x", from: replySender, type: .text)
    
    let array = [message1, message2]
    
    return array;
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    guard DataContainer.shared.name == nil else {
      showGreeting()
      return
    }
    
    let inputView = InputTimeView(labelText: "Dear, how do I call you?", callback: { [unowned self] name in
      DataContainer.shared.name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      self.chatMessageDataArray = self.loadInitMessages()
    })
    
    view.addSubview(inputView)
    inputView.snp.makeConstraints { make in
      make.centerX.equalTo(view)
      make.centerY.equalTo(view).offset(-30)
      make.width.equalTo(view).offset(-20)
    }
    
    inputView.show()
  }
  
  func buildTitleView() {
    let conV = UIView()
    conV.backgroundColor = DesignColor.Red
    view.addSubview(conV)
    conV.snp.makeConstraints { make in
      make.leading.trailing.top.equalTo(view)
      make.height.equalTo(64)
    }
    
    conV.addSubview(titleHeartBtn)
    titleHeartBtn.contentMode = .scaleAspectFit
    titleHeartBtn.setImage(UIImage(named: "heart"), for: .normal)
    titleHeartBtn.snp.makeConstraints { make in
      make.bottom.equalTo(conV).offset(-5)
      make.width.equalTo(47)
      make.height.equalTo(47)
      make.centerX.equalTo(conV)
    }
    
    let menuButton = UIButton()
    menuButton.setImage(UIImage(named: "menu"), for: .normal)
    conV.addSubview(menuButton)
    menuButton.snp.makeConstraints { make in
      make.centerY.equalTo(titleHeartBtn)
      make.leading.equalTo(16)
      make.width.equalTo(30)
      make.height.equalTo(30)
    }
    
    _ = titleHeartBtn.rx.tap.subscribe(onNext: { [unowned self] _ in
      self.showLoveRain()
    })
    
  }
  
  override func findMsgReply(inMessage: FTChatMessageModel) -> FTChatMessageModel {
    let reply: FTChatMessageModel
    let randomIndex = Int(arc4random_uniform(UInt32(quotes.count)))
    let text = quotes[randomIndex]
    reply = FTChatMessageModel(data: text, time: "x", from: replySender, type: .text)
    
    return reply
  }
  
  override func findImageReply(inMessage: FTChatMessageModel) -> FTChatMessageModel {
    let reply: FTChatMessageModel
    let lot = arc4random_uniform(6)
    
    let imageName: String
    if lot <= 1 {
      imageName = "png\(max(1, arc4random_uniform(9))).png"
    } else {
      imageName = "image\(max(1, arc4random_uniform(63))).jpg"
    }
    print(imageName)
    reply = FTChatMessageImageModel(data: imageName, time: "x", from: replySender, type: .image)
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
