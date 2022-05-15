//
//  ViewController.swift
//  CALayerDemo
//
//  Created by Nikita on 14/5/22.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    let myButton = UIButton()
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            gradientLayer.colors = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor, #colorLiteral(red: 0.4343343973, green: 0.765835762, blue: 0.8989103436, alpha: 1).cgColor]
        }
    }
    
    var loadingLine: CAShapeLayer! {
        didSet {
            loadingLine.lineWidth = 13
            loadingLine.lineCap = .round
            loadingLine.fillColor = nil
            loadingLine.strokeEnd = 0
            loadingLine.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        }
    }
    
    var loadingPath: CAShapeLayer! {
        didSet {
            loadingPath.lineWidth = 20
            loadingPath.lineCap = .round
            loadingPath.fillColor = nil
            loadingPath.strokeEnd = 1
            loadingPath.strokeColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor
        }
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor =  #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        view.addSubview(imageView)
        view.addSubview(myButton)
        
        // Gradient layer for background
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        
        // Loading progress line
        loadingPath = CAShapeLayer()
        view.layer.addSublayer(loadingPath)
        
        loadingLine = CAShapeLayer()
        view.layer.addSublayer(loadingLine)
   
        setItemsContraints()
        setItemsLook()
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configShapeLayer(loadingPath)
        configShapeLayer(loadingLine)
        
        gradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.bounds.size.width,
            height: 50 + 80 + imageView.frame.size.height / 2
        )
    }
    
    // Create a shapes for loading line and loading path
    func configShapeLayer(_ shapeLayer: CAShapeLayer) {
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2 + 90))
        path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 2 + 90))
        shapeLayer.path = path.cgPath
    }
    
    // Actions:
    @objc func myButtonTapped() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        
        animation.delegate = self
        
        loadingLine.add(animation, forKey: nil)

    }
 
    //MARK: - Private methods:
    
    // Constraints:
    private func setItemsContraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        myButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    // Settings for items:
    private func setItemsLook() {
        imageView.image =  #imageLiteral(resourceName: "prog")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        myButton.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        myButton.setTitle("Tap Me!", for: .normal)
        myButton.setTitleColor(.red, for: .normal)
        myButton.layer.cornerRadius = 15
        myButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        myButton.layer.shadowOpacity = 1
        myButton.layer.shadowRadius = 0
        myButton.layer.shadowColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        
        
    }
}

//MARK: - extensions
extension ViewController: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewControllesr = storyboard.instantiateViewController(withIdentifier: "nextView") as! SecondViewController
        nextViewControllesr.modalPresentationStyle = .fullScreen
        nextViewControllesr.modalTransitionStyle = .flipHorizontal
        self.present(nextViewControllesr, animated: true)
    }
    
}
