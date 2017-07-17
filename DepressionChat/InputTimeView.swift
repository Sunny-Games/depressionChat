//
//  InputTimeView.swift
//  LoseWeightWallpaper
//
//  Created by Qing Jiao on 11/6/17.
//  Copyright © 2017 Qing Jiao. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class InputTimeView: UIView {
  private let okCallback: ((String) -> Void)
  private let inputTF = UITextField()
  
  init(labelText: String, callback: @escaping ((String) -> Void)) {
    okCallback = callback
    super.init(frame: CGRect.zero)
    
    backgroundColor = UIColor.black.withAlphaComponent(0.9)
    layer.cornerRadius = 8
    
    let infoLabel = UILabel()
    addSubview(infoLabel)
    infoLabel.text = labelText
    infoLabel.font = UIFont.systemFont(ofSize: 22)
    infoLabel.textColor = .white
    infoLabel.snp.makeConstraints { make in
      make.centerX.equalTo(self)
      make.top.equalTo(self).offset(25)
    }
    
    addSubview(inputTF)
    inputTF.layer.borderWidth = 1
    inputTF.textAlignment = .center
    inputTF.layer.borderColor = UIColor.white.cgColor
    inputTF.textColor = .white
    inputTF.snp.makeConstraints { make in
      make.centerX.equalTo(self)
      make.top.equalTo(infoLabel.snp.bottom).offset(20)
      make.width.equalTo(200)
      make.height.equalTo(35)
    }
    
    let okBtn = UIButton()
    addSubview(okBtn)
    
    okBtn.layer.borderColor = UIColor.white.cgColor
    okBtn.setTitle("OK", for: .normal)
    okBtn.setTitleColor(.white, for: .normal)
    okBtn.snp.makeConstraints { make in
      make.centerX.equalTo(self)
      make.top.equalTo(inputTF.snp.bottom).offset(20)
      make.width.equalTo(100)
      make.height.equalTo(25)
      make.bottom.equalTo(self).offset(-30)
    }
    
    _ = okBtn.rx.tap.subscribe(onNext: { [unowned self] _ in
      self.hide()
      let text = self.inputTF.text
      if text != nil {
        self.okCallback(text!)
      }
    })
  }
  
  func show() {
    self.alpha = 0
    UIView.animate(withDuration: 0.3, animations: {
      self.alpha = 1
    }, completion: { _ in
      self.inputTF.becomeFirstResponder()
    })
  }
  
  func hide() {
    self.inputTF.resignFirstResponder()
    UIView.animate(withDuration: 0.3, animations: {
      self.alpha = 0
    }, completion: { _ in
      self.removeFromSuperview()
    })
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
