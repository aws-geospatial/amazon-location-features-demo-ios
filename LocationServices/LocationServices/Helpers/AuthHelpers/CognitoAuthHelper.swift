import Foundation
import AWSSDKIdentity
import AmazonLocationiOSAuthSDK
import AWSLocation
import AwsCommonRuntimeKit

public class CognitoAuthHelper {

    private static var _sharedInstance: CognitoAuthHelper?
    var locationClient: LocationClient?
    
    private init() {
    }
    
    static func initialise(identityPoolId: String) async throws {
        let region = identityPoolId.toRegionString()
        _sharedInstance = CognitoAuthHelper()

        if let credentialsString = KeyChainHelper.get(key: .cognitoCredentials),
           let credentials = CognitoCredentials.decodeCognitoCredentials(jsonString: credentialsString) {
            
            var resolver: StaticAWSCredentialIdentityResolver?
                let credentialsIdentity = AWSCredentialIdentity(accessKey: credentials.accessKeyId, secret: credentials.secretKey, expiration: credentials.expiration, sessionToken: credentials.sessionToken)
                resolver = try StaticAWSCredentialIdentityResolver(credentialsIdentity)
            let locationClientConfig = try await LocationClient.LocationClientConfiguration(awsCredentialIdentityResolver: resolver, region: region, signingRegion: region)
            _sharedInstance?.locationClient = LocationClient(config: locationClientConfig)
        }
    }
    
//    public func initialiseLocationClient() async throws {
//        if let credentials = locationProvider.getCognitoProvider()?.getCognitoCredentials() {
//            self.credentials = credentials
//            try await setLocationClient(accessKey: credentials.accessKeyId, secret: credentials.secretKey, expiration: credentials.expiration, sessionToken: credentials.sessionToken)
//        }
//    }
//    
//    public func setLocationClient(accessKey: String, secret: String, expiration: Date?, sessionToken: String?) async throws {
//        let identity = AWSCredentialIdentity(accessKey: accessKey, secret: secret, expiration: expiration, sessionToken: sessionToken)
//        let resolver =  try StaticAWSCredentialIdentityResolver(identity)
//        let cachedResolver: CachedAWSCredentialIdentityResolver? = try CachedAWSCredentialIdentityResolver(source: resolver, refreshTime: 3540)
//        let clientConfig = try await LocationClient.LocationClientConfiguration(awsCredentialIdentityResolver: cachedResolver, region: locationProvider.getRegion(), signingRegion: locationProvider.getRegion())
//        
//        self.locationClient = LocationClient(config: clientConfig)
//    }
    

//    
//    static func initialise(credentialsProvider: CredentialsProvider, region: String) async throws {
//        _sharedInstance = CognitoAuthHelper()
//        _sharedInstance?.authHelper = AuthHelper()
//        _sharedInstance?.locationCredentialsProvider = try await _sharedInstance?.authHelper?.authenticateWithCredentialsProvider(credentialsProvider: credentialsProvider, region: region)
//        _sharedInstance?.amazonLocationClient = _sharedInstance?.authHelper?.getLocationClient()
//        try await _sharedInstance?.amazonLocationClient?.initialiseLocationClient()
//    }
//    
    static func `default`() -> CognitoAuthHelper {
        return _sharedInstance!
    }
}
