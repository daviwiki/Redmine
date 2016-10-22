//
//  AnimatedTextView.swift
//  Redmine
//
//  Created by David Martinez on 20/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class SignUpAnimatedTextView : UIView {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var textField : UITextField!
    
    private weak var viewTapGesture : UITapGestureRecognizer?
    
    // MARK: Lifecicle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerGestures()
    }
    
    deinit {
        unregisterGestures()
    }
    
    // MARK: Services
    func getTextField () -> UITextField {
        return textField
    }
    
    func getTitleLabel () -> UILabel {
        return titleLabel
    }
    
    // MARK: Animations
    private func animateLabelTransition () {
        let duration = 0.2
        let timing = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: timing)
        
        animator.addAnimations { [unowned self] in
            
            let scaleFactor : CGFloat = 0.65
            let futureHeight = self.titleLabel.frame.height * scaleFactor
            let shiftX = ((1.0 - scaleFactor) * self.titleLabel.frame.width) / 2.0
            
            let marginTopToSuperview : CGFloat = 6.0
            let shiftY = self.titleLabel.center.y - futureHeight / 2.0 - marginTopToSuperview
            
            let translation = CGAffineTransform(translationX: -shiftX, y: -shiftY)
            let scale = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            let combined = scale.concatenating(translation)
            self.titleLabel.transform = combined
        }
        
        animator.addCompletion { [unowned self] (position : UIViewAnimatingPosition) in
            self.textField.isHidden = false
            self.textField.becomeFirstResponder()
            self.unregisterGestures()
        }
        
        animator.startAnimation()
    }
    
    // MARK: Actions
    @objc private func actionOnViewClick (_ sender : AnyObject?) {
        animateLabelTransition()
    }
    
    // MARK: Internal (Configure View)
    private func registerGestures () {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionOnViewClick(_:)))
        viewTapGesture = tapGesture
        addGestureRecognizer(tapGesture)
    }
    
    private func unregisterGestures () {
        guard let gesture = viewTapGesture else { return }
        removeGestureRecognizer(gesture)
    }
}
