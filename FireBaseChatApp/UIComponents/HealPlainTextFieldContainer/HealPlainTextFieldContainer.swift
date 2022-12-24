//
//  HealPlainTextFieldContainer.swift
//  heal_ios
//
//  Created by Francis Myat on 9/19/22.
//
// swiftlint: disable redundant_optional_initialization

import UIKit
//import CountryPickerView

class HealPlainTextFieldContainer: BaseCustomView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerTextField: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    
//    weak var cpvTextField: CountryPickerView!
    
    var datePicker: UIDatePicker?
    var doneAction: ((Bool, String) -> Void)? = nil
    
    var selectedValue: String?
    var pickerList: [String] = []
    
    var value: String? {
        inputTextField.text
    }
    
    var placeholder: String? {
        inputTextField.placeholder
    }
    
    var inputType: InputType {
        _inputType
    }
    
    private var _inputType: InputType = .general {
        didSet {
            configureTextFieldAttributes(_inputType)
        }
    }
    
    // MARK: - Init Methods
    override public func commonInit() {
        let bundle = Bundle(for: HealPlainTextFieldContainer.self)
        bundle.loadNibNamed(String(describing: HealPlainTextFieldContainer.self), owner: self, options: nil)
        self.addSubview(containerView)
        addConstraintToParentView()
        
        setupView()
    }
    
    // MARK: - Setup Views
    private func addConstraintToParentView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupView() {
        
        containerTextField.borderColor = .none
        containerTextField.cornerRadius = 15
        containerTextField.layer.masksToBounds = false
        containerTextField.backgroundColor = .white
        containerTextField.shadowColor = UIColor.placeholder.cgColor
        containerTextField.shadowRadius = 2
        containerTextField.shadowOpacity = 1
        containerTextField.shadowOffset = CGSize(width: 0, height: 2)
        
        inputTextField.borderStyle = .none
        inputTextField.placeholder = "Email Or Phone Number"
        inputTextField.font = .museoSans500(ofSize: 14)
    }
    
     func configureTextFieldAttributes(_ inputType: InputType) {
        switch inputType {
        case .general:
            inputTextField.autocorrectionType = .yes
            inputTextField.leftViewMode = .never
            inputTextField.rightViewMode = .never
        case .email:
            inputTextField.autocorrectionType = .no
            inputTextField.keyboardType = .emailAddress
            inputTextField.leftViewMode = .never
        case .phone:
            inputTextField.autocorrectionType = .no
            inputTextField.keyboardType = .phonePad
//            inputTextField.delegate = self
            configureCountryPicker()
        case .password:
            inputTextField.autocorrectionType = .no
            inputTextField.isSecureTextEntry = true
            inputTextField.leftViewMode = .never
        case .name:
            inputTextField.autocorrectionType = .no
            inputTextField.keyboardType = .default
        case .date:
            inputTextField.resignFirstResponder()
            configureDatePicker(textField: inputTextField)
        case .generalPicker:
            inputTextField.autocorrectionType = .no
            configureGeneralPicker()
            createPickerView(textField: inputTextField)
            dismissPickerView(textField: inputTextField)
        default:
            break
        }
    }
     
    public func addAttributes(placeholder: String?, inputType: InputType = .general) {
        inputTextField.text = ""
        inputTextField.placeholder = placeholder
        self._inputType = inputType
        
        if let placeholder = inputTextField.placeholder {
            inputTextField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.placeholder,
                    NSAttributedString.Key.font: UIFont.museoSans500(ofSize: 14)
                ]
            )
        }
    }
    
    public func disableField() {
        inputTextField.isUserInteractionEnabled = false
    }
    
    private func configureGeneralPicker() {
        let dropDown = UIImageView(image: UIImage(named: "Dropdown"))
        let stackView = UIStackView(arrangedSubviews: [dropDown])
        stackView.isUserInteractionEnabled = false
        dropDown.contentMode = .center
        dropDown.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dropDown.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        var rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: inputTextField.frame.height))
        rightView = stackView
        
        inputTextField.rightView = rightView
        inputTextField.rightViewMode = .always
    }
    
    private func configureCountryPicker() {
//        let cp = CountryPickerView()
//        let dropDown = UIImageView(image: UIImage(named: "Dropdown"))
//        let stackView = UIStackView(arrangedSubviews: [cp, dropDown])
//        dropDown.contentMode = .center
//        dropDown.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        dropDown.heightAnchor.constraint(equalToConstant: 20).isActive = true
//
//        var leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: inputTextField.frame.height))
//        leftView = stackView
//
//        cp.setCountryByCode("MM")
//        cp.setCountryByPhoneCode("+95")
//
//        inputTextField.leftView = leftView
//        inputTextField.leftViewMode = .always
//        cpvTextField = cp
//
//        cpvTextField.showCountryCodeInView = false
//        cpvTextField.dataSource = self
//        cpvTextField.font = .museoSans500(ofSize: 14)
    }
    
    private func configureDatePicker(textField: UITextField) {
        let dropDown = UIImageView(image: UIImage(named: "date"))
        let stackView = UIStackView(arrangedSubviews: [dropDown])
        stackView.isUserInteractionEnabled = false
        dropDown.contentMode = .center
        dropDown.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dropDown.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        var rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: textField.frame.height))
        rightView = stackView
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        
        createDatePicker(textField: textField)
        dismissPickerView(textField: textField)
    }
    
    func createDatePicker(textField: UITextField) {
        datePicker = UIDatePicker()
        datePicker?.date = Date()
        datePicker?.locale = Locale.init(identifier: "en_US")
        datePicker?.datePickerMode = .date
        textField.inputView = datePicker
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
        }
        datePicker?.backgroundColor = .white
        datePicker?.addTarget(self, action: #selector(handleDateSelection), for: .valueChanged)
    }
    
    @objc func handleDateSelection() {
        guard let picker = datePicker else { return }
        inputTextField.text = picker.date.toString
    }
}

//extension HealPlainTextFieldContainer: CountryPickerViewDataSource {
//    public func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
//        return ["MM"].compactMap { countryPickerView.getCountryByCode($0)}
//    }
//    
//    public func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
//        return "Preferred Country"
//    }
//    
//    public func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
//        return "Select a Country"
//    }
//    
//    public func showPhoneCodeInList(in countryPickerView: CountryPickerView) -> Bool {
//        return true
//    }
//    
//    public func showCountryCodeInList(in countryPickerView: CountryPickerView) -> Bool {
//       return false
//    }
//    
//    public func cellLabelFont(in countryPickerView: CountryPickerView) -> UIFont {
//        return .museoSans500(ofSize: 14)
//    }
//    
////    public func cellImageViewCornerRadius(in countryPickerView: CountryPickerView) -> CGFloat {
////        return 5
////    }
//}

extension HealPlainTextFieldContainer: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row < pickerList.count {
            selectedValue = pickerList[row]
            inputTextField.text = selectedValue
        }
    }
    
    func createPickerView(textField: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        textField.inputView = pickerView
        
        textField.text = pickerList.first
    }
    
    func dismissPickerView(textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.tintColor = .mainText
        toolBar.barTintColor = .white
        toolBar.layer.cornerRadius = 30
        toolBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        toolBar.layer.masksToBounds = true
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handlePickerAction))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace, button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    func handleDoneAction(action: @escaping (Bool, String) -> Void) {
        doneAction = action
    }
    
    @objc func handlePickerAction() {
        doneAction?(true, selectedValue.orEmpty)
    }
}

//extension HealPlainTextFieldContainer: UITextFieldDelegate {
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if inputType == .phone {
//            let maxLength = 11
//            let currentString = (textField.text ?? "") as NSString
//            let newString = currentString.replacingCharacters(in: range, with: string)
//            return newString.count <= maxLength
//        } else {
//            return true
//        }
//    }
//}
