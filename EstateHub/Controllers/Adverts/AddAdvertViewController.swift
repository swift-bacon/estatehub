//
//  AddAdvertViewController.swift
//  EstateHub
//
//  Created by Unit27 on 02/08/2025.
//
import UIKit

class AddAdvertViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private var titleText = BigTitleLabel(labelText: "Add new advert")
    private var descriptionText = DescriptionLabel(labelText: "Fill add advert form")
    private let textFieldsView = UIView()
    private let titleTextField =  DefaultTextField(placeholder: "Enter title")
    private var descriptionTextView =  DefaultTextView(placeholder: "Short description", 80)
    private let priceTextField = DefaultTextField(placeholder: "Price")
    private let streetTextField = DefaultTextField(placeholder: "Street")
    
    private lazy var priceStreetStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceTextField, streetTextField])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let cityTextField = DefaultTextField(placeholder: "City")
    private let countryTextField = DefaultTextField(placeholder: "Country")
    
    private lazy var cityCountryStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityTextField, countryTextField])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let isPromotedSwitch = UISwitch()
    private let isPromotedLabel: UILabel = {
        let label = UILabel()
        label.text = "Is promoted advert"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    private lazy var addButton = DefaultButton(title: "Add advert", target: self, action: #selector(addButtonTapped))
    
    var isPromoted: Bool = false
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    // MARK: - Layout
    
    ///
    /// Setup layout
    ///
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(titleText)
        view.addSubview(descriptionText)
        view.addSubview(textFieldsView)
        textFieldsView.addSubview(titleTextField)
        textFieldsView.addSubview(descriptionTextView)
        textFieldsView.addSubview(priceTextField)
        textFieldsView.addSubview(streetTextField)
        textFieldsView.addSubview(priceStreetStackView)
        textFieldsView.addSubview(cityTextField)
        textFieldsView.addSubview(countryTextField)
        textFieldsView.addSubview(cityCountryStackView)
        textFieldsView.addSubview(isPromotedLabel)
        textFieldsView.addSubview(isPromotedSwitch)
        view.addSubview(addButton)
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        textFieldsView.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        streetTextField.translatesAutoresizingMaskIntoConstraints = false
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        countryTextField.translatesAutoresizingMaskIntoConstraints = false
        isPromotedLabel.translatesAutoresizingMaskIntoConstraints = false
        isPromotedSwitch.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        priceStreetStackView.translatesAutoresizingMaskIntoConstraints = false
        cityCountryStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20),
            descriptionText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            textFieldsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textFieldsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            textFieldsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            titleTextField.topAnchor.constraint(equalTo: textFieldsView.topAnchor, constant: 0),
            titleTextField.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 0),
            titleTextField.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor, constant: 0),
            
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            descriptionTextView.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor, constant: 0),
            descriptionTextView.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor, constant: 0),
            
            priceStreetStackView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 24),
            priceStreetStackView.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor),
            priceStreetStackView.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor),
            
            cityCountryStackView.topAnchor.constraint(equalTo: priceStreetStackView.bottomAnchor, constant: 24),
            cityCountryStackView.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor),
            cityCountryStackView.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor),
            
            isPromotedLabel.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 24),
            isPromotedLabel.leadingAnchor.constraint(equalTo: textFieldsView.leadingAnchor),
            isPromotedLabel.trailingAnchor.constraint(equalTo: isPromotedSwitch.leadingAnchor, constant: -8),
            
            isPromotedSwitch.centerYAnchor.constraint(equalTo: isPromotedLabel.centerYAnchor),
            isPromotedSwitch.trailingAnchor.constraint(equalTo: textFieldsView.trailingAnchor),
            
            isPromotedSwitch.bottomAnchor.constraint(equalTo: textFieldsView.bottomAnchor),
            
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            addButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        priceTextField.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        streetTextField.widthAnchor.constraint(equalTo: priceTextField.widthAnchor, multiplier: 2.0).isActive = true
    }
    
    // MARK: - Actions
    
    ///
    /// Add button tapped
    ///
    @objc private func addButtonTapped() {
        Task { [weak self] in
            await self?.handleAddAdvert()
        }
    }
    
    ///
    /// Handle login method
    ///
    private func handleAddAdvert() async {
        guard let title = titleTextField.text, !title.isEmpty else {
            Alerts.showError(on: self, message: "Enter title")
            return
        }
        
        guard let description = descriptionTextView.text, !description.isEmpty else {
            Alerts.showError(on: self, message: "Enter short description")
            return
        }
        
        guard let price = priceTextField.text, !price.isEmpty else {
            Alerts.showError(on: self, message: "Enter price")
            return
        }
        
        guard let street = streetTextField.text, !street.isEmpty else {
            Alerts.showError(on: self, message: "Enter street")
            return
        }
        
        guard let city = cityTextField.text, !city.isEmpty else {
            Alerts.showError(on: self, message: "Enter city")
            return
        }
        
        guard let country = countryTextField.text, !country.isEmpty else {
            Alerts.showError(on: self, message: "Enter country")
            return
        }
        
        let expirationDate = Calendar.current.date(byAdding: .day, value: 30, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let expirationDateString = formatter.string(from: expirationDate)
        
        let newAdvert = Advert(
            name: title,
            description: description,
            address: "\(street), \(city), \(country)",
            expirationDate: expirationDateString,
            isPromoted: isPromoted,
            price: Int(price) ?? 0
        )
        
        Task {
            do {
                try await AdvertService.add(advert: newAdvert)
                
                DispatchQueue.main.async {
                    let successVC = SuccessViewController()
                    successVC.completion = { [weak self] in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashboardViewController")
                        let navVC = UINavigationController(rootViewController: dashboardVC)
                        
                        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                            sceneDelegate.window?.rootViewController = navVC
                            sceneDelegate.window?.makeKeyAndVisible()
                        }
                    }
                    self.navigationController?.pushViewController(successVC, animated: true)
                }
            } catch {
                print("Błąd: \(error)")
            }
        }
        
    }
}
