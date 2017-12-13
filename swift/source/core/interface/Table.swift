/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import Foundation

public class TableBase: CoreRepresentable {
    var core: Core {
        return database
    }
    public var tag: Tag? {
        return core.tag
    }
    public var path: String {
        return core.path
    }
    let database: Database
    public let name: String
    let base: Any.Type

    init(withDatabase database: Database, named name: String, base: Any.Type) {
        self.database = database
        self.name = name
        self.base = base
    }
}

public final class Table<Root: TableCodable>: TableBase {
    public let `class`: Root.Type

    init(withDatabase database: Database, named name: String) {
        self.`class` = Root.self
        super.init(withDatabase: database, named: name, base: self.`class`)
    }
}

extension Table: InsertTableInterface,
                 DeleteTableInterface,
                 UpdateTableInterface,
                 SelectTableInterface,
                 RowSelectTableInterface {
    public typealias Object = Root
}