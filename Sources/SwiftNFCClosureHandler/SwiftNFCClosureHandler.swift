//
//  NFCHandler.swift
//  NFCReaderExample
//

import Foundation
import CoreNFC

@available(iOS 13.0, *)

protocol NFCReaderDelegate {
    func didReceive(payload: String)
}


@available(iOS 13.0, *)
public class SwiftNFCClosureHandler: NSObject, ObservableObject {
    var session: NFCNDEFReaderSession?
    var delegate: NFCReaderDelegate?
    var scanned_action: ((Data) -> Void)?
    
    public func begin(action: @escaping ((Data) -> Void)) {
        self.scanned_action = action
        session = NFCNDEFReaderSession(delegate: self,
                                       queue: DispatchQueue.main,
                                       invalidateAfterFirstRead: false)
        session?.begin()
    }
}


extension SwiftNFCClosureHandler: NFCNDEFReaderSessionDelegate {
    public func readerSession(_ session: NFCNDEFReaderSession,
                       didDetectNDEFs messages: [NFCNDEFMessage]) {
        DispatchQueue.main.async {
            messages.forEach { message in
                message.records.forEach { record in
                    if let string = String(data: record.payload, encoding: .ascii) {
                        self.delegate?.didReceive(payload: string)
                        
                        session.invalidate()
                        
                        self.scanned_action!(record.payload)
                    }
                }
            }
        }
    }
    public func readerSession(_ session: NFCNDEFReaderSession,
                       didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
    public func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        print(">> readerSessionDidBecomeActive")
    }

}
