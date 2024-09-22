
import Foundation
import UIKit

final class EditViewController: UIViewController {
    
    private let storage = Storage()
    
    private lazy var nameTextField: UITextField = {
        let textField = TextField()
        textField.tag = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your name"
        textField.delegate = self
        textField.backgroundColor = .customPink
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var birthdateTextField: UITextField = {
        let textField = TextField()
        textField.tag = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter your birthdate"
        textField.delegate = self
        textField.backgroundColor = .customPink
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Done", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .customPink
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self,
                         action: #selector(switchToMainViewController),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .customPink70
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    @objc
    private func switchToMainViewController() {
        self.dismiss(animated: true)
    }
    
    private func setUp() {
        view.backgroundColor = .background
        
        vStackView.addArrangedSubview(nameTextField)
        vStackView.addArrangedSubview(birthdateTextField)
        contentView.addSubview(vStackView)
        view.addSubview(contentView)
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 200),
            contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            doneButton.widthAnchor.constraint(equalToConstant: 80),
            doneButton.heightAnchor.constraint(equalToConstant: 40),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension EditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            self.storage.saveObject(value: textField.text ?? "", for: .name)
        case 2:
            self.storage.saveObject(value: textField.text ?? "", for: .birthdate)
        default:
            return false
        }
        textField.endEditing(true)
        return false
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let maxLength = 25
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength
    }
}
