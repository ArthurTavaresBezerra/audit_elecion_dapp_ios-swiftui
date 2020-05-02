//
//  ScanBoletimView.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 08/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//
 
import AVFoundation
import SwiftUI


/// A SwiftUI view that is able to scan barcodes, QR codes, and more, and send back what was found.
/// To use, set `codeTypes` to be an array of things to scan for, e.g. `[.qr]`, and set `completion` to
/// a closure that will be called when scanning has finished. This will be sent the string that was detected or a `ScanError`.
/// For testing inside the simulator, set the `simulatedData` property to some test data you want to send back.
public struct CodeScannerView: UIViewControllerRepresentable {
    public enum ScanError: Error {
        case badInput, badOutput
    }
    
    public class ScannerCoordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: CodeScannerView
        var codeFound = false
        var inputs : [String] = []

        init(parent: CodeScannerView) {
            assert(parent.simulatedData.isEmpty == false, "The iOS simulator does not support using the camera, so you must set the simulatedData property of CodeScannerView.")
            self.parent = parent
        }
        
        public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                guard codeFound == false else { return }
                
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                found(code: stringValue)
                 
                codeFound = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { self.codeFound = false }
            }
        }
        
        func found(code: String) {
            #if targetEnvironment(simulator)
            parent.completion(.success(parent.simulatedData))
            parent.scannerViewController.dismiss(animated: true, completion: nil)
            #else
            parent.scannerViewController.foundQrCode(qrCode: code, finished: { codeFinal in
                self.parent.completion(.success(codeFinal))
            })
            #endif
        }
        
        func didFail(reason: ScanError) {
            parent.completion(.failure(reason))
        }
    }
    
    #if targetEnvironment(simulator)
    public class ScannerViewController: UIViewController {
        
        var delegate: ScannerCoordinator?
        
        override public func loadView() {
            view = UIView()
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            
            label.text = "You're running in the simulator, which means the camera isn't available. Tap anywhere to send back some simulated data."
            
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                label.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                label.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
            ])
        }
        
        override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            delegate?.found(code: "")
        }
    }
    #else
    public class ScannerViewController: UIViewController {
        var captureSession: AVCaptureSession!
        var previewLayer: AVCaptureVideoPreviewLayer!
        var delegate: ScannerCoordinator?
        var panelBottom: UIView = UIView()
        var labelInfo: UILabel = UILabel()
        var inputStrings: [String] = []
        
        override public func viewDidLoad() {
            super.viewDidLoad()
            settingPanelBottom();
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(updateOrientation),
                                                   name: Notification.Name("UIDeviceOrientationDidChangeNotification"),
                                                   object: nil)
            
            view.backgroundColor = UIColor.black
            captureSession = AVCaptureSession()

            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
            let videoInput: AVCaptureDeviceInput

            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }
            

            if (captureSession.canAddInput(videoInput)) {
                captureSession.addInput(videoInput)
            } else {
                delegate?.didFail(reason: .badInput)
                return
            }

            let metadataOutput = AVCaptureMetadataOutput()

            if (captureSession.canAddOutput(metadataOutput)) {
                captureSession.addOutput(metadataOutput)

                metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = delegate?.parent.codeTypes
            } else {
                delegate?.didFail(reason: .badOutput)
                return
            }

            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            
            updateOrientation()
            let subView = UIView()
            subView.backgroundColor = UIColor.red
            subView.frame = view.frame;
            
            subView.layer.addSublayer(previewLayer)
            subView.addSubview(createButtonCancel())
            subView.addSubview(self.panelBottom)
            view.addSubview(subView)
            
            view.layer.insertSublayer(createScopeBarCode(), above: previewLayer)
            view.layer.insertSublayer(createRectangleGrayAlphaBarCode(), above: previewLayer)
            
            captureSession.startRunning()
        }
        
        func createButtonCancel() -> UIButton{
            let width: CGFloat = self.view.frame.size.width

            let buttonCancel: UIButton = UIButton(type: .system)
            buttonCancel.frame = CGRect(x: width-60, y: 14, width: 50, height: 50)
            buttonCancel.tintColor = UIColor.white
            buttonCancel.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            buttonCancel.addTarget(self, action: #selector(buttonCancelAction), for: .touchUpInside)
            buttonCancel.contentVerticalAlignment = .fill
            buttonCancel.contentHorizontalAlignment = .fill
            buttonCancel.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

            return buttonCancel
        }
        
        @objc func buttonCancelAction(sender: UIButton!) {
            dismiss(animated: true, completion: nil)
        }
        
        func createScopeBarCode() -> CAShapeLayer {
            let offsetY: CGFloat = 50
            let height: CGFloat = self.view.frame.size.height
            let width: CGFloat = self.view.frame.size.width
            let widthApply: CGFloat = width - 100.0
            let heightApply: CGFloat = height - 400.0
            let posXInitial: CGFloat = (width - widthApply)/2
            let posYInitial: CGFloat = (height - heightApply)/2 - offsetY
            let tam: CGFloat = 50;

            let path = UIBezierPath()
            path.move(to: CGPoint(x: posXInitial, y: posYInitial+tam))
            path.addLine(to: CGPoint(x: posXInitial, y: posYInitial))
            path.addLine(to: CGPoint(x: posXInitial+tam, y: posYInitial))

            path.move(to: CGPoint(x: posXInitial, y: posYInitial + heightApply - tam))
            path.addLine(to: CGPoint(x: posXInitial, y: posYInitial + heightApply))
            path.addLine(to: CGPoint(x: posXInitial+tam, y: posYInitial + heightApply))
            
            path.move(to: CGPoint(x: posXInitial + widthApply - tam , y: posYInitial))
            path.addLine(to: CGPoint(x: posXInitial + widthApply, y: posYInitial))
            path.addLine(to: CGPoint(x: posXInitial + widthApply, y: posYInitial + tam))
            
            path.move(to: CGPoint(x: posXInitial + widthApply, y: posYInitial+heightApply-tam))
            path.addLine(to: CGPoint(x: posXInitial + widthApply, y: posYInitial+heightApply))
            path.addLine(to: CGPoint(x: posXInitial + widthApply - tam, y: posYInitial+heightApply))
  
            let shape = CAShapeLayer()
            shape.path = path.cgPath
            shape.strokeColor = UIColor.yellow.cgColor
            shape.lineWidth = 5
            shape.fillColor = UIColor.clear.cgColor
            return shape
        }

        func createRectangleGrayAlphaBarCode() -> CAShapeLayer {
            let offsetY: CGFloat = 50
            let height: CGFloat = self.view.frame.size.height
            let width: CGFloat = self.view.frame.size.width
            let widthApply: CGFloat = width - 100.0
            let heightApply: CGFloat = height - 400.0
            let posXInitial: CGFloat = (width - widthApply)/2
            let posYInitial: CGFloat = (height - heightApply)/2 - offsetY
            
            let path = UIBezierPath()
            
            path.move(to: CGPoint(x: posXInitial, y: posYInitial))
            path.addLine(to: CGPoint(x: posXInitial + widthApply, y: posYInitial))
            path.addLine(to: CGPoint(x: posXInitial + widthApply, y: posYInitial + heightApply))
            path.addLine(to: CGPoint(x: posXInitial, y: posYInitial + heightApply))
            path.addLine(to: CGPoint(x: posXInitial, y: posYInitial))
            
            let shape = CAShapeLayer()
            shape.path = path.cgPath
            shape.strokeColor = UIColor.clear.cgColor
            shape.lineWidth = 0
            let alphaGray = UIColor.init(cgColor: CGColor.init(srgbRed: 0, green: 0, blue: 0, alpha: 0.1))
            shape.fillColor = alphaGray.cgColor
            return shape
        }

        func settingPanelBottom() {
            let height: CGFloat = self.view.frame.size.height
            let width: CGFloat = self.view.frame.size.width
            let widthApply: CGFloat = width - 100.0
            let heightApply: CGFloat = 60
            let posXInitial: CGFloat = (width - widthApply)/2
            
            self.panelBottom.frame = CGRect(origin: CGPoint(x:posXInitial, y:height - 60 - heightApply),
                                                  size: CGSize(width: widthApply, height: heightApply))
            
            self.panelBottom.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.18)
            self.panelBottom.layer.shadowOpacity = 0.75
            self.panelBottom.layer.shadowOffset = CGSize(width: 2, height: 5)
            self.panelBottom.layer.shadowRadius = 3.0
            self.panelBottom.layer.cornerRadius = 30.0
            self.panelBottom.layer.borderWidth = 1.5
            self.panelBottom.layer.borderColor = UIColor.white.cgColor

            self.labelInfo.text  = "Scanei todos os QrCodes"
            self.labelInfo.numberOfLines = 3
            self.labelInfo.textColor = UIColor.white
            self.labelInfo.font = UIFont(name: self.labelInfo.font.fontName, size: 21.0)
            self.labelInfo.textAlignment  = .center
            self.labelInfo.frame = CGRect(origin: CGPoint(x:10, y:0),
                                      size: CGSize(width: widthApply-20, height: heightApply))
                
            if let blurFilter = CIFilter(name: "CIGaussianBlur",
                                         parameters: [kCIInputRadiusKey: 2]) {
                panelBottom.layer.backgroundFilters = [blurFilter]
            }

            self.panelBottom.addSubview(labelInfo)
        }
 
        public func foundQrCode(qrCode: String, finished: @escaping (_ codeFinal : String) -> Void) -> Void {
            
            let tagPrefix = "QRBU:"
            let isValid = qrCode.starts(with: tagPrefix)
            guard isValid else {
                self.labelInfo.text = "Este QrCode não em Boletim de Urna"
                return
            }
            
            let lastInputOrder = self.inputStrings.count

            let firstOfSentence = qrCode.index(qrCode.startIndex, offsetBy: tagPrefix.count)
            let endOfSentence = qrCode.index(before:qrCode.firstIndex(of: " ")!)
            let qrbu : String = qrCode[firstOfSentence...endOfSentence].description

            let currentInputOrder = Int(qrbu.split(separator: ":")[0])!
            let totalCountInput = Int(qrbu.split(separator: ":")[1])!

            if currentInputOrder <= totalCountInput && currentInputOrder == lastInputOrder+1 {
                self.labelInfo.text = "Qrcode \(currentInputOrder) de \(totalCountInput)"
                inputStrings.append(qrCode)
            } else {
                self.labelInfo.text = "Favor ler o qrCode \(lastInputOrder+1) \nEste é \(currentInputOrder) de \(totalCountInput)"
                return
            }

            if currentInputOrder == totalCountInput {
                dismiss(animated: true, completion: nil)
                finished(self.inputStrings.joined())
            }

        }

        override public func viewWillLayoutSubviews() {
            previewLayer.frame = view.layer.bounds
        }
        
        @objc func updateOrientation() {
            guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {
                return
            }
            let previewConnection = captureSession.connections[1]
            previewConnection.videoOrientation = AVCaptureVideoOrientation(rawValue: orientation.rawValue) ?? .portrait
        }
        
        override public func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            if (captureSession?.isRunning == false) {
                captureSession.startRunning()
            }
        }

        override public func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            if (captureSession?.isRunning == true) {
                captureSession.stopRunning()
            }
            
            NotificationCenter.default.removeObserver(self)
        }

        override public var prefersStatusBarHidden: Bool {
            return true
        }

        override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .all
        }
    }
    #endif
    
    public let codeTypes: [AVMetadataObject.ObjectType]
    public var simulatedData = ""
    public var completion: (Result<String, ScanError>) -> Void
    public var scannerViewController : ScannerViewController
    
    public init(codeTypes: [AVMetadataObject.ObjectType], simulatedData: String = "", completion: @escaping (Result<String, ScanError>) -> Void) {
        self.codeTypes = codeTypes
        self.simulatedData = simulatedData
        self.completion = completion
        self.scannerViewController = ScannerViewController()
    }
    
    public func makeCoordinator() -> ScannerCoordinator {
        return ScannerCoordinator(parent: self)
    }
    
    public func makeUIViewController(context: Context) -> ScannerViewController {
        self.scannerViewController.delegate = context.coordinator
        return self.scannerViewController
    }
    
    public func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
        
    }
}

struct CodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        CodeScannerView(codeTypes: [.qr]) { result in
            // do nothing
        }
    }
}
