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


/// TErrorCase
///
/// Protocol for TError conformers' enum's to conform to.
/// Generic Int Thrift error code to allow error cases to have
/// associated values.
public protocol TErrorCode : CustomStringConvertible {
  var thriftErrorCode: Int { get }
}

/// TError
///
/// Base protocol for all Thrift Error(Exception) types to conform to
public protocol TError : ErrorProtocol, CustomStringConvertible {

  /// Enum for error cases.  Can be typealiased to any conforming enum
  /// or defined nested.
  associatedtype ErrorCase: TErrorCode
  
  /// Error Case, value from internal enum
  var error: ErrorCase { get set }
  
  /// Optional additional message
  var message: String? { get set }
  
  /// Default error case for the error type, used for generic init()
  static var defaultCase: ErrorCase { get }
}

extension TError {
  /// Human readable description of error. Default provided for you in the
  /// format \(Self.self): \(error.errorDescription) \n message
  /// eg:
  ///
  ///     TApplicationError (1): Invalid Message Type
  ///     An unknown Error has occured.
  public var description: String{
    var out = "\(Self.self) (\(error.thriftErrorCode)): " + error.description + "\n"
    if let message = message {
      out += "Message: \(message)"
    }
    return out
  }

  /// Simple default Initializer for TError's
  ///
  /// - parameter error:   ErrorCase value.  Default: defaultCase
  /// - parameter message: Custom message with error.  Optional
  public init(error: ErrorCase = Self.defaultCase, message: String? = nil) {
    self.init()
    self.error = error
    self.message = message
  }
}

/// TBaseError
///
/// Simple basic Thrift Error that can be thrown with only a custom message.
public struct TBaseError : TError {
  public enum ErrorCase: TErrorCode {
    case none
    public var description: String { return "Generic Thrift Error" }
    public var thriftErrorCode: Int { return 0 }
  }
  public var error: ErrorCase = ErrorCase.none
  public var message: String? = nil
  public static var defaultCase: ErrorCase { return .none }
  public init(message: String? = nil) {
    self.message = message
  }
}
