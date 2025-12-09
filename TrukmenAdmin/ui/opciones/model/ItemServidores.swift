// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let itemServidores = try ItemServidores(json)

import Foundation

// MARK: - ItemServidores
struct ItemServidores: Codable {
    let respuesta: String
    let datos: [DatoSer]
}

// MARK: ItemServidores convenience initializers and mutators

extension ItemServidores {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ItemServidores.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        respuesta: String? = nil,
        datos: [DatoSer]? = nil
    ) -> ItemServidores {
        return ItemServidores(
            respuesta: respuesta ?? self.respuesta,
            datos: datos ?? self.datos
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Dato
struct DatoSer: Codable {
    let id: Int
    let nombre, clave: String
    let url: String
    let estatus: Bool
}

// MARK: Dato convenience initializers and mutators

extension DatoSer {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DatoSer.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int? = nil,
        nombre: String? = nil,
        clave: String? = nil,
        url: String? = nil,
        estatus: Bool? = nil
    ) -> DatoSer {
        return DatoSer(
            id: id ?? self.id,
            nombre: nombre ?? self.nombre,
            clave: clave ?? self.clave,
            url: url ?? self.url,
            estatus: estatus ?? self.estatus
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

