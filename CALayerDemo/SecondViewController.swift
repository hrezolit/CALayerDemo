//
//  SecondViewController.swift
//  CALayerDemo
//
//  Created by Nikita on 14/5/22.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    
    let imageView = UIImageView()
    let myButton = UIButton()
    var playerA = AVAudioPlayer()
    let audioPath = Bundle.main.path(forResource: "bell", ofType: "mp3")
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            gradientLayer.colors = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1).cgColor, #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1).cgColor]
        }
    }
    
    var loadFrame: CAShapeLayer! {
        didSet {
            loadFrame.lineWidth = 15
            loadFrame.lineCap = .round
            loadFrame.fillColor = nil
            loadFrame.strokeEnd = 0
            loadFrame.strokeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1).cgColor
        }
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        view.addSubview(imageView)
        view.addSubview(myButton)
        
        loadFrame = CAShapeLayer()
        view.layer.addSublayer(loadFrame)
        
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        myButton.addTarget(self, action: #selector(myButtonTapped), for: .touchUpInside)
        
        setItemsContraints()
        setItemsLook()
    }
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 50 + 80 + imageView.frame.size.height / 2)
        
        drawGoldenFrame()
        
    }
    
    // Actions:
    @objc func myButtonTapped() {
        
        guard loadFrame.strokeEnd >= 0.9  else {
            loadFrame.strokeEnd += 0.1
            return
        }
        
        // Play bell sound after fill path of golden line
        playerA = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        playerA.volume = 0.6
        playerA.play()
        
        dismiss(animated: true)
        
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
        myButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150).isActive = true
        myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        myButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    // Settings for items:
    private func setItemsLook() {
        imageView.image =  #imageLiteral(resourceName: "cup")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        myButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        myButton.setTitle("Back", for: .normal)
        myButton.setImage(UIImage(systemName: "arrowshape.turn.up.left.fill"), for: .normal)
        myButton.setTitleColor(.blue, for: .normal)
        myButton.layer.cornerRadius = 15
        myButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        myButton.layer.shadowOpacity = 1
        myButton.layer.shadowRadius = 0
        myButton.layer.shadowColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    
    // Golden frame path
    private func drawGoldenFrame() {
        loadFrame.frame = view.bounds
        let imageLoadFrame = UIBezierPath()
        imageLoadFrame.move(to: CGPoint(x: imageView.frame.origin.x + 5, y: imageView.frame.origin.y + 5))
        imageLoadFrame.addLine(to: CGPoint(x: imageView.frame.origin.x + 195, y: imageView.frame.origin.y + 5))
        imageLoadFrame.addLine(to: CGPoint(x: imageView.frame.origin.x + 195, y: imageView.frame.origin.y + 195))
        imageLoadFrame.addLine(to: CGPoint(x: imageView.frame.origin.x + 5, y: imageView.frame.origin.y + 195))
        imageLoadFrame.addLine(to: CGPoint(x: imageView.frame.origin.x + 5, y: imageView.frame.origin.y + 5))
        loadFrame.path = imageLoadFrame.cgPath
    }
}
