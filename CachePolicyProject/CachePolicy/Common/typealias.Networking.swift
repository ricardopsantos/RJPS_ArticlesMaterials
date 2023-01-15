//
//  Created by Ricardo Santos on 11/07/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

//
// MARK: - Regular NetWork Clients (works with completionHandlers)
//
public struct NetworkinNameSpace {
    private init() { }
}

//
// MARK: - FRP NetWork Clients (works with Functional Reactive Programing)
//

public typealias Common_FRPSimpleNetworkAgent = NetworkinNameSpace.FRPSimpleNetworkAgent

public typealias Common_FRPNetworkAgentProtocol     = FRPSimpleNetworkAgentProtocol
public typealias Common_FRPNetworkAgentRequestModel = NetworkinNameSpace.FRPSimpleNetworkAgentRequestModel
public typealias Common_FRPNetworkAgentAPIError     = NetworkinNameSpace.FRPSimpleNetworkClientAPIError

//
// MARK: - Shared between NetWork Clients and FRP NetWork Clients
//

public typealias Common_NetworkClientResponseFormat = NetworkinNameSpace.ResponseFormat // json, csv
public typealias Common_HttpMethod                  = NetworkinNameSpace.HttpMethod     // POST, GET, DELETE, ...
