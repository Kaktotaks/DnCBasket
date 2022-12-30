//
//  AccountViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 05.12.2022.
//

import UIKit
import SnapKit

class AccountViewController: BaseViewController {
    private let accountTableView: UITableView = {
        let value: UITableView = .init()
        value.backgroundColor = .systemBackground
        return value
    }()

    private lazy var fileManager = LocalFileManager.instance

    private lazy var cdPhotos: [CDPhoto]? = nil
    var image = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpTableView()
        setUPExitleftBarButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchPhotos()
    }

    // MARK: - Setup imagePicker
    private func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }

    private func fetchPhotos() {
        // Fetch data from Core Data to displayin the table View
        do {
            self.cdPhotos = try context.fetch(CDPhoto.fetchRequest())
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.accountTableView.reloadData()
            }
        } catch {
            print("An error while fetching some data from Core Data")
        }
    }

    private func showImagePickerOptions() {
        let actions: [MyAlertManager.Action] = [
            .init(title: Constants.cancelText, style: .cancel) {
                debugPrint("Cancel Button Pressed")
            },
            .init(title: Constants.cameraText, style: .default) {
                debugPrint("Camera Button Pressed")
                let cameraImagePicker = self.imagePicker(sourceType: .camera)
                cameraImagePicker.delegate = self
                self.present(cameraImagePicker, animated: true) {
                    // TODO
                }
            },
            .init(title: Constants.libraryText, style: .default) {
                debugPrint("Library Button Pressed")
                let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
                libraryImagePicker.delegate = self
                self.present(libraryImagePicker, animated: true) {
                    // TODO
                }
            }
        ]

        let alert = MyAlertManager.shared.presentAlertWithOptions(
            title: Constants.pickaPhotoText,
            message: Constants.choosePictureText,
            actions: actions,
            dismissActionTitle: nil)

        self.present(alert, animated: true)
    }

    private func setUpTableView() {
        accountTableView.register(AccountHeaderTableViewCell.self, forCellReuseIdentifier: AccountHeaderTableViewCell.identifier)
        accountTableView.delegate = self
        accountTableView.dataSource = self
    }

    private func setUpUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(accountTableView)

        accountTableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - TableView Delegate/DataSource methods
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }

        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard
                let cell = accountTableView.dequeueReusableCell(
                    withIdentifier: AccountHeaderTableViewCell.identifier,
                    for: indexPath)
                    as? AccountHeaderTableViewCell
            else {
                return UITableViewCell()
            }

            cell.delegate = self
            guard
                let photo = self.cdPhotos?.last,
                let photoImageName = photo.imageName
            else {
                return UITableViewCell()
            }

            let imageName = fileManager.getImage(name: String("\(photoImageName)"))
            cell.configureCoreDataPhotos(image: imageName)

            cell.selectionStyle = .none
            return cell
        }

        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.selectionStyle = .none

        switch indexPath.row {
        case 0:
            cell.textLabel?.text = Constants.emailTitleText
            cell.detailTextLabel?.text = "UserEmail"
            return cell
        case 1:
            cell.textLabel?.text = Constants.pickedGamesText
            return cell
        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        }
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.goToPickedGames(vc: self)
        }
    }
}

extension AccountViewController: AccountHeaderTableViewCellDelegate {
    func pickImage() {
        if self.user != nil {
            showImagePickerOptions()
        } else {
            showAlertToCreateAccount(vc: self)
        }
    }
}

// MARK: - ImagePicker setup
extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // swiftlint: disable all
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }

        lazy var imageName: UUID = .init()
        
        fileManager.saveImage(image: image, name: "\(imageName)")

        // Create a photo object
        let newPhoto = CDPhoto(context: self.context)
        newPhoto.imageName = imageName
        
        // Save the data
        do {
            try self.context.save()
        } catch {
            print("An error while saving context")
        }
        // Re-fetch data
        self.fetchPhotos()
        self.dismiss(animated: true)
    }
}
