//
//  RegisterRowSection.swift
//  heal_ios
//
//  Created by Francis Myat on 10/3/22.
//

import Foundation

enum RegisterSection {
    case identification, basic, address, emergency
}

enum RegisterRow: String {
    case phone              = "Phone Number"
    case email              = "Email Address"
    case dob                = "Date of Birth"
    case idType             = "ID Type"
    case idNo               = "ID Number"
    case name               = "Name"
    case hrn                = "HRN"
    case gender             = "Gender"
    case marital            = "Marital Status"
    case nationality        = "Nationality"
    case country            = "Country"
    case state              = "State"
    case city               = "City"
    case township           = "Township"
    case address            = "Address"
    case emergencyPerson    = "Emergency Contact Person"
    case emergencyNo        = "Emergency Contact Number"
}

public enum InputType: String {
    case general            = "input"
    case email              = "email"
    case phone              = "phoneNo"
    case phoneCode            
    case password           = "Password"
    case name               = "name"
    case hrn                = "hrn"
    case dob                = "dob"
    case gender             = "gender"
    case maritalStatus      = "maritalStatus"
    case nationality        = "nationality"
    case country            = "country"
    case state              = "state"
    case city               = "city"
    case township           = "township"
    case address            = "address"
    case contactPerson      = "emergencyContactperson"
    case contactNumber      = "emergencyContactno"
    case idType             = "idType"
    case idNo               = "idNo"
    case nrcNo
    case nrcState
    case nrcType
    case date
    case generalPicker
}
