//
//  ViewController.swift
//  Thematic
//
//  Created by gao497868860@163.com on 08/17/2021.
//  Copyright (c) 2021 gao497868860@163.com. All rights reserved.
//

import UIKit
import Thematic

extension UIColor {
    
    static var themeMainColor: UIColor {
        return UIColor(assetName: "main") ?? .black
    }
    
    static var themeTextColor: UIColor {
        return UIColor(assetName: "text") ?? .black
    }
}

class CustomView: UIView {
    
    override func userInterfaceThemeDidChange(_ theme: Theme) {
        layer.backgroundColor = UIColor(dynamicTheme: { theme -> UIColor in
            switch theme {
            case .light:
                return .black
            case .dark:
                return UIColor(assetName: "main", in: .main, theme: LightTheme())!
            default:
                return .orange
            }
        }).cgColor
    }
}

class ViewController: UIViewController {
    
    override func userInterfaceThemeDidChange(_ theme: Theme) {
        super.userInterfaceThemeDidChange(theme)
        
        navigationController?.navigationBar.barStyle = .init(dynamicTheme: { theme -> UIBarStyle in
            switch theme {
            case .light:
                return .default
            case .dark:
                return .black
            default:
                return .default
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isDynamicThemeEnabled = true
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.themeMainColor.cgColor, UIColor.themeTextColor.cgColor]
        view.layer.addSublayer(gradientLayer)
        
        let imageViw = UIImageView(
            frame: CGRect(x: self.view.center.x - 50, y: 120, width: 100, height: 100)
        )
        imageViw.image = UIImage(assetName: "sleep")
        imageViw.backgroundColor = .red
        
        let customView = CustomView(
            frame: CGRect(x: self.view.center.x - 50, y: 260, width: 100, height: 100)
        )
        customView.backgroundColor = .themeMainColor
        
        let label = UILabel(
            frame: CGRect(x: self.view.center.x - 50, y: 100, width: 100, height: 100)
        )

        label.textColor = .orange
        let attrText = NSMutableAttributedString(string: "Hello")
        attrText.append(NSAttributedString(string: " World", attributes: [.foregroundColor: UIColor.themeTextColor.withAlphaComponent(0.8)]))
        label.attributedText = attrText
        
        label.sizeToFit()
        
        self.view.addSubview(label)
        self.view.addSubview(imageViw)
        self.view.addSubview(customView)
        
        let button = UIButton(type: .system)
        button.setTitle("Default", for: .normal)
        button.addTarget(self, action: #selector(didTapDefault), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 400, width: 0, height: 0)
        button.sizeToFit()
        button.setTitleColor(.themeTextColor, for: .normal)
        button.center.x = self.view.center.x
        self.view.addSubview(button)
        
        let button1 = UIButton(type: .system)
        button1.setTitle("Download&Switch", for: .normal)
        button1.addTarget(self, action: #selector(downloadAndSwitch), for: .touchUpInside)
        button1.frame = CGRect(x: 0, y: 440, width: 0, height: 0)
        button1.sizeToFit()
        button1.setTitleColor(.themeTextColor, for: .normal)
        button1.center.x = self.view.center.x
        self.view.addSubview(button1)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Light",
            style: .plain,
            target: self,
            action: #selector(didTapLight)
        )
        navigationItem.leftBarButtonItem?.tintColor = .themeTextColor
        navigationItem.leftBarButtonItem?.isDynamicThemeEnabled = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Dark",
            style: .plain,
            target: self,
            action: #selector(didTapDark)
        )
        navigationItem.rightBarButtonItem?.tintColor = .themeTextColor
        navigationItem.rightBarButtonItem?.isDynamicThemeEnabled = true
        
        navigationItem.title = "Theme"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.themeTextColor]
        navigationController?.navigationBar.barTintColor = .themeMainColor
    }
    
    @objc private func didTapDefault() {
        ThemeManager.shared.applyUserInterfaceTheme(.default)
    }
    
    @objc private func didTapLight() {
        ThemeManager.shared.applyUserInterfaceTheme(.light)
    }
    
    @objc private func didTapDark() {
        ThemeManager.shared.applyUserInterfaceTheme(.dark)
    }
    
    @objc func downloadAndSwitch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            do {
                let data = try Data(
                    contentsOf: URL(
                        string: "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=363856837,3739491270&fm=26&gp=0.jpg"
                    )!
                )
                
                let url = Bundle.main.url(forResource: "christmas", withExtension: "plist")!
                let pData = try Data(contentsOf: url)
                
                self.createAssetsDirectoryIfNeeded()
                
                try data.write(
                    to: URL(fileURLWithPath: self.assetsDirectory + "/sleep.png")
                )
                
                try pData.write(
                    to: URL(fileURLWithPath: self.assetsDirectory + "/christmas.plist")
                )
                
                let dynamicTheme = DynamicTheme(
                    identifier: "christmas",
                    assetsDirectory: self.assetsDirectory
                )
                ThemeManager.shared.applyDynamicTheme(dynamicTheme)
                
                self.alertMerryChristmas()
                debugPrint("切换动态主题成功")
            } catch {
                debugPrint("切换动态主题失败")
            }
        }
    }
}

extension ViewController {
    
    var assetsDirectory: String {
        "\(NSHomeDirectory())/Documents/Themes/christmas"
    }
    
    func createAssetsDirectoryIfNeeded() {
        guard !FileManager.default.fileExists(atPath: assetsDirectory) else { return }
        
        do {
            try FileManager.default.createDirectory(
                atPath: assetsDirectory,
                withIntermediateDirectories: true,
                attributes: nil
            )
        } catch {
            debugPrint(error)
        }
    }
    
    func alertMerryChristmas() {
        let alert = UIAlertController(
            title: "Merry Christmas",
            message: nil,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "enjoy it!",
                style: .default
            ) { _ in
                
            }
        )
        present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    
    @IBInspectable var backgroundColorAssetName: String? {
        get { nil }
        set {
            guard let assetName = newValue else { return }
            
            backgroundColor = UIColor(assetName: assetName)
        }
    }
}
