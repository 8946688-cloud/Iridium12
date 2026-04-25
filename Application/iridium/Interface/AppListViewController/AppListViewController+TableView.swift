//
//  AppListViewController+TableView.swift
//  iridium
//
//  Created by Lakr Aream on 2022/1/7.
//

import AppListProto
import DropDown
import SnapKit
import SwifterSwift
import UIKit

extension AppListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        displayDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! AppCell
        cell.clearStatus()
        if let data = displayDataSource[safe: indexPath.row] {
            cell.setApp(data)
        }
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        85
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath),
              let data = displayDataSource[safe: indexPath.row]
        else {
            return
        }
        let dropDownAnchor = UIView()
        cell.contentView.addSubview(dropDownAnchor)
        dropDownAnchor.snp.makeConstraints { x in
            x.right.equalToSuperview().offset(-8)
            x.bottom.equalToSuperview().offset(8)
            x.width.equalTo(233)
        }
        let dropDown = DropDown(anchorView: dropDownAnchor,
                                selectionAction: { index, _ in
                                    if index == 0 {
                                        self.dispatchDecrypt(app: data)
                                    } else if index == 1 {
                                        self.promptDecryptPrep(app: data)
                                    } else if index == 2 {
                                        data.bundleURL.openInFilza()
                                    } else {
                                        debugPrint("invalid/canceled action")
                                    }
                                },
                                dataSource:
                                [
                                    "Decrypt Now",
                                    "Decrypt Prep",
                                    "Filza Open Bundle",
                                    "Cancel",
                                ]
                                .invisibleSpacePadding())
        DispatchQueue.main.async {
            dropDown.show(onTopOf: self.view.window)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            dropDownAnchor.removeFromSuperview()
        }
    }

    func dispatchDecrypt(app: AppListElement, minOSVersionOverride: String? = nil) {
        let controller = DecrypterViewController()
        controller.app = app
        controller.minOSVersionOverride = minOSVersionOverride
        controller.modalTransitionStyle = .coverVertical
        controller.modalPresentationStyle = .formSheet
        controller.isModalInPresentation = true
        controller.preferredContentSize = CGSize(width: 700, height: 555)
        present(controller, animated: true, completion: nil)
    }

    func promptDecryptPrep(app: AppListElement) {
        let alert = UIAlertController(title: "Decrypt Prep", message: " MinimumOSVersion :", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "14.0"
            textField.keyboardType = .numbersAndPunctuation
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Proceed", style: .default, handler: { _ in
            if let version = alert.textFields?.first?.text, !version.isEmpty {
                self.dispatchDecrypt(app: app, minOSVersionOverride: version)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
