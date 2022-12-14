//
//  CircularProgressBar.swift
//  Progress
//
//  Created by NiravPatel on 12/06/19.
//  Copyright © 2019 NiravPatel. All rights reserved.
//

import UIKit


class CircularProgressBar: UIView {
    
    var currentTime:Double = 0
    var previousProgress:Double = 0
    
    //MARK: awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        initialSetup()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        initialSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialSetup() {
        setupView()
        label.text = "0"
        labelPercent.text = "%"
        labelComplete.text = "complete"
    }
    
    
    //MARK: Public
    
    public var lineWidth:CGFloat = 15 {
        didSet{
            foregroundLayer.lineWidth = lineWidth
            backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
        }
    }
    
    public var labelSize: CGFloat = 30 {
        didSet {
            label.font = UIFont.systemFont(ofSize: labelSize)
            label.sizeToFit()
            configLabel()
        }
    }
    
    public var labelPercentSize: CGFloat = 10 {
        didSet {
            labelPercent.font = .InterRegular(ofSize: labelPercentSize)
            labelPercent.sizeToFit()
            configLabelPercent()
        }
    }
    
    public var labelCompleteSize: CGFloat = 10 {
        didSet {
            labelComplete.font = UIFont.systemFont(ofSize: labelCompleteSize)
            labelComplete.sizeToFit()
            configLabelComplete()
        }
    }
    
    public var safePercent: Int = 100 {
        didSet{
            setForegroundLayerColorForSafePercent()
        }
    }
    
    public func setProgress(to progressConstant: Double, withAnimation: Bool) {
        
        var progress: Double {
            get {
                if progressConstant > 1 { return 1 }
                else if progressConstant < 0 { return 0 }
                else { return progressConstant }
            }
        }
        
        foregroundLayer.strokeEnd = CGFloat(progress)
        
        if withAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = previousProgress
            animation.toValue = progress
            animation.duration = 2
            foregroundLayer.add(animation, forKey: "foregroundAnimation")
            
        }
        
        
        previousProgress = progress
        currentTime = 0
        
        DispatchQueue.main.async {
            self.label.text = "\(Int(progress * 100))"
            self.setForegroundLayerColorForSafePercent()
            self.configLabel()
            self.configLabelPercent()
            self.configLabelComplete()
        }
        
    }
    
    
    //MARK: Private
    private var label = UILabel()
    private var labelPercent = UILabel()
    private var labelComplete = UILabel()
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private let pulsatingLayer = CAShapeLayer()
    private var radius: CGFloat {
        get{
            if self.frame.width < self.frame.height { return (self.frame.width - lineWidth)/2 }
            else { return (self.frame.height - lineWidth)/2 }
        }
    }
    
    private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
    private func makeBar(){
        self.layer.sublayers = nil
        drawBackgroundLayer()
        drawForegroundLayer()
    }
    
    private func drawBackgroundLayer(){
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        self.backgroundLayer.path = path.cgPath
        self.backgroundLayer.strokeColor = UIColor.green.withAlphaComponent(0.3).cgColor
        self.backgroundLayer.lineWidth = lineWidth
        self.backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
        
    }
    
    private func drawForegroundLayer(){
        
        let startAngle = (-CGFloat.pi/2)
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        foregroundLayer.lineCap = CAShapeLayerLineCap.round
        foregroundLayer.path = path.cgPath
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeColor = UIColor.green.withAlphaComponent(0.5).cgColor
        foregroundLayer.strokeEnd = 0
        
        self.layer.addSublayer(foregroundLayer)
        
    }
    
    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = text
        label.font = .InterBold(ofSize: labelSize)
        label.sizeToFit()
        label.center = CGPoint(x: pathCenter.x, y: pathCenter.y)
        return label
    }
    
    private func makeLabelPercent(withText text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = text
        label.font = .InterRegular(ofSize: labelPercentSize)
        label.sizeToFit()
        label.center = CGPoint(x: pathCenter.x + (label.frame.size.width/2) + 10, y: pathCenter.y - 15)
        return label
    }
    
    private func makeLabelComplete(withText text: String) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = text
        label.font = UIFont.systemFont(ofSize: labelCompleteSize)
        label.sizeToFit()
        label.textColor = UIColor.lightGray
        label.center = CGPoint(x: pathCenter.x, y: pathCenter.y + (label.frame.size.height/2))
        return label
    }
    
    private func configLabel(){
        label.textColor = .white
        label.sizeToFit()
        label.center = CGPoint(x: pathCenter.x, y: pathCenter.y)
    }
    
    private func configLabelPercent(){
        labelPercent.textColor = .lightGray
        labelPercent.sizeToFit()
        labelPercent.center = CGPoint(x: pathCenter.x + (label.frame.size.width/2) + 4.s, y: pathCenter.y - 5.s)
    }
    
    private func configLabelComplete(){
        labelComplete.textColor = UIColor(red: 36.0/255.0, green: 22.0/255.0, blue: 84.0/255.0, alpha: 1.0)
        labelComplete.sizeToFit()
        labelComplete.center = CGPoint(x: pathCenter.x, y: pathCenter.y + (label.frame.size.height/2))
    }
    
    private func setForegroundLayerColorForSafePercent(){
        
        self.foregroundLayer.strokeColor = UIColor.green.withAlphaComponent(0.5).cgColor
    }
    
    private func setupView() {
        makeBar()
        self.addSubview(label)
        self.addSubview(labelPercent)
        self.addSubview(labelComplete)
    }
    
    
    
    //Layout Sublayers

    private var layoutDone = false
    override func layoutSublayers(of layer: CALayer) {
        if !layoutDone {
            let tempText = label.text
            setupView()
            label.text = tempText
            layoutDone = true
        }
    }
}
