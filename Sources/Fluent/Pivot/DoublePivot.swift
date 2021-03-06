/// Double pivots
/// A pivot in which either the 
/// left or right Entity is another pivot
extension PivotProtocol where Left: PivotProtocol, Self: Entity {
    /// Returns true if the three entities
    /// are related by the pivot.
    public static func related(
        left: Left.Left,
        middle: Left.Right,
        right: Right
    ) throws -> Bool {
        let leftId = try left.assertExists()
        let middleId = try middle.assertExists()
        let rightId = try right.assertExists()

        let result = try Left
            .makeQuery()
            .join(self)
            .filter(Left.self, Left.Left.foreignIdKey == leftId)
            .filter(Left.self, Left.Right.foreignIdKey, middleId)
            .filter(self, Right.foreignIdKey, rightId)
            .first()

        return result != nil
    }
}

extension PivotProtocol where Right: PivotProtocol, Self: Entity {
    /// Returns true if the three entities
    /// are related by the pivot.
    public static func related(
        left: Left,
        middle: Right.Left,
        right: Right.Right
    ) throws -> Bool {
        let leftId = try left.assertExists()
        let middleId = try middle.assertExists()
        let rightId = try right.assertExists()
        
        let result = try Right
            .makeQuery()
            .join(self)
            .filter(self, Left.foreignIdKey, leftId)
            .filter(Right.self, Right.Left.foreignIdKey, middleId)
            .filter(Right.self, Right.Right.foreignIdKey, rightId)
            .first()

        return result != nil
    }
}
