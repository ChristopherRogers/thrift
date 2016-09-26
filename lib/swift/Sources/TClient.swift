/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

public protocol TService {
  associatedtype InProtocol: TProtocol
  associatedtype OutProtocol: TProtocol
}

open class TClient<In: TProtocol, Out: TProtocol>: TService {
  public typealias InProtocol = In
  public typealias OutProtocol = Out
  
  public let inProtocol: InProtocol
  public let outProtocol: OutProtocol
  
  public init(inProtocol: InProtocol, outProtocol: OutProtocol) {
    self.inProtocol = inProtocol
    self.outProtocol = outProtocol
  }
}

open class TAsyncClient<In, Out, Factory>: TService
  where
  In: TProtocol,
  Out: TProtocol,
  Factory: TAsyncTransportFactory {
  
  public typealias InProtocol = In
  public typealias OutProtocol = Out
  
  public var factory: Factory
  
  public init(with factory: Factory) {
    self.factory = factory
  }
}
