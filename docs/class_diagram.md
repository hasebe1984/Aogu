# クラス図 (Class Diagram)

アプリケーションの構造定義。
`com.aogu.entity` (データ), `com.aogu.dao` (DB操作), `com.aogu.util` (ツール) の関係を示します。

```mermaid
classDiagram
    %% ==========================================
    %% Entity Package (データの入れ物)
    %% ==========================================
    class User {
        -int id
        -String name
        -String lineUserId
        +getters()
        +setters()
    }

    class Aufgusser {
        -int id
        -String name
        -String homeSauna
        -String imageUrl
        +getters()
        +setters()
    }

    class Facility {
        -int id
        -String name
        -String prefecture
        -String websiteUrl
        +getters()
        +setters()
    }

    class Style {
        -int id
        -String name
        -String color
        +getters()
        +setters()
    }

    class Reaction {
        -int id
        -String label
        -String iconUrl
        +getters()
        +setters()
    }

    class Schedule {
        -int id
        -int aufgusserId
        -String aufgusserName
        -int facilityId
        -String facilityName
        -LocalDateTime eventDatetime
        -Gender genderLimit
        -ReservationType reservationType
        -int price
        -List~Style~ styles
        +getters()
        +setters()
    }

    class Log {
        -int id
        -int userId
        -int scheduleId
        -int reactionId
        -String comment
        -LocalDateTime loggedAt
        +getters()
        +setters()
    }
    
    %% Enum定義
    class Gender {
        <<enumeration>>
        MALE
        FEMALE
        MIXED
    }

    class ReservationType {
        <<enumeration>>
        NONE
        BOOKING
        TICKET
        LOTTERY
    }

    %% ==========================================
    %% DAO Package (データベース操作)
    %% ==========================================
    class AufgusserDAO {
        -Connection con
        +findAll() List~Aufgusser~
        +findByName(String name) List~Aufgusser~
    }

    class ScheduleDAO {
        -Connection con
        +findByAufgusserId(int id) List~Schedule~
        +registerBulk(List~Schedule~ schedules) void
    }

    class LogDAO {
        -Connection con
        +insert(Log log) void
        +findByUserId(int userId) List~Log~
    }

    %% ==========================================
    %% Util Package (便利ツール)
    %% ==========================================
    class DatabaseUtil {
        +getConnection() Connection
        +close(Connection con) void
    }

    class LineNotify {
        -String token
        +send(String message) void
    }

    %% 関係性の定義
    Schedule ..> Gender : uses
    Schedule ..> ReservationType : uses
    Schedule "1" *-- "*" Style : has
    
    AufgusserDAO ..> DatabaseUtil : uses
    ScheduleDAO ..> DatabaseUtil : uses
    LogDAO ..> DatabaseUtil : uses
    
    ScheduleDAO ..> LineNotify : uses
