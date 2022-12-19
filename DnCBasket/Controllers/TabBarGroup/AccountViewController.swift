//
//  AccountViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 05.12.2022.
//

import UIKit
import SnapKit

class AccountViewController: UIViewController {
    private let accountTableView: UITableView = {
        let value: UITableView = .init()
        value.backgroundColor = .systemBackground
        return value
    }()

    private lazy var fileManager = LocalFileManager.instance

    // swiftlint: disable all
    private lazy var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // swiftlint: anable all
    
    private lazy var cdPhotos: [CDPhoto]? = nil
    var image = UIImage()

    //    lazy var userData: [UserData] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpTableView()
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
            DispatchQueue.main.async {
                self.accountTableView.reloadData()
            }
        } catch {
            print("An error while fetching some data from Core Data")
        }
    }

    private func showImagePickerOptions() {
        let actions: [MyAlertManager.Action] = [
            .init(title: "Cancel", style: .cancel) {
                debugPrint("Cancel Button Pressed")
            },
            .init(title: "Camera", style: .default) {
                debugPrint("Camera Button Pressed")
                let cameraImagePicker = self.imagePicker(sourceType: .camera)
                cameraImagePicker.delegate = self
                self.present(cameraImagePicker, animated: true) {
                    // TODO
                }
            },
            .init(title: "Library", style: .default) {
                debugPrint("Library Button Pressed")
                let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
                libraryImagePicker.delegate = self
                self.present(libraryImagePicker, animated: true) {
                    // TODO
                }
            }
        ]

        let alert = MyAlertManager.shared.presentAlertWithOptions(
            title: "Pick a photo",
            message: "Choose a picture from Camera or Library",
            actions: actions,
            dismissActionTitle: nil)

        self.present(alert, animated: true)
    }

    private func setUpTableView() {
        accountTableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: UserInfoTableViewCell.identifier)
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

        return 4

//        return ProfileData.datasList.count
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

//            cell.configure(with: model)

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

        guard
            let cell = accountTableView.dequeueReusableCell(
                withIdentifier: UserInfoTableViewCell.identifier,
                for: indexPath)
                as? UserInfoTableViewCell
        else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        }
        return 60
    }
}

extension AccountViewController: AccountHeaderTableViewCellDelegate {
    func pickImage() {
        print("Delegate is working ")
        showImagePickerOptions()
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
