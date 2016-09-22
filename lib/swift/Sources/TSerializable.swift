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


public protocol TSerializable {
  var hashValue: Int { get }

  /// TType for instance
  static var thriftType: TType { get }

  /// Read TSerializable instance from Protocol
  init<P: TProtocol>(from proto: P) throws

  /// Write TSerializable instance to Protocol
  func write<P: TProtocol>(to proto: P) throws
  
}

extension TSerializable {
  public static func write<P: TProtocol>(_ value: Self, to proto: P) throws {
    try value.write(to: proto)
  }
  
  /// convenience for member access
  public var thriftType: TType { return Self.thriftType }
}

public func ==(lhs: TSerializable, rhs: TSerializable) -> Bool {
  return lhs.hashValue == rhs.hashValue
}

/// Default read/write for primitave Thrift types:
/// Bool, Int8 (byte), Int16, Int32, Int64, Double, String

extension Bool : TSerializable {
  public static var thriftType: TType { return .bool }
  
  public init<P: TProtocol>(from proto: P) throws {
    self = try proto.read()
  }
  
  public func write<P: TProtocol>(to proto: P) throws {
    try proto.write(self)
  }
}

extension Int8 : TSerializable {
  public static var thriftType: TType { return .byte }
  
  public init<P: TProtocol>(from proto: P) throws {
    self = Int8(try proto.read() as UInt8)
  }
  
  public func write<P: TProtocol>(to proto: P) throws {
    try proto.write(UInt8(self))
  }
}

extension Int16 : TSerializable {
  public static var thriftType: TType { return .i16 }
  
  public init<P: TProtocol>(from proto: P) throws {
    self = try proto.read()
  }
  
  public func write<P: TProtocol>(to proto: P) throws {
    try proto.write(self)
  }
}

extension Int32 : TSerializable {
  public static var thriftType: TType { return .i32 }
  
  public init<P: TProtocol>(from proto: P) throws {
    self = try proto.read()
  }
  
  public func write<P: TProtocol>(to proto: P) throws {
    try proto.write(self)
  }
}


extension Int64 : TSerializable {
  public static var thriftType: TType { return .i64 }
  
  public init<P: TProtocol>(from proto: P) throws {
    self = try proto.read()
  }
  
  public func write<P: TProtocol>(to proto: P) throws {
    try proto.write(self)
  }
}

extension Double : TSerializable {
  public static var thriftType: TType { return .double }
  
  public init<P: TProtocol>(from proto: P) throws {
    self = try proto.read()
  }
  
  public func write<P: TProtocol>(to proto: P) throws {
    try proto.write(self)
  }
}

extension String : TSerializable {
  public static var thriftType: TType { return .string }
  
  public init<P: TProtocol>(from proto: P) throws {
    self = try proto.read()
  }
  
  public func write<P: TProtocol>(to proto: P) throws {
    try proto.write(self)
  }
}
