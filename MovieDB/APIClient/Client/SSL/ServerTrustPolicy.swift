//
//  SecuredKeys.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//
import Alamofire
import Foundation

class ServerTrustPolicy {
    
    static var session: Session = {
        let serverTrustPolicies : [String: PublicKeysTrustEvaluator] = [
            BaseURL.host ?? BaseURL.absoluteString : PublicKeysTrustEvaluator(keys: ServerTrustPolicy.publicSecuredKeys, performDefaultValidation: true, validateHost: true)
        ]
        return Session(configuration: URLSessionConfiguration.default, serverTrustManager: ServerTrustPolicy.publicSecuredKeys.count > 0 ? ServerTrustManager(evaluators: serverTrustPolicies) : nil)
    }()
    
    private static var publicSecuredKeys: [SecKey] {
        guard let publicKey = Bundle(for: WebClient.self).object(forInfoDictionaryKey: "PublicKey") as? String, publicKey != "NONE" else { return [] }

        guard let certificateData = Data(base64Encoded: publicKey, options: []),
              let certificate = SecCertificateCreateWithData(nil, certificateData as CFData) else { return [] }

        var trust: SecTrust?
        let policy = SecPolicyCreateBasicX509()
        let status = SecTrustCreateWithCertificates(certificate, policy, &trust)

        guard status == errSecSuccess, let secTrust = trust,
                let publicSecKey = SecTrustCopyKey(secTrust) else { return [] }

        return [publicSecKey]
    }
}

