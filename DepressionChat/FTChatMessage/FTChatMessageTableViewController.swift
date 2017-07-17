//
//  FTChatMessageTableViewController.swift
//  FTChatMessage
//
//  Created by liufengting on 16/2/28.
//  Copyright © 2016年 liufengting <https://github.com/liufengting>. All rights reserved.
//

import UIKit


class FTChatMessageTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, FTChatMessageInputViewDelegate, FTChatMessageHeaderDelegate {
  
  var chatMessageDataArray : [FTChatMessageModel] = [] {
    didSet {
      self.origanizeAndReload()
    }
  }
  open var messageArray : [[FTChatMessageModel]] = []
  var delegete : FTChatMessageDelegate?
  var dataSource : FTChatMessageDataSource?
  var messageInputMode : FTChatMessageInputMode = FTChatMessageInputMode.none
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(messageTableView)
    
    self.view.addSubview(messageInputView)
    
    self.view.addSubview(messageRecordView)
    
    DispatchQueue.main.asyncAfter( deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
      self.scrollToBottom(false)
    }
    
    
  }
  
  lazy var messageTableView : UITableView! = {
    let tableView = UITableView(frame: CGRect(x: 0, y: 64, width: FTScreenWidth, height: FTScreenHeight - 64), style: .plain)
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, FTDefaultInputViewHeight, 0)
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.backgroundColor = DesignColor.white

    let footer = UIView(frame: CGRect( x: 0, y: 0, width: FTScreenWidth, height: FTDefaultInputViewHeight))
    tableView.tableFooterView = footer
    
    return tableView
  }()
  
  lazy var messageInputView : FTChatMessageInputView! = {
    let inputView : FTChatMessageInputView! = Bundle.main.loadNibNamed("FTChatMessageInputView", owner: nil, options: nil)?[0] as! FTChatMessageInputView
    inputView.frame = CGRect(x: 0, y: FTScreenHeight-FTDefaultInputViewHeight, width: FTScreenWidth, height: FTDefaultInputViewHeight)
    inputView.inputDelegate = self
    return inputView
  }()
  
  lazy var messageRecordView : FTChatMessageRecorderView! = {
    let recordView : FTChatMessageRecorderView! = Bundle.main.loadNibNamed("FTChatMessageRecorderView", owner: nil, options: nil)?[0] as! FTChatMessageRecorderView
    recordView.frame = CGRect(x: 0, y: FTScreenHeight, width: FTScreenWidth, height: FTDefaultAccessoryViewHeight)
    return recordView
  }()
  
  func repositionEverything() {
    self.messageTableView.frame = CGRect(x: 0, y: 64, width: FTScreenWidth, height: FTScreenHeight - 64)
    self.messageInputView.frame = CGRect(x: 0, y: FTScreenHeight-FTDefaultInputViewHeight, width: FTScreenWidth, height: FTDefaultInputViewHeight)
    self.messageRecordView.frame = CGRect(x: 0, y: FTScreenHeight, width: FTScreenWidth, height: FTDefaultAccessoryViewHeight)
    self.messageTableView.reloadData()
  }
  
  
  func addNewMessage(_ message : FTChatMessageModel) {
    chatMessageDataArray.append(message);
    self.origanizeAndReload()
    self.scrollToBottom(true)
  }
  
  internal func customerAddNewMessage(_ message : FTChatMessageModel) {
    addNewMessage(message)
    
    let reply2 = findImageReply(inMessage: message)
    addNewMessage(reply2)
    
    let reply1 = findMsgReply(inMessage: message)
    addNewMessage(reply1)
  }
  
  func findMsgReply(inMessage: FTChatMessageModel) -> FTChatMessageModel {
    return FTChatMessageModel()
  }
  
  
  func findImageReply(inMessage: FTChatMessageModel) -> FTChatMessageModel {
    return FTChatMessageModel()
  }
  
  func origanizeAndReload() {
    var nastyArray : [[FTChatMessageModel]] = []
    var tempArray : [FTChatMessageModel] = []
    var tempId = ""
    for i in 0...chatMessageDataArray.count-1 {
      let message = chatMessageDataArray[i]
      if message.messageSender.senderId == tempId {
        tempArray.append(message)
      }else{
        tempId = message.messageSender.senderId;
        if tempArray.count > 0 {
          nastyArray.append(tempArray)
        }
        tempArray.removeAll()
        tempArray.append(message)
      }
      if i == chatMessageDataArray.count - 1 {
        if tempArray.count > 0 {
          nastyArray.append(tempArray)
        }
      }
    }
    
    self.messageArray = nastyArray
    self.messageTableView.reloadData()
  }
  
  
  
  
}
