
import UIKit

class MainViewController: UIViewController {
    
    private let storage = Storage()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var birthdateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .customPink
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self,
                         action: #selector(switchToEditViewController),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getValues()
    }
    
    @objc
    private func switchToEditViewController() {
        let viewController = EditViewController()
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
    private func getValues() {
        guard
            let name = storage.fetchObject(type: String.self, for: .name),
            let birthdate = storage.fetchObject(type: String.self, for: .birthdate)
        else {
            nameLabel.text = "Nobody"
            birthdateLabel.text = "Never"
            return
        }
        nameLabel.text = name
        birthdateLabel.text = birthdate
    }

    private func setUp() {
        view.backgroundColor = .background
        
        vStackView.addArrangedSubview(nameLabel)
        vStackView.addArrangedSubview(birthdateLabel)
        contentView.addSubview(vStackView)
        view.addSubview(contentView)
        view.addSubview(editButton)
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 200),
            contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            editButton.widthAnchor.constraint(equalToConstant: 80),
            editButton.heightAnchor.constraint(equalToConstant: 40),
            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

