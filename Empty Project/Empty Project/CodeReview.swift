//
//  CodeReview.swift
//  Empty Project
//
//  Created by Dana Palazzo on 1/26/21.
//

import Foundation

struct Patron {
    var uuid: String
    var imageUrl: String
    var idType: String
    var idValue: String
}

struct Item {
    var uuid: String
    var status: String
    var imageUrl: String
    var location: String?
    var tagNumber: String
    var tagColor: String
    var tagCode: String
}

struct Checkin: Item {
    var uuid: String
    var patron: Patron
    var items: [Item]
    var createdAt: String
    var syncedAt: String?
    
    var isSynced: Bool {
        if syncedAt {
            return true
        }
    }
}

class CheckinViewController: UIViewController {
    var checkin: Checkin?
    
    @IBOutlet weak var completeButton: UIButton?
    @IBAction func completeExchange() {
        // CANDIDATE TODO: Display a new screen here with the checkin data
    }
    
    override func viewDidLoad() {
        self.completeButton?.isEnabled = false
    }
    
}

extension CheckinViewController: FormDelegate {
    func updateFormFields(idType: String, idValue: String, itemStatus: String, itemImageUrl: String, itemTagNumber: String, itemTagColor: String, itemTagCode: String) {
        self.checkin = Checkin(uuid: NSUUID().uuidString, patron: Patron.init(uuid: NSUUID().uuidString, imageUrl: "", idType: "", idValue: ""), items: [], createdAt: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short))
        self.checkin?.patron.idType = idType
        self.checkin!.patron.idValue = idValue
        let bag = Item(uuid: NSUUID().uuidString, status: itemStatus, imageUrl: itemImageUrl, tagNumber: itemTagNumber, tagColor: itemTagColor, tagCode: itemTagCode)
        self.checkin?.items.append(bag)
        self.updateCompleteButton(true)
    }
    
    func updateCompleteButton(_ enable: Bool) {
        if enable {
            self.completeButton?.isEnabled = true
        }
    }
}

protocol FormDelegate {
    func updateFormFields(idType: String, idValue: String, itemStatus: String, itemImageUrl: String, itemTagNumber: Int, itemTagColor: String, itemTagCode: String)
}
    

