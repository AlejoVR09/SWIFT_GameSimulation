import Foundation

protocol DamageProtocol {
    
    var baseDamage: Int { get }
    mutating func damageEffects(damage: DamageProtocol) -> String
}


enum PhysicalDamage: DamageProtocol  {
    
    case Piercing(String)
    case Contundent(String)
    case Bleeding(String)
    case Critit(Int, String)
    
    var baseDamage: Int {
        switch self {
        case .Piercing:
            return 8
        case .Contundent:
            return 13
        case .Bleeding:
            return 5
        case .Critit:
            return 20
        }
    }
    
    mutating func damageEffects(damage: DamageProtocol) -> String {
        switch self {
        case .Piercing:
            return "Reduce armor"
        case .Contundent:
            return "Powered attacks"
        case .Bleeding:
            return "Constant damage"
        case .Critit:
            return "Made more damage while enemy has less armor"
        }
    }
}

enum MagicalDamage: DamageProtocol  {
    
    case InAreaDamage(String)
    case DirectImpact(String)
    case Spelling(String)
    
    var baseDamage: Int {
        switch self {
        case .InAreaDamage:
            return 12
        case .DirectImpact:
            return 20
        case .Spelling:
            return 1
        }
    }
    
    mutating func damageEffects(damage: DamageProtocol) -> String {
        switch self {
        case .InAreaDamage:
            return "Damage to multiple enemies"
        case .DirectImpact:
            return "Great Impact"
        case .Spelling:
            return "Crowd Control effects"
        }
    }
}
    
    

    
enum ElementaryDamage: DamageProtocol  {

    case Fire(String)
    case Ice(String)
    case Wind(String)
    case Lightning(String)
    
    var baseDamage: Int {
        switch self {
        case .Fire:
            return 4
        case .Ice:
            return 2
        case .Wind:
            return 5
        case .Lightning:
            return 10
        }
    }
    
    mutating func damageEffects(damage: DamageProtocol) -> String {
        switch self {
        case .Fire:
            return "Constant fire damage and heat up the armor"
        case .Ice(_):
            return "Block one turn of the enemy"
        case .Wind(_):
            return "Applies damage reduction to impact enemies"
        case .Lightning(_):
            return "Great Impact that erase armor"
        }
    }
}

var myAttack: DamageProtocol = ElementaryDamage.Fire("Fire breath")
var enemySttack: DamageProtocol = MagicalDamage.Spelling("Anatemas Chains")

protocol LevelTrackerProtocol {
    
    var levelPoints: Double { get set }
    mutating func levelUp()
}

struct levelTacker: LevelTrackerProtocol {
    
    var levelPoints: Double
    mutating func levelUp() {
        print("level up")
    }
}

protocol InventoryProtocol {
    
    var slots: Int { get set }
    mutating func expandInventory()
}

struct Inventory: InventoryProtocol {
    
    var slots: Int
    mutating func expandInventory() {
        print("expand")
    }
}

protocol ApplyDamageProtocol {
    
    associatedtype Player where Player: BasePlayerProtocol
    var owner: Player { get }
    var attackMade: DamageProtocol { get }
    mutating func applyDamageToEnemy(enemy: Player)
}

protocol BasePlayerProtocol {
    
    var health: Double { get set }
    var name: String { get  set }
    var level: LevelTrackerProtocol { get set }
    var inventory: InventoryProtocol { get set }
}



struct Warrior: BasePlayerProtocol {
    
    var health: Double
    var name: String
    var level: LevelTrackerProtocol
    var inventory: InventoryProtocol
}

struct Mage: BasePlayerProtocol {
    
    var health: Double
    var name: String
    var level: LevelTrackerProtocol
    var inventory: InventoryProtocol
}

struct Caster: BasePlayerProtocol {
    
    var health: Double
    var name: String
    var level: LevelTrackerProtocol
    var inventory: InventoryProtocol
}

protocol FightProtocol {
    
    mutating func fightBetweenTwoPlayers(_ player1: BasePlayerProtocol,_ player2: BasePlayerProtocol)
}

struct Fight: FightProtocol {
    
    mutating func fightBetweenTwoPlayers(_ player1: BasePlayerProtocol, _ player2: BasePlayerProtocol) {
        print("\(player2.name) gana")
    }
}

var playerOne: BasePlayerProtocol = Mage(health: 100, name: "Saul", level: levelTacker(levelPoints: 0), inventory: Inventory(slots: 10))
var playerTwo: BasePlayerProtocol = Warrior(health: 100, name: "Mocho, ciego, sordo", level: levelTacker(levelPoints: 0), inventory: Inventory(slots: 10))

var fight = Fight()
fight.fightBetweenTwoPlayers(playerOne, playerTwo)
