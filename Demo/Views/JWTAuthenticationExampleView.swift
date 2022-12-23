//
//  JWTAuthenticationExampleView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 12/12/22.
//

import SwiftUI


struct LoginScreen: View {
    
    @EnvironmentObject
    var mainVm: MainViewModel
    @State   var login = ""
    @State
    var password = ""
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    Image("soft")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 135)
                        .padding(.top, 74)
                    VStack(spacing: 0) {
                        Text("Sign in")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        HStack {
                            Text("Login")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        TextField("", text: $login.animation())
                            .foregroundColor(.black)
                            .disabled(mainVm.loginPending)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 1)
                                .opacity(0.5))
                            .padding(.top, 4)
                        
                        
                        HStack {
                            Text("Password")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 12)
                        SecureField("", text: $password)
                            .foregroundColor(.black)
                            .font(Font.custom("montserrat-medium", size: 17))
                            .disabled(mainVm.loginPending)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 1)
                                .opacity(0.5))
                            .padding(.top, 4)
                        
                        if mainVm.loginPending {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                .scaleEffect(1.2)
                                .padding(.top, 26)
                        } else {
                            Button {
                                hideKeyboard()
                                if login.isEmpty {
                                    mainVm.alert = IdentifiableAlert.build(id: "empty_login",
                                                                           title: "Invalid login",
                                                                           message: "Login can't be empty")
                                    return
                                }
                                if password.count < 4 {
                                    mainVm.alert = IdentifiableAlert.build(id: "empty_login",
                                                                           title: "Invalid password",
                                                                           message: "Password lenght must be 4 or more characters")
                                    return
                                }
                                mainVm.login(login: login, password: password)
                            } label: {
                                Text("Authorize")
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)
                                    .padding(.vertical, 12)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black)
                            }
                            .disabled(mainVm.loginPending)
                            .cornerRadius(10)
                            .padding(.top, 26)
                            .padding(.horizontal, 24)
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .padding(.horizontal, 40)
                    .padding(.top, 70)
                    
                    NavigationLink(destination: RegisterScreen()) {
                        Text("Register")
                            .fontWeight(.bold)
                    }
                    .padding(.top, 12)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationBarTitle("Authorization", displayMode: .inline)
        .background(Color.white.ignoresSafeArea())
        .alert(item: $mainVm.alert) { alert in
            alert.alert()
        }
    }
}
struct JWTAuthenticationExampleView: View {
    @StateObject
    var mainVm = MainViewModel()
    
    var body: some View {
        NavigationView {
            if mainVm.showAuthContainer {
                LoginScreen()
            } else {
                DevsScreen()
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(mainVm)
        .navigationBarTitle("", displayMode: .inline)
        .preferredColorScheme(.light)
    }

}

struct JWTAuthenticationExampleView_Previews: PreviewProvider {
    static var previews: some View {
        JWTAuthenticationExampleView()
    }
}

struct AuthBody: Codable {
    let login: String
    let password: String
}

struct Developer: Codable {
    let id: Int64
    let name: String
    let department: String
}
struct ErrorResponse: Codable {
    let code: Int
    let message: String
    
    func isAuth() -> Bool {
        return Errors.isAuthError(err: message)
    }
}
struct TokenInfo {
    let token: String
    let expiresAt: Int64
}
struct TokensInfo: Codable {
    let accessToken: String
    let accessTokenExpire: Int64
    let refreshToken: String
    let refreshTokenExpire: Int64
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case accessTokenExpire = "access_token_expire"
        case refreshToken = "refresh_token"
        case refreshTokenExpire = "refresh_token_expire"
    }
}



struct User: Codable {
    let id: Int64
    let accessToken: String
    let accessTokenExpire: Int64
    let refreshToken: String
    let refreshTokenExpire: Int64
    
    enum CodingKeys: String, CodingKey {
        case id
        case accessToken = "access_token"
        case accessTokenExpire = "access_token_expire"
        case refreshToken = "refresh_token"
        case refreshTokenExpire = "refresh_token_expire"
    }
    
    func getTokensInfo() -> TokensInfo {
        return TokensInfo(accessToken: accessToken,
                          accessTokenExpire: accessTokenExpire,
                          refreshToken: refreshToken,
                          refreshTokenExpire: refreshTokenExpire)
    }
}

import Foundation

enum Endpoint {
    
    static let baseURL: String  = "https://lev.customapp.tech/"

    case register
    case login
    case refreshTokens
    case getDevelopers
    
    func path() -> String {
        switch self {
        case .register:
            return "api/register"
        case .login:
            return "api/login"
        case .refreshTokens:
            return "api/refresh_tokens"
        case .getDevelopers:
            return "api/get_devs"
        }
    }
    
    var absoluteURL: URL {
        URL(string: Endpoint.baseURL + self.path())!
    }
}
struct DevsScreen: View {
    
    @EnvironmentObject
    var mainVm: MainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            switch mainVm.devsProgress {
            case .finished:
                ZStack {
                    VStack(spacing: 0) {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(mainVm.developers, id: \.id) { dev in
                                    DeveloperCard(developer: dev)
                                }
                            }
                            .padding(.vertical, 14)
                        }
                    }
                    VStack {
                        Spacer()
                        Button {
                            mainVm.getDevelopers()
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.white)
                                .frame(width: 30, height: 30)
                                .padding(10)
                                .background(Circle().fill(Color.black))
                                .padding(.bottom, 20)
                        }
                        .opacity(0.9)
                    }
                }
            case .error:
                Spacer()
                Text("An error occurred while loading data")
                    .padding(.horizontal, 24)
                Button {
                    mainVm.getDevelopers()
                } label: {
                    Text("Retry")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 50)
                        .background(Color.black)
                }
                .cornerRadius(10)
                .padding(.top, 16)
                .padding(.horizontal, 24)
                Spacer()
            case .notStarted, .loading:
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    .scaleEffect(1.6)
                    .padding(.top, 26)
                Spacer()
            }
        }
        .navigationBarTitle("Developers", displayMode: .inline)
        .toolbar {
            Button("Logout") {
                mainVm.logout()
            }
        }
        .background(Color.white.ignoresSafeArea())
        .alert(item: $mainVm.alert) { alert in
            alert.alert()
        }
        .onAppear {
            if mainVm.developers.isEmpty {
                mainVm.getDevelopers()
            }
        }
    }
}

struct DeveloperCard: View {
    
    var developer: Developer
    
    var body: some View {
        HStack(spacing: 0) {
            Image("soft")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 40)
                .padding(10)
                .background(Color.black)
                .cornerRadius(8)
            Spacer()
            VStack(spacing: 14) {
                Text(developer.name)
                    .fontWeight(.bold)
                Text(developer.department)
                    .fontWeight(.bold)
                    .foregroundColor(departmentColor)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding(.horizontal, 20)
    }
    
    var departmentColor: Color {
        switch developer.department {
        case "Backend":
            return .teal
        case "Frontend":
            return .orange
        case "Mobile":
            return .indigo
        case "Design":
            return .red
        default:
            return .black
        }
    }
}


class MainViewModel: ObservableObject {
    
    @Published
    var showAuthContainer = true
    
    @Published var loginPending = false
    @Published  var registerPending = false
    
    @Published var devsProgress: LoadingState = .notStarted
    @Published var developers: [Developer] = []
    
    @Published var alert: IdentifiableAlert?
    
    init() {
        let refreshToken = UserDefaultsWorker.shared.getRefreshToken()
        if !refreshToken.token.isEmpty && refreshToken.expiresAt > Date().timestampMillis() {
            showAuthContainer = false
        }
    }
    
    func logout() {
        UserDefaultsWorker.shared.dropTokens()
        Requester.shared.dropTokens()
        withAnimation {
            showAuthContainer = true
        }
    }
    
    func login(login: String, password: String) {
        withAnimation {
            loginPending = true
        }
        print("login called")
        DispatchQueue.global(qos: .userInitiated).async {
            Requester.shared.login(authBody: AuthBody(login: login, password: password)) { [self] result in
                print("login response: \(result)")
                withAnimation {
                    loginPending = false
                }
                switch result {
                case .success(_):
                    // do something with user
                    withAnimation {
                        self.showAuthContainer = false
                    }
                case .serverError(let err):
                    alert = IdentifiableAlert.buildForError(id: "login_server_err", message: Errors.messageFor(err: err.message))
                case .networkError(_):
                    alert = IdentifiableAlert.networkError()
                case .authError(let err):
                    alert = IdentifiableAlert.buildForError(id: "login_err", message: Errors.messageFor(err: err.message))
                }
            }
        }
    }
    
    func register(login: String, password: String) {
        withAnimation {
            registerPending = true
        }
        print("register called")
        DispatchQueue.global(qos: .userInitiated).async {
            Requester.shared.register(authBody: AuthBody(login: login, password: password)) { [self] result in
                print("register response: \(result)")
                withAnimation {
                    registerPending = false
                }
                switch result {
                case .success(_):
                    // do something with user
                    withAnimation {
                        self.showAuthContainer = false
                    }
                case .serverError(let err):
                    alert = IdentifiableAlert.buildForError(id: "login_server_err", message: Errors.messageFor(err: err.message))
                case .networkError(_):
                    alert = IdentifiableAlert.networkError()
                case .authError(let err):
                    alert = IdentifiableAlert.buildForError(id: "login_err", message: Errors.messageFor(err: err.message))
                }
            }
        }
    }
    
    func getDevelopers() {
        withAnimation {
            devsProgress = .loading
        }
        print("get devs called")
        DispatchQueue.global(qos: .userInitiated).async {
            Requester.shared.getDevelopers() { [self] result in
                print("get devs response: \(result)")
                withAnimation {
                    registerPending = false
                }
                switch result {
                case .success(let devs):
                    withAnimation {
                        developers = devs
                        devsProgress = .finished
                    }
                case .serverError(let err):
                    withAnimation {
                        devsProgress = .error
                    }
                    alert = IdentifiableAlert.buildForError(id: "devs_server_err", message: Errors.messageFor(err: err.message))
                case .networkError(_):
                    withAnimation {
                        devsProgress = .error
                    }
                    alert = IdentifiableAlert.networkError()
                case .authError(_):
                    withAnimation {
                        self.showAuthContainer = true
                    }
                }
            }
        }
    }
}



struct RegisterScreen: View {
    
    @EnvironmentObject
    var mainVm: MainViewModel
    
    @State
    var login = ""
    @State
    var password = ""
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    Image("soft")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 135)
                        .padding(.top, 60)
                    VStack(spacing: 0) {
                        Text("Sign up")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        HStack {
                            Text("Login")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        TextField("", text: $login.animation())
                            .foregroundColor(.black)
                            .disabled(mainVm.registerPending)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 1)
                                .opacity(0.5))
                            .padding(.top, 4)
                        
                        
                        HStack {
                            Text("Password")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 12)
                        SecureField("", text: $password)
                            .foregroundColor(.black)
                            .font(Font.custom("montserrat-medium", size: 17))
                            .disabled(mainVm.registerPending)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 1)
                                .opacity(0.5))
                            .padding(.top, 4)
                        
                        if mainVm.loginPending {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                .scaleEffect(1.4)
                                .padding(.top, 26)
                        } else {
                            Button {
                                hideKeyboard()
                                if login.isEmpty {
                                    mainVm.alert = IdentifiableAlert.build(id: "empty_login",
                                                                           title: "Invalid login",
                                                                           message: "Login can't be empty")
                                    return
                                }
                                if password.count < 4 {
                                    mainVm.alert = IdentifiableAlert.build(id: "empty_login",
                                                                           title: "Invalid password",
                                                                           message: "Password lenght must be 4 or more characters")
                                    return
                                }
                                mainVm.register(login: login, password: password)
                            } label: {
                                Text("Register")
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)
                                    .padding(.vertical, 12)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black)
                            }
                            .disabled(mainVm.registerPending)
                            .cornerRadius(10)
                            .padding(.top, 26)
                            .padding(.horizontal, 24)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .padding(.horizontal, 40)
                    .padding(.top, 80)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .navigationBarTitle("Registration", displayMode: .inline)
        .background(Color.white.ignoresSafeArea())
        .alert(item: $mainVm.alert) { alert in
            alert.alert()
        }
    }
}



struct IdentifiableAlert: Identifiable {
    var id: String
    var alert: () -> Alert
    
    static func build(id: String, title: String, message: String) -> IdentifiableAlert {
        return IdentifiableAlert(id: id, alert: {
            Alert(
                title: Text(LocalizedStringKey(title)),
                message: Text(message)
            )
        })
    }
    
    static func buildForError(id: String, message: String) -> IdentifiableAlert {
        return IdentifiableAlert(id: id, alert: {
            Alert(
                title: Text("An error has occured"),
                message: Text(message)
            )
        })
    }
    
    static func networkError() -> IdentifiableAlert {
        return buildForError(id: "network_err", message: "Please check your internet connection and try again")
    }
}




class UserDefaultsWorker {
    
    static let shared = UserDefaultsWorker()

    private static let KEY_ACCESS_TOKEN = "auth_token"
    private static let KEY_ACCESS_TOKEN_EXPIRE = "auth_token_expire"
    private static let KEY_REFRESH_TOKEN = "refresh_token"
    private static let KEY_REFRESH_TOKEN_EXPIRE = "refresh_token_expire"
    
    func saveAuthTokens(tokens: TokensInfo) {
        let defaults = UserDefaults.standard
        defaults.set(tokens.accessToken, forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN)
        defaults.set(tokens.accessTokenExpire, forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN_EXPIRE)
        defaults.set(tokens.refreshToken, forKey: UserDefaultsWorker.KEY_REFRESH_TOKEN)
        defaults.set(tokens.refreshTokenExpire, forKey: UserDefaultsWorker.KEY_REFRESH_TOKEN_EXPIRE)
    }
    
    func getAccessToken() -> TokenInfo {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN) as? String ?? ""
        let expiresAt = defaults.object(forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN_EXPIRE) as? Int64 ?? 0
        return TokenInfo(token: token, expiresAt: expiresAt)
    }
    
    func getRefreshToken() -> TokenInfo {
        let defaults = UserDefaults.standard
        let token = defaults.object(forKey: UserDefaultsWorker.KEY_REFRESH_TOKEN) as? String ?? ""
        let expiresAt = defaults.object(forKey: UserDefaultsWorker.KEY_REFRESH_TOKEN_EXPIRE) as? Int64 ?? 0
        return TokenInfo(token: token, expiresAt: expiresAt)
    }
    
    func haveAuthTokens() -> Bool {
        return !getAccessToken().token.isEmpty && !getRefreshToken().token.isEmpty
    }
    
    func dropTokens() {
        let defaults = UserDefaults.standard
        defaults.set("", forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN)
        defaults.set(0 as Int64, forKey: UserDefaultsWorker.KEY_ACCESS_TOKEN_EXPIRE)
        defaults.set("", forKey: UserDefaultsWorker.KEY_REFRESH_TOKEN)
        defaults.set(0 as Int64, forKey: UserDefaultsWorker.KEY_REFRESH_TOKEN_EXPIRE)
    }
}



enum LoadingState {
    case notStarted
    case loading
    case finished
    case error
}


class Requester {
    
    static let shared = Requester()
    static private let ACCESS_TOKEN_LIFE_THRESHOLD_SECONDS: Int64 = 10
    
    private var accessToken = UserDefaultsWorker.shared.getAccessToken()
    private var refreshToken = UserDefaultsWorker.shared.getRefreshToken()
    
    private init() {}
    
    private func onTokensRefreshed(tokens: TokensInfo) {
        UserDefaultsWorker.shared.saveAuthTokens(tokens: tokens)
        accessToken = TokenInfo(token: tokens.accessToken, expiresAt: tokens.accessTokenExpire)
        refreshToken = TokenInfo(token: tokens.refreshToken, expiresAt: tokens.refreshTokenExpire)
    }
    
    func dropTokens() {
        accessToken = TokenInfo(token: "", expiresAt: 0)
        refreshToken = TokenInfo(token: "", expiresAt: 0)
    }
    
    private func formRequest(url: URL,
                     data: Data = Data(),
                     method: String = "POST",
                     contentType: String = "application/json",
                     refreshTokens: Bool = false,
                     ignoreJwtAuth: Bool = false) -> URLRequest {
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        request.httpMethod = method
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        if refreshTokens {
            request.addValue("Bearer \(refreshToken.token)", forHTTPHeaderField: "Authorization")
        } else if !accessToken.token.isEmpty && !ignoreJwtAuth {
            request.addValue("Bearer \(accessToken.token)", forHTTPHeaderField: "Authorization")
            
        }
        return request
    }
    
    private func formRefreshTokensRequest() -> URLRequest {
        return formRequest(url: Endpoint.refreshTokens.absoluteURL, refreshTokens: true)
    }
    
    private func renewAuthHeader(request: URLRequest) -> URLRequest {
        var newRequest = request
        newRequest.setValue("Bearer \(accessToken.token)", forHTTPHeaderField: "Authorization")
        return newRequest
    }
    
    private func handleAuthResponse(response: Result2<User>, onResult: @escaping (Result2<User>) -> Void) {
        if case .success(let user) = response {
            self.onTokensRefreshed(tokens: user.getTokensInfo())
        }
        onResult(response)
    }
    
    func register(authBody: AuthBody, onResult: @escaping (Result2<User>) -> Void) {
        let url = Endpoint.register.absoluteURL
        let body = try! JSONEncoder().encode(authBody) //TODO: handle serializaztion error
        let request = formRequest(url: url, data: body, method: "POST", ignoreJwtAuth: true)
        self.doRequest(request: request) { [self] result in
            self.handleAuthResponse(response: result, onResult: onResult)
        }
    }
    
    func login(authBody: AuthBody, onResult: @escaping (Result2<User>) -> Void) {
        let url = Endpoint.login.absoluteURL
        let body = try! JSONEncoder().encode(authBody) //TODO: handle serializaztion error
        let request = formRequest(url: url, data: body, method: "POST", ignoreJwtAuth: true)
        self.doRequest(request: request) { [self] result in
            self.handleAuthResponse(response: result, onResult: onResult)
        }
    }
    
    func getDevelopers(onResult: @escaping (Result2<[Developer]>) -> Void) {
        let url = Endpoint.getDevelopers.absoluteURL
        let request = formRequest(url: url, data: Data(), method: "GET")
        self.request(request: request, onResult: onResult)
    }
    
    private var needReAuth: Bool {
        let current = Date().timestampMillis()
        let expires = accessToken.expiresAt
        return current + Requester.ACCESS_TOKEN_LIFE_THRESHOLD_SECONDS > expires
    }
    
    func request<T: Decodable>(request: URLRequest, onResult: @escaping (Result2<T>) -> Void) {
        print("request called")
        if (needReAuth && !refreshToken.token.isEmpty) {
            print("need to re-auth")
            authAndDoRequest(request: request, onResult: onResult)
        } else {
            print("no need to re-auth")
            doRequest(request: request, onResult: onResult)
        }
    }
    
    func authAndDoRequest<T: Decodable>(request: URLRequest, onResult: @escaping (Result2<T>) -> Void) {
        print("authAndDoRequest " + (request.url?.absoluteString ?? ""))
        let refreshRequest = formRefreshTokensRequest()
        let task = URLSession.shared.dataTask(with: refreshRequest) { [self] (data, response, error) -> Void in
            if let error = error {
                print("error refresh tokens: ", error)
                DispatchQueue.main.async { onResult(.networkError(error.localizedDescription)) }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                //should never happen
                DispatchQueue.main.async {
                    onResult(.authError(ErrorResponse(code: 0, message: Errors.ERR_CONVERTING_TO_HTTP_RESPONSE)))
                }
                return
            }
            guard let data = data else {
                //should never happen
                DispatchQueue.main.async {
                    onResult(.authError(ErrorResponse(code: httpResponse.statusCode, message: Errors.ERR_NIL_BODY)))
                }
                return
            }
            if httpResponse.isSuccessful() {
                do {
                    let response = try JSONDecoder().decode(TokensInfo.self, from: data)
                    print("parsed refresh response: \(response)")
                    onTokensRefreshed(tokens: response)
                    print("saved new tokens, now doing request: \(request.url?.absoluteString ?? "")")
                    let newRequest = renewAuthHeader(request: request)
                    doRequest(request: newRequest, onResult: onResult)
                    return
                } catch {
                    DispatchQueue.main.async {
                        //should never happen
                        onResult(.authError(ErrorResponse(code: 0, message: Errors.ERR_PARSE_RESPONSE)))
                    }
                    return
                }
            } else {
                print("refresh tokens not successful")
                do {
                    let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    print("error refresh tokens: ", errorResponse)
                    DispatchQueue.main.async {
                        onResult(.authError(errorResponse))
                    }
                    return
                } catch {
                    DispatchQueue.main.async {
                        onResult(.authError(ErrorResponse(code: 0, message: error.localizedDescription)))
                    }
                    return
                }
            }
        }
        task.resume()
    }
    
    func doRequest<T: Decodable>(request: URLRequest, onResult: @escaping (Result2<T>) -> Void) {
        print("do request \(request.url?.absoluteString ?? "")")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            if let error = error {
                print("response error: ", error)
                DispatchQueue.main.async { onResult(.networkError(error.localizedDescription)) }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                //should never happen
                DispatchQueue.main.async { onResult(.networkError(Errors.ERR_CONVERTING_TO_HTTP_RESPONSE)) }
                return
            }
            
            guard let data = data else {
                //should never happen
                DispatchQueue.main.async {
                    onResult(.serverError(ErrorResponse(code: httpResponse.statusCode, message: Errors.ERR_NIL_BODY)))
                }
                return
            }
            print("respone code: \(httpResponse.statusCode)")
            if httpResponse.isSuccessful() {
                let responseBody: Result2<T> = self.parseResponse(data: data)
                DispatchQueue.main.async { onResult(responseBody) }
            } else {
                let responseBody: Result2<T> = self.parseError(data: data)
                DispatchQueue.main.async { onResult(responseBody) }
            }
        }
        task.resume()
    }
    
    private func parseResponse<T: Decodable>(data: Data) -> Result2<T> {
        do {
            return .success(try JSONDecoder().decode(T.self, from: data))
        } catch {
            print("failed parsing successful response, parsing err: \(error)")
            return parseError(data: data)
        }
    }
    
    private func parseError<T>(data: Data) -> Result2<T> {
        print("parsing error")
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            if (errorResponse.isAuth()) {
                return .authError(errorResponse)
            } else {
                return .serverError(errorResponse)
            }
        } catch {
            return .serverError(ErrorResponse(code: 0, message: Errors.ERR_PARSE_ERROR_RESPONSE))
        }
    }
}


enum Result2<T> {
    case success(_ response: T)
    case serverError(_ err: ErrorResponse)
    case authError(_ err: ErrorResponse)
    case networkError(_ err: String)
}

class Errors {
    
    //internal
    static let ERR_SERIALIZING_REQUEST = "error_serializing_request"
    static let ERR_CONVERTING_TO_HTTP_RESPONSE = "error_converting_response_to_http_response"
    static let ERR_PARSE_RESPONSE = "error_parsing_response"
    static let ERR_NIL_BODY = "error_nil_body"
    static let ERR_PARSE_ERROR_RESPONSE = "error_parsing_error_response"
    
    //server
    static let ERR_USER_EXIST = "user already exist"
    static let ERR_USER_NOT_EXIST = "user not exist"
    static let ERR_WRONG_CREDENTIALS = "wrong credentials"
    static let ERR_MISSING_AUTH_HEADER = "missing auth header or wrong header format"
    static let ERR_INVALID_ACCESS_TOKEN = "invalid access token"
    static let ERR_ACCESS_TOKEN_EXPIRED = "access token expired"
    static let ERR_INVALID_REFRESH_TOKEN = "invalid refresh token"
    static let ERR_REFRESH_TOKEN_EXPIRED = "refresh token expired"
    
    static func messageFor(err: String) -> String {
        switch err {
        case ERR_USER_EXIST:
            return "The user with given login already exists"
        case ERR_USER_NOT_EXIST:
            return "The user with given login doesn't exist"
        case ERR_WRONG_CREDENTIALS:
            return "Entered wrong login or password"
        default:
            return "An error has occured. Please check your internet connection and try again"
        }
    }
    
    static func isAuthError(err: String) -> Bool {
        return err == ERR_MISSING_AUTH_HEADER || err == ERR_INVALID_ACCESS_TOKEN ||
        err == ERR_INVALID_REFRESH_TOKEN || err == ERR_ACCESS_TOKEN_EXPIRED || err == ERR_REFRESH_TOKEN_EXPIRED
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension HTTPURLResponse {
    
    func isSuccessful() -> Bool {
        return statusCode >= 200 && statusCode <= 299
    }
}

extension Date {
    
    init(timestampMillis: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(timestampMillis/1000))
    }
    
    func timestampMillis() -> Int64 {
        return timestamp() * 1000
    }
    
    func timestamp() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }
}
