//
//  LGButton.swift
//  MedicOnePedsCards
//
//  Created by Lorenzo Greco on 28/05/2017.
//  Copyright © 2017 Lorenzo Greco. All rights reserved.
//
//  Modified by Sam Gehman on April 30, 2018.
//
import UIKit
import QuartzCore


@IBDesignable
public class LGButton: UIControl {
    
    enum TouchAlphaValues : CGFloat {
        case touched = 0.7
        case untouched = 1.0
    }

    let touchDisableRadius : CGFloat = 100.0

    var gradient : CAGradientLayer?
    
    
    fileprivate var rootView : UIView!
    @IBOutlet fileprivate weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet fileprivate weak var mainStackView: UIStackView!
    
    @IBOutlet fileprivate weak var bgContentView: UIView!
    @IBOutlet fileprivate weak var leftImage: UIImageView!
    @IBOutlet fileprivate weak var rightImage: UIImageView!
    
    @IBOutlet fileprivate weak var trailingMainConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var leadingMainConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var bottomMainConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var topMainConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate weak var leftImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var leftImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var rightImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var rightImageWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate weak var loadingStackView: UIStackView!
    @IBOutlet fileprivate weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet fileprivate weak var loadingLabel: UILabel!
    @IBOutlet fileprivate var trailingLoadingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var leadingLoadingConstraint: NSLayoutConstraint!
    
    
    public var isLoading = false {
        didSet {
           showLoadingView()
        }
    }
    
    // MARK: - Inspectable properties
    
    @IBInspectable public var bgColor: UIColor = UIColor.gray {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var showTouchFeedback: Bool = true
    
    @IBInspectable public var gradientStartColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var gradientEndColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var gradientHorizontal: Bool = false {
        didSet{
            if gradient != nil {
                gradient?.removeFromSuperlayer()
                gradient = nil
                setupView()
            }
        }
    }
    
    @IBInspectable public var gradientRotation: CGFloat = 0 {
        didSet{
            if gradient != nil {
                gradient?.removeFromSuperlayer()
                gradient = nil
                setupView()
            }
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var fullyRoundedCorners: Bool = false {
        didSet{
            setupBorderAndCorners()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var titleColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var titleString: String = "" {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var titleFontName: String? {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var titleFontSize: CGFloat = 14.0 {
        didSet{
            setupView()
        }
    }

    @IBInspectable public var subtitleColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }

    @IBInspectable public var subtitleString: String = "" {
        didSet{
            setupView()
        }
    }

    @IBInspectable public var subtitleFontName: String? {
        didSet{
            setupView()
        }
    }

    @IBInspectable public var subtitleFontSize: CGFloat = 14.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var verticalOrientation: Bool = false {
        didSet {
            setupView()
        }
    }

    @IBInspectable public var leftImageSrc: UIImage? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var leftImageWidth: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var leftImageHeight: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var leftImageColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }

    @IBInspectable public var rightImageSrc: UIImage? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightImageWidth: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightImageHeight: CGFloat = 20 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var rightImageColor: UIColor? = nil {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var spacingTitleIcon: CGFloat = 16.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var spacingTop: CGFloat = 8.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var spacingBottom: CGFloat = 8.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var spacingLeading: CGFloat = 16.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var spacingTrailing: CGFloat = 16.0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = CGSize.init(width:0, height:0) {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var shadowOpacity: CGFloat = 1 {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var loadingSpinnerColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var loadingColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var loadingString: String = "" {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var loadingFontName: String? {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable public var loadingFontSize: CGFloat = 14.0 {
        didSet{
            setupView()
        }
    }
    
    // MARK: - Overrides

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setupView()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        setupView()
    }
    
    override public func layoutSubviews() {
        if gradient != nil {
            gradient?.removeFromSuperlayer()
            gradient = nil
            setupGradientBackground()
        }
        setupBorderAndCorners()
    }
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 10, height: 10)
    }
    
    // MARK: - Internal functions

    // Setup the view appearance
    fileprivate func setupView(){
        bgContentView.clipsToBounds = true
        layer.masksToBounds = false
        setIconOrientation()
        setupBackgroundColor()
        setupGradientBackground()
        setupBorderAndCorners()
        setupTitle()
        setupSubtitle()
        setupLeftImage()
        setupRightImage()
        setupSpacings()
        setupShadow()
        setupLoadingView()
    }
    
    fileprivate func setIconOrientation() {
        if verticalOrientation {
            mainStackView.axis = .vertical
        }else{
            mainStackView.axis = .horizontal
        }
    }
    
    fileprivate func setupBackgroundColor() {
        bgContentView.backgroundColor = bgColor
    }
    
    fileprivate func setupGradientBackground() {
        if gradientStartColor != nil && gradientEndColor != nil && gradient == nil{
            gradient = CAGradientLayer()
            gradient!.frame.size = frame.size
            gradient!.colors = [gradientStartColor!.cgColor, gradientEndColor!.cgColor]
            
            var rotation:CGFloat!
            if gradientRotation >= 0 {
                rotation = min(gradientRotation, CGFloat(360.0))
            } else {
                rotation = max(gradientRotation, CGFloat(-360.0))
            }
            var xAngle:Float = Float(rotation/360)
            if (gradientHorizontal) {
                xAngle = 0.25
            }
            let a = pow(sinf((2*Float(Double.pi)*((xAngle+0.75)/2))),2)
            let b = pow(sinf((2*Float(Double.pi)*((xAngle+0.0)/2))),2)
            let c = pow(sinf((2*Float(Double.pi)*((xAngle+0.25)/2))),2)
            let d = pow(sinf((2*Float(Double.pi)*((xAngle+0.5)/2))),2)
            gradient!.startPoint = CGPoint(x: CGFloat(a), y: CGFloat(b))
            gradient!.endPoint = CGPoint(x: CGFloat(c), y: CGFloat(d))
        
            bgContentView.layer.addSublayer(gradient!)
        }
    }
    
    fileprivate func setupBorderAndCorners() {
        if fullyRoundedCorners {
            bgContentView.layer.cornerRadius = frame.size.height/2
            layer.cornerRadius = frame.size.height/2
        }else{
            bgContentView.layer.cornerRadius = cornerRadius
            layer.cornerRadius = cornerRadius
        }
        bgContentView.layer.borderColor = borderColor.cgColor
        bgContentView.layer.borderWidth = borderWidth
    }
    
    fileprivate func setupTitle() {
        titleLbl.isHidden = titleString.isEmpty
        titleLbl.text = titleString
        titleLbl.textColor = titleColor
        if titleFontName != nil {
            titleLbl.font = UIFont.init(name:titleFontName! , size:titleFontSize)
        }else{
            titleLbl.font = UIFont.systemFont(ofSize: titleFontSize)
        }
    }

    fileprivate func setupSubtitle() {
        subtitleLbl.isHidden = subtitleString.isEmpty
        subtitleLbl.text = subtitleString
        subtitleLbl.textColor = subtitleColor
        if subtitleFontName != nil {
            subtitleLbl.font = UIFont.init(name:subtitleFontName! , size:subtitleFontSize)
        }else{
            subtitleLbl.font = UIFont.systemFont(ofSize: subtitleFontSize)
        }
    }

    fileprivate func setupLeftImage(){
        setupImage(imageView: leftImage,
                   image: leftImageSrc,
                   color: leftImageColor,
                   widthConstraint: leftImageWidthConstraint,
                   heightConstraint: leftImageHeightConstraint,
                   widthValue: leftImageWidth,
                   heightValue: leftImageHeight)
    }
    
    fileprivate func setupRightImage(){
        setupImage(imageView: rightImage,
                   image: rightImageSrc,
                   color: rightImageColor,
                   widthConstraint: rightImageWidthConstraint,
                   heightConstraint: rightImageHeightConstraint,
                   widthValue: rightImageWidth,
                   heightValue: rightImageHeight)
    }
    
    fileprivate func setupSpacings(){
        mainStackView.spacing = spacingTitleIcon
        topMainConstraint.constant = spacingTop
        bottomMainConstraint.constant = spacingBottom
        leadingMainConstraint.constant = spacingLeading
        trailingMainConstraint.constant = spacingTrailing
        setupBorderAndCorners()
    }
    
    fileprivate func setupShadow(){
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = Float(shadowOpacity)
        layer.shadowColor = shadowColor.cgColor
    }
    
    fileprivate func setupLoadingView(){
        loadingLabel.isHidden = loadingString.isEmpty
        loadingLabel.text = loadingString
        loadingLabel.textColor = loadingColor
        if loadingFontName != nil {
            loadingLabel.font = UIFont.init(name:loadingFontName! , size:titleFontSize)
        }else{
            loadingLabel.font = UIFont.systemFont(ofSize: loadingFontSize)
        }
        loadingSpinner.color = loadingSpinnerColor
        setupBorderAndCorners()
    }
    
    fileprivate func setupImage(imageView:UIImageView, image:UIImage?, color:UIColor?, widthConstraint:NSLayoutConstraint, heightConstraint:NSLayoutConstraint, widthValue:CGFloat, heightValue:CGFloat){
        imageView.isHidden = image == nil
        if image != nil {
            if color != nil {
                imageView.image = image?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = color
            }else{
                image?.withRenderingMode(.alwaysOriginal)
                imageView.image = image
            }
            widthConstraint.constant = widthValue
            heightConstraint.constant = heightValue
        }
        setupBorderAndCorners()
    }
    
    fileprivate func showLoadingView() {
        leadingLoadingConstraint.isActive = isLoading
        trailingLoadingConstraint.isActive = isLoading
        mainStackView.isHidden = isLoading
        loadingStackView.isHidden = !isLoading
        isUserInteractionEnabled = !isLoading
    }
    
    // MARK: - Xib file

    fileprivate func xibSetup() {
        rootView = loadViewFromNib()
        rootView.frame = bounds
        rootView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(rootView)
        leadingLoadingConstraint.isActive = false
        trailingLoadingConstraint.isActive = false
    }
    
    fileprivate func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LGButton", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    // MARK: - Touches

    var touchAlpha : TouchAlphaValues = .untouched {
        didSet {
            updateTouchAlpha()
        }
    }
    
    var pressed : Bool = false {
        didSet {
            // Animate pressing
            setPushedIn(pushedIn: pressed)

            if !showTouchFeedback {
                return
            }
            
            touchAlpha = (pressed) ? .touched : .untouched
        }
    }

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        pressed = true
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        let shouldSendActions = pressed
        pressed = false
        if shouldSendActions{
            sendActions(for: .touchUpInside)
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        if let touchLoc = touches.first?.location(in: self){
            if (touchLoc.x < -touchDisableRadius ||
                touchLoc.y < -touchDisableRadius ||
                touchLoc.x > self.bounds.size.width + touchDisableRadius ||
                touchLoc.y > self.bounds.size.height + touchDisableRadius){
                pressed = false
            }
            else if self.touchAlpha == .untouched {
                pressed = true
            }
        }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressed = false
    }
    
    func updateTouchAlpha() {
        if self.alpha != self.touchAlpha.rawValue {
            UIView.animate(withDuration: 0.2) {
                self.alpha = self.touchAlpha.rawValue
            }
        }
    }


    // MARK: - Transformations

    var finishedPushingIn = true

    func setPushedIn(pushedIn: Bool) {
        if (!finishedPushingIn) {
            return
        }

        finishedPushingIn = false
        UIView.animate(withDuration: 0.08, animations: {
            if (pushedIn) {
                let scale: CGFloat = 0.95
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
            } else {
                self.transform = CGAffineTransform.identity
            }
        }) { _ in
            self.finishedPushingIn = true

            // We've pushed in, but now button is not being pressed
            if pushedIn && !self.pressed {
                self.setPushedIn(pushedIn: false)
            }
        }
    }


    // MARK: - Actions
    // Enables a closure to be used with a target action
    // Taken from https://cocoacasts.com/elegant-controls-in-swift-with-closures
    
    typealias DidTapButton = (LGButton) -> ()

    var didTouchUpInside: DidTapButton? {
        didSet {
            if didTouchUpInside != nil {
                addTarget(self, action: #selector(didTouchUpInside(sender:)), for: .touchUpInside)
            } else {
                removeTarget(self, action: #selector(didTouchUpInside(sender:)), for: .touchUpInside)
            }
        }
    }

    @objc func didTouchUpInside(sender: LGButton) {
        if let handler = didTouchUpInside {
            handler(self)
        }
    }
}
