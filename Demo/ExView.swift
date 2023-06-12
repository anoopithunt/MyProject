//
//  ExView.swift
//  Demo
//
//  Created by Anup Kumar Mishra on 10/08/22.
//

import SwiftUI

struct ExView: View {
    @State var full_name: String?
    @State var totalBookViews: String?
    @State  var totalfollowers: String?
    @State var totalBooks: String?
    @State var name: String?
    @State var url: String = "InCompleted"
    @State private var templateColor: Color =  Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)).opacity(0.5)

    var body: some View {
        VStack {

         
            VStack {
                HStack(alignment: .top , spacing: 6) {
                    Image(systemName: "eye")
                        .padding(.leading,2)
                    Text(totalBookViews ?? "23")
                        .padding(.leading,3)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.bottom)
             
                Image(systemName: "externaldrive.badge.wifi")
                    .resizable()
                    .frame( height: 96, alignment:.center)
                    .scaledToFill()
                    .clipShape(Circle())
                    .padding(.all,8)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))

                Text(full_name ?? "Alibrary")
                    .font(.system(size: 16))
                    .bold()
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.vertical,6)
                
                HStack {
                    Image(systemName: "plus.rectangle.on.folder")
                        .padding(.leading)
                    Text(totalBooks ?? "3433")
                    Spacer()
                    Text(name ?? "")
                        .font(.system(size: 12))
                    Spacer()
                }
                .background(Color.white)
                
                HStack(spacing: 3){
                   Text("Follow")
                    
                        .frame(width: 112,height: 35)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(22)

                     
                        .overlay(
                                RoundedRectangle(cornerRadius: 22)
                                    .stroke(Color.white, lineWidth: 1)
                                
                                )
//                     .padding(.leading)
                    
                    Image(systemName: "person")
                        .foregroundColor(.white)
                        .padding(.leading,5)
                    Text(totalfollowers ?? "2.13k")
                        .foregroundColor(.white)
                        .padding(.trailing,1)
                        .font(.system(size: 12))
//                    Text(email ?? "")
//                        .foregroundColor(.white)
//                        .padding(.leading)
                       
                }
                .padding(.vertical,12)
               
             
            }
            .padding(.vertical)
        
            .frame(width:UIScreen.main.bounds.width/2.2)
            .background(templateColor)
            .cornerRadius(13)

        }
//        .padding(.vertical)

    }
}

struct ExView_Previews: PreviewProvider {
    static var previews: some View {
        ASView()
    }
}



struct PressActions: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}
 
 
extension View {
    func pressAction(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(PressActions(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}
 

struct ASView: View {
    @State private var isPressed = false
    
    var body: some View {
        Image(!isPressed ? "Anoop" : "soft")
            .resizable()
            .overlay(
                GeometryReader { geometry in
                    Button(action: { }, label: {
                        Text("")
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                            .contentShape(Rectangle())
                    })
                    .buttonStyle(.plain)
                    .pressAction {
                        isPressed = true
                    } onRelease: {
                        isPressed = false
                    }
                }
            )
            .frame(width: 100, height: 100)
        CircularProgressViewController()//.edgesIgnoringSafeArea(.all)
        
    }
}



import UIKit

class CircularProgressView1: UIView {
    
    let trackShapeLayer = CAShapeLayer()
    let progressShapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layout()
    }
    
    private func layout() {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 35, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let lineWidth: CGFloat = 6
        
        // Track Shape layer
        trackShapeLayer.path = circularPath.cgPath
        trackShapeLayer.strokeColor = UIColor.init(white: 0.5, alpha: 0.5).cgColor
        trackShapeLayer.lineWidth = lineWidth
        trackShapeLayer.fillColor = UIColor.clear.cgColor
        trackShapeLayer.lineCap = .round
        trackShapeLayer.position = self.center
        
        // To add a shadow, uncomment the below code:
        
        trackShapeLayer.shadowColor = UIColor.black.cgColor
        trackShapeLayer.shadowPath = trackShapeLayer.path?.copy(strokingWithWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: 5)
        trackShapeLayer.shadowOpacity = 1
        trackShapeLayer.shadowOffset = CGSize.zero
        trackShapeLayer.shadowRadius = 5
        
        // Progress Shape Layer
        progressShapeLayer.path = circularPath.cgPath
        progressShapeLayer.strokeColor = UIColor.white.cgColor
        progressShapeLayer.lineWidth = lineWidth
        progressShapeLayer.fillColor = UIColor.clear.cgColor
        progressShapeLayer.lineCap = .round
        progressShapeLayer.position = self.center
        progressShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        progressShapeLayer.strokeEnd = 0
        
        self.layer.addSublayer(trackShapeLayer)
        self.layer.addSublayer(progressShapeLayer)
    }
    
    var progress: CGFloat? {
        didSet {
            if let progress = progress {
                self.progressShapeLayer.strokeEnd = progress
            }
        }
    }
}


class ViewController1: UIViewController {
    
    let circularProgressView = CircularProgressView1()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        
        view.addSubview(circularProgressView)
        circularProgressView.translatesAutoresizingMaskIntoConstraints = false
        circularProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circularProgressView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        let startButton: UIButton = {
            var configuration = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = .boldSystemFont(ofSize: 18)
            container.foregroundColor = .white
            configuration.attributedTitle = AttributedString("Start", attributes: container)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25)
            configuration.baseBackgroundColor = .systemIndigo
            configuration.cornerStyle = .capsule
            
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.handleStart), for: .touchUpInside)
            return button
        }()
        
        let resetButton: UIButton = {
            var configuration = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = .boldSystemFont(ofSize: 18)
            container.foregroundColor = .black
            configuration.attributedTitle = AttributedString("Reset", attributes: container)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25)
            configuration.baseBackgroundColor = .red
            configuration.cornerStyle = .capsule
            
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.handleReset), for: .touchUpInside)
            return button
        }()
        
        let buttonsStackView = UIStackView(arrangedSubviews: [
            startButton,
            resetButton
        ])
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 10
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonsStackView)
        buttonsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonsStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    var progress: CGFloat = 0
    var repeatTimer: Timer?
    
    @objc fileprivate func handleStart() {
        let delay: Double = 0.7
        let timeInterval: Double = 0.02
        
        repeatTimer?.invalidate()
        repeatTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in
            DispatchQueue.main.async {
                let current = self.progress
                let duration = CGFloat(delay / timeInterval)
                let add = (1 / duration)
                let newProgress = current + add
                self.progress = newProgress
                self.circularProgressView.progress = self.progress
            }
            let progressComplete = self.progress >= 1
            if progressComplete {
                timer.invalidate()
            }
        }
        if let repeatTimer = repeatTimer {
            RunLoop.current.add(repeatTimer, forMode: .common)
        }
    }
    
    @objc fileprivate func handleReset() {
        repeatTimer?.invalidate()
        self.progress = 0
        self.circularProgressView.progress = self.progress
    }
}



struct CircularProgressViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController1 {
        return ViewController1()
    }
    
    func updateUIViewController(_ uiViewController: ViewController1, context: Context) {
       
        
    }
}
