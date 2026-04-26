//
//  SettingView.swift
//  iridium
//
//  Created by Lakr Aream on 2022/1/7.
//

import DropDown
import SnapKit
import UIKit

class SettingView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    let padding = 18

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"

        view.addSubview(tableView)
        tableView.snp.makeConstraints { x in
            x.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.tintColor = .clear
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        22 // [修改] 增加行数以容纳新按钮
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.row {
        case 1:
            let imageView = UIImageView(image: UIImage(named: "avatar"))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            cell.contentView.addSubview(imageView)
            imageView.snp.makeConstraints { x in
                x.left.equalToSuperview().offset(padding)
                x.width.equalTo(20)
                x.height.equalTo(20)
                x.centerY.equalToSuperview()
            }
            imageView.cornerRadius = 5
            let title = UILabel()
            title.text = "Iridium"
            title.font = .systemFont(ofSize: 18, weight: .semibold)
            cell.contentView.addSubview(title)
            title.snp.makeConstraints { x in
                x.left.equalTo(imageView.snp.right).offset(8)
                x.centerY.equalTo(imageView.snp.centerY)
            }
        case 2:
            let text = "Version \(UIApplication.shared.version ?? "0.0") Build \(UIApplication.shared.buildNumber ?? "0")"
            let view = makeTintTextView()
            view.text = text
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.edges.equalToSuperview().inset(
                    UIEdgeInsets(
                        top: 0,
                        left: CGFloat(padding),
                        bottom: 0,
                        right: CGFloat(padding)
                    ))
            }
        case 3:
            let view = makeLeftAligButton()
            view.setTitle("Open Packages In Filza", for: .normal)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.left.equalToSuperview().offset(padding)
                x.top.equalToSuperview()
                x.bottom.equalToSuperview()
                x.width.equalTo(250)
            }
            view.addTarget(self, action: #selector(openArchive), for: .touchUpInside)
        case 4:
            let view = makeLeftAligButton()
            view.setTitle("Select KernInfra Backend", for: .normal)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.left.equalToSuperview().offset(padding)
                x.top.equalToSuperview()
                x.bottom.equalToSuperview()
                x.width.equalTo(250)
            }
            view.addTarget(self, action: #selector(selectBackend), for: .touchUpInside)
        case 5:
            let view = makeLeftAligButton()
            view.setTitle("Select Compression Level", for: .normal)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.left.equalToSuperview().offset(padding)
                x.top.equalToSuperview()
                x.bottom.equalToSuperview()
                x.width.equalTo(250)
            }
            view.addTarget(self, action: #selector(selectCompressionLevel), for: .touchUpInside)
            
        // [新增] 修改输出后缀按钮
        case 6:
            let view = makeLeftAligButton()
            view.setTitle("Set Output Extension", for: .normal)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.left.equalToSuperview().offset(padding)
                x.top.equalToSuperview()
                x.bottom.equalToSuperview()
                x.width.equalTo(250)
            }
            view.addTarget(self, action: #selector(selectOutputExtension), for: .touchUpInside)
            
        // [新增] 自定义命名规则按钮
        case 7:
            let view = makeLeftAligButton()
            view.setTitle("Set IPA Naming Template", for: .normal)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.left.equalToSuperview().offset(padding)
                x.top.equalToSuperview()
                x.bottom.equalToSuperview()
                x.width.equalTo(250)
            }
            view.addTarget(self, action: #selector(setNamingRule), for: .touchUpInside)

        // 原有内容顺序延后
        case 8:
            let view = makeLeftAligButton()
            view.setTitle("Clear Documents", for: .normal)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.left.equalToSuperview().offset(padding)
                x.top.equalToSuperview()
                x.bottom.equalToSuperview()
                x.width.equalTo(250)
            }
            view.addTarget(self, action: #selector(clearDocuments), for: .touchUpInside)
        case 9:
            let view = makeTintTextView()
            view.text = """
            Iridium is powered by FoulDecrypt.

            FoulDecrypt supports iOS 13.5 and later, and has been tested on iOS 14.2, 14.3 and 13.5 (both arm64 and arm64e).

            Any code inside application binary will not be able to execute thanks to our full static decrypter.
            """
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.edges.equalToSuperview().inset(
                    UIEdgeInsets(
                        top: 0,
                        left: CGFloat(padding),
                        bottom: 0,
                        right: CGFloat(padding)
                    ))
            }
        case 10:
            let view = makeLeftAligButton()
            view.setTitle("Get Source: [Iridium]", for: .normal)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.left.equalToSuperview().offset(padding)
                x.top.equalToSuperview()
                x.bottom.equalToSuperview()
                x.width.equalTo(250)
            }
            view.addTarget(self, action: #selector(openSourceIridium), for: .touchUpInside)
        case 11:
            let view = makeLeftAligButton()
            view.setTitle("Get Source: [FoulDecrypt]", for: .normal)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.left.equalToSuperview().offset(padding)
                x.top.equalToSuperview()
                x.bottom.equalToSuperview()
                x.width.equalTo(250)
            }
            view.addTarget(self, action: #selector(openSourceFoul), for: .touchUpInside)
        case 12:
            let view = makeTintTextView()
            view.text = """
            Copyright © 2022 Lakr Aream All Rights Reserved
            """
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.edges.equalToSuperview().inset(
                    UIEdgeInsets(
                        top: 0,
                        left: CGFloat(padding),
                        bottom: 0,
                        right: CGFloat(padding)
                    ))
            }
        case 13:
            let view = makeLeftAligButton()
            view.setTitle("Twitter: @Lakr233", for: .normal)
            cell.contentView.addSubview(view)
            view.snp.makeConstraints { x in
                x.left.equalToSuperview().offset(padding)
                x.top.equalToSuperview()
                x.bottom.equalToSuperview()
                x.width.equalTo(250)
            }
            view.addTarget(self, action: #selector(openTwitter), for: .touchUpInside)
        default:
            break
        }
        return cell
    }

    func makeTintTextView() -> UITextView {
        let view = UITextView()
        view.font = .systemFont(ofSize: 10, weight: .semibold)
        view.textColor = .gray
        view.contentInset = UIEdgeInsets(inset: 0)
        view.textContainer.lineFragmentPadding = 0
        view.isEditable = false
        view.isSelectable = true
        return view
    }

    func makeLeftAligButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        button.setTitleColor(.orange, for: .focused)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        return button
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 0
        case 1:
            return 40
        case 2:
            return 30
        case 3, 4, 5, 6, 7, 8: // [修改] button (增加新按钮行高)
            return 25
        case 9: // text (顺延)
            return 115
        case 10, 11: // button (顺延)
            return 25
        case 12: // copyright (顺延)
            return 30
        case 13: // twitter (顺延)
            return 25
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc func openSourceIridium() {
        let url = URL(string: "https://github.com/Co2333/Iridium")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    @objc func openSourceFoul() {
        let url = URL(string: "https://github.com/NyaMisty/fouldecrypt")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    @objc func openTwitter() {
        let url = URL(string: "https://twitter.com/Lakr233")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    @objc func openArchive() {
        let archiveDir = documentsDirectory
            .appendingPathComponent("Packages")
        archiveDir.openInFilza()
    }

    struct SelectAction {
        let text: String
        let action: (UIViewController) -> Void
    }

    func buildActionList() -> [SelectAction] {
        let currentOption = Agent.shared.foulOption
        return [
            .init(text: currentOption == .unspecified ? "✓ Auto Switch" : "Auto Switch", action: { _ in
                Agent.shared.foulOption = .unspecified
            }),
            .init(text: currentOption == .tfp0 ? "✓ TFP0" : "TFP0", action: { _ in
                Agent.shared.foulOption = .tfp0
            }),
            .init(text: currentOption == .krw ? "✓ KRW - uncover" : "KRW - uncover", action: { _ in
                Agent.shared.foulOption = .krw
            }),
            .init(text: currentOption == .kernrw ? "✓ KERNRW - taurine" : "KERNRW - taurine", action: { _ in
                Agent.shared.foulOption = .kernrw
            }),
            .init(text: "Cancel", action: { _ in }),
        ]
    }

    @objc func selectBackend(sender: UIButton) {
        let actions = buildActionList()
        let dropDown = DropDown(anchorView: sender)
        dropDown.dataSource = actions
            .map(\.text)
            .invisibleSpacePadding()
        dropDown.selectionAction = { [self] (index: Int, _: String) in
            guard index >= 0, index < actions.count else { return }
            let action = actions[index]
            action.action(self)
        }
        dropDown.show(onTopOf: view.window)
    }

    @objc func selectCompressionLevel(sender: UIButton) {
        let currentLevel = Agent.shared.zipCompressionLevel
        
        let actions: [SelectAction] = [
            .init(text: currentLevel == 0 ? "✓ None (Level 0)" : "None (Level 0)", action: { _ in
                Agent.shared.zipCompressionLevel = 0
            }),
            .init(text: currentLevel == 1 ? "✓ Fastest (Level 1)" : "Fastest (Level 1)", action: { _ in
                Agent.shared.zipCompressionLevel = 1
            }),
            .init(text: currentLevel == -1 ? "✓ Default (Level 6)" : "Default (Level 6)", action: { _ in
                Agent.shared.zipCompressionLevel = -1
            }),
            .init(text: currentLevel == 9 ? "✓ Best (Level 9)" : "Best (Level 9)", action: { _ in
                Agent.shared.zipCompressionLevel = 9
            }),
            .init(text: "Cancel", action: { _ in })
        ]
        
        let dropDown = DropDown(anchorView: sender)
        dropDown.dataSource = actions
            .map(\.text)
            .invisibleSpacePadding()
        dropDown.selectionAction = { [self] (index: Int, _: String) in
            guard index >= 0, index < actions.count else { return }
            let action = actions[index]
            action.action(self)
        }
        dropDown.show(onTopOf: view.window)
    }

    @objc func clearDocuments(sender: UIButton) {
        let actions: [SelectAction] = [
            .init(text: "Confirm", action: { _ in
                Agent.shared.clearDocuments()
            }),
            .init(text: "Cancel", action: { _ in }),
        ]
        let dropDown = DropDown(anchorView: sender)
        dropDown.dataSource = actions
            .map(\.text)
            .invisibleSpacePadding()
        dropDown.selectionAction = { [self] (index: Int, _: String) in
            guard index >= 0, index < actions.count else { return }
            let action = actions[index]
            action.action(self)
        }
        dropDown.show(onTopOf: view.window)
    }

    // MARK: - [新增] 新增功能的动作方法

    @objc func selectOutputExtension(sender: UIButton) {
        let currentExt = Agent.shared.outputExtensionMode
        
        let actions: [SelectAction] = [
            .init(text: currentExt == 0 ? "✓ .ipa (Default)" : ".ipa", action: { _ in
                Agent.shared.outputExtensionMode = 0
            }),
            .init(text: currentExt == 1 ? "✓ .zip" : ".zip", action: { _ in
                Agent.shared.outputExtensionMode = 1
            }),
            .init(text: "Cancel", action: { _ in })
        ]
        
        let dropDown = DropDown(anchorView: sender)
        dropDown.dataSource = actions
            .map(\.text)
            .invisibleSpacePadding()
        dropDown.selectionAction = { [self] (index: Int, _: String) in
            guard index >= 0, index < actions.count else { return }
            let action = actions[index]
            action.action(self)
        }
        dropDown.show(onTopOf: view.window)
    }

    @objc func setNamingRule(sender: UIButton) {
        let currentMode = Agent.shared.fileNamingMode
        let alert = UIAlertController(title: "Naming Rule", message: "Choose naming style", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: currentMode == 0 ? "✓ Official Default" : "Official Default", style: .default) { _ in
            Agent.shared.fileNamingMode = 0
        })
        
        alert.addAction(UIAlertAction(title: currentMode == 1 ? "✓ Custom Template..." : "Custom Template...", style: .default) { [weak self] _ in
            self?.showTemplateInput()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
        }
        
        self.present(alert, animated: true)
    }

    func showTemplateInput() {
        let alert = UIAlertController(
            title: "Custom Template",
            message: "Tags: {Name}, {BundleID}, {ShortVersion}, {Version}",
            preferredStyle: .alert
        )
        
        alert.addTextField { tf in
            tf.text = Agent.shared.namingTemplate
            tf.placeholder = "{Name}.{BundleID}.({ShortVersion})"
            tf.clearButtonMode = .whileEditing
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                Agent.shared.namingTemplate = text
                Agent.shared.fileNamingMode = 1
            }
        })
        
        self.present(alert, animated: true)
    }
}
