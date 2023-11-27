CREATE TABLE Places
(
    PlaceId      UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    Address      VARCHAR(250),
    Details      VARCHAR(1000),
    PricePerHour MONEY
);
CREATE TABLE Games
(
    GameId        UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    GameName      VARCHAR(50),
    MaximumPlayer INT,
    Difficulty    INT,
    Description   VARCHAR(1000),
    Map           VARCHAR(1000),
    Scenario      VARCHAR(1000)
);
CREATE TABLE GameRoles
(
    GameRoleId     UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    RoleName        VARCHAR(50),
    RoleDescription VARCHAR(1000),
    GameId          UUID,
    FOREIGN KEY (GameId) REFERENCES Games (GameId)
);
CREATE TABLE Items
(
    ItemId         UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ItemName        VARCHAR(50),
    ItemDescription VARCHAR(250),
    Rarity          VARCHAR(50),
    Type            VARCHAR(50),
    ItemIcon        VARCHAR(150),
    GameId          UUID,
    FOREIGN KEY (GameId) REFERENCES Games (GameId)
);

CREATE TABLE Events
(
    EventId      UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    EventName    VARCHAR(50),
    StartDate    TIMESTAMP WITHOUT TIME ZONE,
    PricePerUser MONEY,
    TechnicalDescription  VARCHAR(1000),
    DescriptionForClients   VARCHAR(1000),
    DescriptionForEmployees  VARCHAR(1000),
    Icon         VARCHAR(50),
    EventState   VARCHAR(50),
    EndDate      TIMESTAMP WITHOUT TIME ZONE,
    PaidFor      BOOLEAN,
    GameId       UUID,
    PlaceId      UUID,
    EventPrice   MONEY,
    OwnerEmail   VARCHAR(50),
    FOREIGN KEY (GameId) REFERENCES Games (GameId),
    FOREIGN KEY (PlaceId) REFERENCES Places (PlaceId)
);
CREATE TABLE Users
(
    UserId UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    Name   VARCHAR(50),
    Email  VARCHAR(50),
    Avatar VARCHAR(150)
);
CREATE TABLE UsersCredential
(
    UserCredentialId UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    Password         VARCHAR(50),
    UserEmail           VARCHAR(50),
    FOREIGN KEY (UserEmail) REFERENCES Users (Email)
);
CREATE TABLE Players
(
    PlayerId    UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    GameRoleId  UUID,
    UserId      UUID,
    EventId     UUID,
    Nick        VARCHAR(50),
    Coordinates POINT,
    FOREIGN KEY (GameRoleId) REFERENCES GameRoles (GameRoleId),
    FOREIGN KEY (UserId) REFERENCES Users (UserId),
    FOREIGN KEY (EventId) REFERENCES Events (EventId)
);

CREATE TABLE Equipments
(
    EquipmentId UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    ItemState   VARCHAR(50),
    ItemId      UUID,
    PlayerId    UUID,
    FOREIGN KEY (ItemId) REFERENCES Items (ItemId),
    FOREIGN KEY (PlayerId) REFERENCES Players (PlayerId)
);

CREATE TABLE Payments
(
    PaymentId     UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    PaymentType   VARCHAR(50),
    PaymentDate   TIMESTAMP WITHOUT TIME ZONE,
    PaymentState  VARCHAR(50),
    PaymentAmount MONEY,
    EventId       UUID,
    UserEmail           VARCHAR(50),
    FOREIGN KEY (UserEmail) REFERENCES Users (Email)
    FOREIGN KEY (EventId) REFERENCES Events (EventId)
);
