//
//  HealFlatTextFieldContainer.swift
//  heal_ios
//
//  Created by Francis Myat on 9/26/22.
//
// swiftlint: disable redundant_optional_initialization

import UIKit
//import CountryPickerView

class HealFlatTextFieldContainer: BaseCustomView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerTextField: UIView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var inputTextField: UITextField!
    
    //    weak var cpvTextField: CountryPickerView!
    
    var datePicker: UIDatePicker?
    
    var selectedValue: String?
    var textField: UITextField?
    var pickerList: [String] = []
    
    var textChanged: ((InputType, String) -> Void)? = nil
    var doneAction: ((Bool, String, InputType?) -> Void)? = nil
    var nameAction: (() -> Void)? = nil
    var isPassport: Bool? = false
    
    var textHasData: ((String, InputType?) -> Void)?
    
    var textFields: [UITextField] = []
    
    var stringArr = [String]()
    
    public var title: String? = "U"
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.mainText, for: .normal)
        button.addTarget(self, action: #selector(handleNameAction), for: .touchUpInside)
        return button
    }()
    
    var value: String? {
        inputTextField.text
    }
    
    var placeholder: String? {
        inputTextField.placeholder
    }
    
    var inputType: InputType {
        _inputType
    }
    
    var _inputType: InputType = .general {
        didSet {
            configureTextFieldAttributes(_inputType, stringArr: stringArr)
        }
    }
    
    // MARK: - Init Methods
    override public func commonInit() {
        let bundle = Bundle(for: HealFlatTextFieldContainer.self)
        bundle.loadNibNamed(String(describing: HealFlatTextFieldContainer.self), owner: self, options: nil)
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
        
        containerTextField.cornerRadius = 15
        containerTextField.layer.masksToBounds = false
        containerTextField.backgroundColor = .white
        containerTextField.borderWidth = 1
        containerTextField.borderColor = UIColor(red: 0.69, green: 0.702, blue: 0.78, alpha: 1)
        
        numberTextField.placeholder = "1"
        stateTextField.placeholder = "MAKANA"
        typeTextField.placeholder = "N"
        textFields = [numberTextField, stateTextField, typeTextField]
        textFields.forEach({
            $0.textAlignment = .center
            $0.autocorrectionType = .no
            $0.borderStyle = .none
            $0.isHidden = true
        })
        
        inputTextField.borderStyle = .none
        inputTextField.autocorrectionType = .no
        inputTextField.delegate = self
    }
    
     func configureTextFieldAttributes(_ inputType: InputType, stringArr: [String]? = []) {
        switch inputType {
        case .general:
            inputTextField.autocorrectionType = .yes
        case .email:
            inputTextField.keyboardType = .emailAddress
            inputTextField.placeholder = "Email"
        case .phone:
            inputTextField.keyboardType = .phonePad
            inputTextField.delegate = self
            configureCountryPicker()
        case .phoneCode:
            break
        case .password:
            inputTextField.isSecureTextEntry = true
        case .name:
            inputTextField.keyboardType = .default
            configureNamePicker()
        case .dob:
            inputTextField.resignFirstResponder()
            configureDatePicker(textField: inputTextField)
        case .gender:
            inputTextField.resignFirstResponder()
            pickerList = ["Male", "Female"]
            configurePicker(textField: inputTextField)
        case .maritalStatus:
            inputTextField.resignFirstResponder()
            pickerList = ["Single", "Married"]
            configurePicker(textField: inputTextField)
        case .nationality:
            inputTextField.resignFirstResponder()
            pickerList = stringArr ?? []
            configurePicker(textField: inputTextField)
        case .country:
            inputTextField.resignFirstResponder()
            pickerList = stringArr ?? []
            configurePicker(textField: inputTextField)
        case .state:
            inputTextField.resignFirstResponder()
            pickerList = stringArr ?? []
            inputTextField.isUserInteractionEnabled = !pickerList.isEmpty
            configurePicker(textField: inputTextField)
        case .city:
            inputTextField.resignFirstResponder()
            pickerList = stringArr ?? []
            inputTextField.isUserInteractionEnabled = !pickerList.isEmpty
            configurePicker(textField: inputTextField)
        case .township:
            inputTextField.resignFirstResponder()
            pickerList = stringArr ?? []
            inputTextField.isUserInteractionEnabled = !pickerList.isEmpty
            configurePicker(textField: inputTextField)
        case .idType:
            inputTextField.resignFirstResponder()
            pickerList = ["NRC", "Passport"]
            configurePicker(textField: inputTextField)
        case .idNo:
            inputTextField.autocorrectionType = .no
            textFields.forEach({
                $0.isHidden = false
                $0.resignFirstResponder()
                $0.delegate = self
                if $0 == stateTextField {
                    $0.isUserInteractionEnabled = false
                }
                configurePicker(textField: $0)
            })
            inputTextField.delegate = self
        case .hrn:
            inputTextField.keyboardType = .default
        case .address:
            inputTextField.keyboardType = .default
        case .contactPerson:
            inputTextField.keyboardType = .default
        case .contactNumber:
            inputTextField.keyboardType = .phonePad
            inputTextField.delegate = self
            configureCountryPicker()
        default:
            break
        }
    }
    
    public func disableField() {
        inputTextField.isUserInteractionEnabled = false
        numberTextField.isUserInteractionEnabled = false
        stateTextField.isUserInteractionEnabled = false
        typeTextField.isUserInteractionEnabled = false
    }
    
    func hideTextFields(isPassport: Bool) {
        if isPassport {
            numberTextField.isHidden = true
            stateTextField.isHidden = true
            typeTextField.isHidden = true
        }
    }
    
    public func addAttributes(text: String? = "", placeholder: String?, stringArr: [String] = [], isIdNo: Bool = false, inputType: InputType? = .none, isPersonalDetailPage: Bool? = false, isDoneButtonPressedFromPersonalDetailPage: Bool? = false) {
        if isIdNo {
            if text?.contains("/") == true && text?.contains("(") == true && text?.contains(")") == true {
                let arr = text?.components(separatedBy: ["/", "(", ")"])
                numberTextField.text = arr?[0]
                stateTextField.text = arr?[1]
                typeTextField.text = arr?[2]
                inputTextField.text = arr?[3]
            } else {
                inputTextField.text = text
            }
        } else {
            switch inputType {
            case .state, .city, .township:
                if stringArr.isEmpty {
                    inputTextField.text = nil
                } else if isPersonalDetailPage! && isDoneButtonPressedFromPersonalDetailPage! {
                    inputTextField.text = stringArr.first
                    self.textHasData?(stringArr.first.orEmpty, inputType)
                } else if isPersonalDetailPage! {
                    inputTextField.text = text
                } else {
                    inputTextField.text = stringArr.first ?? text.orEmpty
                    self.textHasData?(stringArr.first.orEmpty, inputType)
                }
            default:
                inputTextField.text = text.orEmpty
            }
        }
        
        inputTextField.placeholder = placeholder
        self.stringArr = stringArr
        
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
    
    private func configureNamePicker() {
        button.setTitle(title ?? "U", for: .normal)
        let dropDown = UIImageView(image: UIImage(named: "Dropdown"))
        let stackView = UIStackView(arrangedSubviews: [button, dropDown])
        dropDown.contentMode = .center
        dropDown.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dropDown.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        var leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: inputTextField.frame.height))
        leftView = stackView
        
        inputTextField.leftView = leftView
        inputTextField.leftViewMode = .always
    }
    
    func handleTitleAction(action: @escaping () -> Void) {
        nameAction = action
    }
    
    @objc func handleNameAction() {
        nameAction?()
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
        //        cpvTextField.delegate = self
        //        cpvTextField.font = .museoSans500(ofSize: 14)
    }
    
    private func configurePicker(textField: UITextField) {
        let dropDown = UIImageView(image: UIImage(named: "Dropdown"))
        let stackView = UIStackView(arrangedSubviews: [dropDown])
        stackView.isUserInteractionEnabled = false
        dropDown.contentMode = .center
        dropDown.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dropDown.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        var rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: textField.frame.height))
        rightView = stackView
        
        textField.rightView = rightView
        textField.rightViewMode = .always
        
        createPickerView(textField: textField)
        dismissPickerView(textField: textField)
        
        load()
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
        datePicker?.maximumDate = Date()
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

extension HealFlatTextFieldContainer: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField = textField
        
        switch textField {
        case numberTextField:
            pickerList = getStates()
            textField.text = textField.text?.isEmpty ?? false ? pickerList.first : textField.text
        case stateTextField:
            pickerList = getCodes()
            textField.text = textField.text?.isEmpty ?? false ? pickerList.first : textField.text
        case typeTextField:
            pickerList = getTypes()
            textField.text = textField.text?.isEmpty ?? false ? pickerList.first : textField.text
        case inputTextField:
            //            switch inputType {
            //            case .state, .city, .township:
            ////                inputTextField.isUserInteractionEnabled = !pickerList.isEmpty
            //                if pickerList.isEmpty {
            //                    inputTextField.isUserInteractionEnabled = false
            //                } else {
            //                    inputTextField.isUserInteractionEnabled = true
            //                }
            //            default: break
            //            }
            if pickerList != getStates(), pickerList != getCodes(), pickerList != getTypes() {
                textField.text = textField.text?.isEmpty ?? false ? pickerList.first : textField.text
            }
        default:
            break
        }
    }
    
    func handleTextChanged(action: @escaping (InputType, String) -> Void) {
        textChanged = action
    }
    
    func handleTextHasDataAction(action: @escaping(String, InputType?) -> Void) {
        textHasData = { selectedValue, inputType in
            debugPrint("Selected Value = \(selectedValue)")
        }
        textHasData = action
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        stateTextField.isUserInteractionEnabled = numberTextField.text != "" ? true : false
        switch textField {
        case numberTextField:
            textChanged?(.nrcNo, textField.text.orEmpty)
        case stateTextField:
            textChanged?(.nrcState, textField.text.orEmpty)
        case typeTextField:
            textChanged?(.nrcType, textField.text.orEmpty)
        default:
            if inputType == .idType {
                // MARK: TODO change passport textfield
                textChanged?(inputType, textField.text.orEmpty)
            } else {
                textChanged?(inputType, textField.text.orEmpty)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if inputType == .phone || inputType == .contactNumber {
            let maxLength = 11
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            return newString.count <= maxLength
        } else {
            return true
        }
    }
}

extension HealFlatTextFieldContainer: UIPickerViewDataSource, UIPickerViewDelegate {
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
        selectedValue = pickerList[row]
        self.textField?.text = selectedValue
    }
    
    func createPickerView(textField: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.backgroundColor = .white
        textField.inputView = pickerView
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
    
    func handleDoneAction(action: @escaping (Bool, String, InputType?) -> Void) {
        doneAction = action
    }
    
    @objc func handlePickerAction() {
        doneAction?(true, selectedValue ?? pickerList.first.orEmpty, inputType)
        selectedValue = nil
    }
}

//extension HealFlatTextFieldContainer: CountryPickerViewDelegate {
//    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
//        textChanged?(.phoneCode, country.phoneCode)
//    }
//}

//extension HealFlatTextFieldContainer: CountryPickerViewDataSource {
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
//        return false
//    }
//
//    public func cellLabelFont(in countryPickerView: CountryPickerView) -> UIFont {
//        return .museoSans500(ofSize: 14)
//    }
//}
