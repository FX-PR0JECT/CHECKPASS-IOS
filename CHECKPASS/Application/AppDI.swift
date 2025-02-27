//
//  AppDI.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

struct AppDI {
    private static let instance: AppDI = AppDI()    //singleton instance
    private let dataSource = DefaultDataSource()    //DataSource
    
    private init() {}
    
    static func shared() -> AppDI {
        return instance
    }
    
    func getAttendanceStatusViewModel() -> DefaultAttendanceStatusViewModel {
        let repository = DefaultAttendanceStatusRepository(dataSource: dataSource)
        let usecase = DefaultGetAttendanceStatusUseCase(repository: repository)
        let viewModel = DefaultAttendanceStatusViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func getBeaconAttendanceViewModel() -> DefaultBeaconAttendanceViewModel {
        let attendanceRepository = DefaultAttendanceRepository(dataSource: dataSource),
            lectureRepository = DefaultLectureRepository(dataSource: dataSource)
        let beaconScanUseCase = DefaultScanBeaconUseCase(),
            lectureUseCase = DefaultGetLectureByBeaconInfoUseCase(repository: lectureRepository),
            attendanceUseCase = DefaultAttendanceUseCase(repository: attendanceRepository)
        let viewModel = DefaultBeaconAttendanceViewModel(beaconScanUseCase: beaconScanUseCase, lectureUseCase: lectureUseCase, attendanceUseCase: attendanceUseCase)
        
        return viewModel
    }
    
    func getEAttendanceViewModel() -> DefaultEAttendanceViewModel {
        let repository = DefaultAttendanceRepository(dataSource: dataSource)
        let usecase = DefaultAttendanceUseCase(repository: repository)
        let viewModel = DefaultEAttendanceViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func getLectureHistoryViewModel() -> DefaultLectureHistoryViewModel {
        let repository = DefaultEnrollmentHistoryRepository(dataSource: dataSource)
        let usecase = DefaultGetLectureHistoryUseCase(repository: repository)
        let viewModel = DefaultLectureHistoryViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func getRecentlyEnrolledLectureViewModel() -> DefaultRecentlyEnrolledLectureViewModel {
        let repository = DefaultLectureRepository(dataSource: dataSource)
        let usecase = DefaultGetRecentlyEnrolledLectureUseCase(repository: repository)
        let viewModel = DefaultRecentlyEnrolledLectureViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func getLectureEnrollmentViewModel() -> DefaultLectureEnrollmentViewModel {
        let repository = DefaultLectureEnrollmentRepository(dataSource: dataSource)
        let usecase = DefaultLectureEnrollmentUseCase(repository: repository)
        let viewModel = DefaultLectureEnrollmentViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func getLectureSearchViewModel() -> DefaultLectureSearchViewModel {
        let repository = DefaultLectureRepository(dataSource: dataSource)
        let usecase = DefaultLectureSearchUseCase(repository: repository)
        let viewModel = DefaultLectureSearchViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func getEditUserInfoViewModel() -> EditUserInfoViewModel {
        let departmentsRepository = DefaultDepartmentsRepository(dataSource: dataSource),
            editUserInfoRepository = DefaultEditUserInfoRepository(dataSource: dataSource)
        let getDepartmentsUseCase = DefaultGetDepartmentsUseCase(departmentsRepository: departmentsRepository),
            editUserInfoUseCase = DefaultEditUserInfoUseCase(repository: editUserInfoRepository)
        let viewModel = EditUserInfoViewModel(getDepartmentUseCase: getDepartmentsUseCase, editUserInfoUseCase: editUserInfoUseCase)
        
        return viewModel
    }
    
    //get UserInfo ViewModel
    func getUserInfoViewModel() -> UserInfoViewModel {
        let repository = DefaultUserRepository(dataSource: dataSource)
        let useCase = DefaultGetUserInfoUseCase(repository: repository)
        let viewModel = UserInfoViewModel(useCase: useCase)
        
        return viewModel
    }
    
    //get SignUp ViewModel
    func getSignUpViewModel() -> SignUpViewModel {
        //Repository
        let authRepository = DefaultAuthRepository(dataSource: dataSource),
            departmentsRepository = DefaultDepartmentsRepository(dataSource: dataSource),
            collegesRepository = DefaultCollegesRepository(dataSource: dataSource)
        //UseCase
        let signUpUseCase = DefaultSignUpUseCase(repository: authRepository),
            idDuplicationCheckUseCase = DefaultIdDuplicateCheckUseCase(repository: authRepository),
            getDepartmentsUseCase = DefaultGetDepartmentsUseCase(departmentsRepository: departmentsRepository, collegesRepository: collegesRepository)
        //ViewModel
        let viewModel = SignUpViewModel(signUpUseCase: signUpUseCase, idDuplicationCheckUseCase: idDuplicationCheckUseCase, getDepartmentsUseCase: getDepartmentsUseCase)
        
        return viewModel
    }
    
    //get SignIn ViewModel
    func getAuthViewModel() -> AuthViewModel {
        //Repository
        let repository = DefaultAuthRepository(dataSource: dataSource)
        //UseCase
        let signInUseCase = DefaultSignInUseCase(repository: repository)
        let logoutUseCase = DefaultLogoutUseCase(repository: repository)
        //ViewModel
        let viewModel = AuthViewModel(signInUseCase: signInUseCase, logoutUseCase: logoutUseCase)
        
        return viewModel
    }
}
