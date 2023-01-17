//
//  Created by Santos, Ricardo Patricio dos  on 09/04/2021.
//

import UIKit
import Foundation
import SwiftUI
import Combine

class CachePolicyTestingViewModel: ObservableObject {
    @Published var displaySucess = ""
    private var dateStart = Date()
    private var cancelBag = CancelBag()
    private let sampleUseCase = SampleUseCase.shared
    public func clear() {
        displaySucess = ""
    }
    public func fetch(_ cachePolicy: CachePolicy) {
        dateStart = Date()
        sampleUseCase.requestWithCacheMaybe(param: "aaa", cachePolicy: cachePolicy)
            .replaceError(with: .init())
            .receive(on: RunLoop.main)
            .flatMap { [weak self] response -> AnyPublisher<String, Never> in
                guard let self else { return .empty() }
                return Just(self.present(response: response, cachePolicy: cachePolicy)).eraseToAnyPublisher()
            }
        .assign(to: \.displaySucess, on: self)
        .store(in: cancelBag)
    }
    private func present(response: ResponseDto.EmployeeServiceAvailability, cachePolicy: CachePolicy) -> String {
        let diff = Date().timeIntervalSinceReferenceDate - self.dateStart.timeIntervalSinceReferenceDate
        let diffString = "\(diff)".prefix(5) + " seconds"
        return "\(self.displaySucess)\n# \(diffString) | \(response.data.count) records | \(cachePolicy)"
    }
}

struct CachePolicyTestingView: View {

    @ObservedObject var vm = CachePolicyTestingViewModel()

    var body: some View {
        if #available(iOS 15.0, *) {
            let _ = Self._printChanges()
        }
        return VStack {
            Spacer()
            Text("CachePolicy")
            Divider()
            ForEach(CachePolicy.allCases, id: \.rawValue) { cachePolicy in
                Button("Fetch using .\(cachePolicy.rawValue)", action: {
                    vm.fetch(cachePolicy)
                })
                Divider()
            }
            Text(vm.displaySucess).font(.caption2)
            Divider()
            Button("Clear", action: {
                vm.clear()
            })
            Spacer()
        }
    }
}
