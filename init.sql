CREATE TABLE Places
(
    PlaceId      UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    Address      VARCHAR(250) NOT NULL,
    Details      VARCHAR(1000),
    PricePerHour MONEY CHECK ( PricePerHour >= 0::money )
);
CREATE TABLE Games
(
    GameId        UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    GameName      VARCHAR(50)                                      NOT NULL UNIQUE,
    MaximumPlayer INT CHECK ( MaximumPlayer > 0::int )                  NOT NULL Default 100,
    Difficulty    INT CHECK ( Difficulty > 0::int AND Difficulty <= 10::int) NOT NULL,
    Description   VARCHAR(1000),
    Map           VARCHAR(1000),
    Scenario      VARCHAR(1000)
);
CREATE TABLE GameRoles
(
    GameRoleId      UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    RoleName        VARCHAR(50) NOT NULL,
    RoleDescription VARCHAR(1000),
    GameId          UUID,
    FOREIGN KEY (GameId) REFERENCES Games (GameId)
);
CREATE TABLE Items
(
    ItemId          UUID                  DEFAULT gen_random_uuid() PRIMARY KEY,
    ItemName        VARCHAR(50)  NOT NULL,
    ItemDescription VARCHAR(250)  DEFAULT 'No description',
    Rarity          VARCHAR(50)  NOT NULL DEFAULT 'Common',
    Type            VARCHAR(50)  NOT NULL DEFAULT 'Potion',
    ItemIcon        VARCHAR(150),
    GameId          UUID,
    FOREIGN KEY (GameId) REFERENCES Games (GameId)
);

CREATE TABLE Events
(
    EventId                 UUID                 DEFAULT gen_random_uuid() PRIMARY KEY,
    EventName               VARCHAR(50) NOT NULL,
    StartDate               TIMESTAMP WITHOUT TIME ZONE NOT NULL CHECK (StartDate > NOW()),
    PricePerUser            MONEY CHECK (PricePerUser >= 0::money),
    TechnicalDescription    VARCHAR(1000),
    DescriptionForClients   VARCHAR(1000),
    DescriptionForEmployees VARCHAR(1000),
    Icon                    VARCHAR(50),
    EventState              VARCHAR(50) NOT NULL DEFAULT 'Created' CHECK (EventState IN ('Created', 'InProgress', 'Paused', 'Ended')),
    EndDate                 TIMESTAMP WITHOUT TIME ZONE CHECK (EndDate > StartDate) NOT NULL,
    PaidFor                 BOOLEAN              DEFAULT FALSE,
    GameId                  UUID,
    PlaceId                 UUID,
    EventPrice              MONEY CHECK (EventPrice >= 0::money),
    OwnerEmail              VARCHAR(50) NOT NULL DEFAULT 'NoOwner@notExist.xyz',
    IsVisible               BOOLEAN              DEFAULT TRUE,
    IsExternalOrginiser     BOOLEAN              DEFAULT FALSE,
    FOREIGN KEY (GameId) REFERENCES Games (GameId),
    FOREIGN KEY (PlaceId) REFERENCES Places (PlaceId)
);
CREATE TABLE Users
(
    UserId UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    Name   VARCHAR(50) NOT NULL,
    Email  VARCHAR(50) UNIQUE CHECK (Email IS NOT NULL AND Email ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'),
    Avatar VARCHAR(150)
);
CREATE TABLE UsersCredential
(
    UserCredentialId UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    Password         VARCHAR(50),
    UserEmail        VARCHAR(50),
    FOREIGN KEY (UserEmail) REFERENCES Users (Email)
);
CREATE TABLE Players
(
    PlayerId    UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    GameRoleId  UUID,
    UserEmail   VARCHAR(50) CHECK (UserEmail IS NOT NULL AND
                                   UserEmail ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'),
    EventId     UUID,
    Nick        VARCHAR(50) NOT NULL,
    Coordinates POINT,
    FOREIGN KEY (GameRoleId) REFERENCES GameRoles (GameRoleId),
    FOREIGN KEY (EventId) REFERENCES Events (EventId)
);

CREATE TABLE Equipments
(
    EquipmentId UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
    ItemState   VARCHAR(50) DEFAULT 'Lost',
    ItemId      UUID,
    PlayerId    UUID,
    FOREIGN KEY (ItemId) REFERENCES Items (ItemId),
    FOREIGN KEY (PlayerId) REFERENCES Players (PlayerId)
);

CREATE TABLE Payments
(
    PaymentId     UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    PaymentType   VARCHAR(50) NOT NULL CHECK (PaymentType IN ('BLIK', 'SMS', 'PayPal', 'Card', 'BankTransfer')),
    PaymentDate   TIMESTAMP WITHOUT TIME ZONE,
    PaymentState  VARCHAR(50) NOT NULL CHECK (PaymentState IN ('Success', 'NotResolved', 'Failure')),
    PaymentAmount MONEY CHECK ( PaymentAmount > 0::money ),
    EventId       UUID,
    UserEmail     VARCHAR(50) CHECK (UserEmail IS NOT NULL AND
                                     UserEmail ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'),
    FOREIGN KEY (EventId) REFERENCES Events (EventId)
);
