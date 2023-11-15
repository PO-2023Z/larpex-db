CREATE TABLE Places
(
    PlaceId      VARCHAR(50) PRIMARY KEY,
    Address      VARCHAR(50),
    Details      VARCHAR(50),
    PricePerHour MONEY
);
CREATE TABLE Games
(
    GameId        VARCHAR(50) PRIMARY KEY,
    GameName      VARCHAR(50),
    MaximumPlayer INT,
    Difficulty    INT,
    Description   VARCHAR(50),
    Map           VARCHAR(50),
    Scenario      VARCHAR(50)
);
CREATE TABLE GameRoles
(
    GameRoleId      VARCHAR(50) PRIMARY KEY,
    RoleName        VARCHAR(50),
    RoleDescription VARCHAR(50),
    GameId          VARCHAR(50),
    FOREIGN KEY (GameId) REFERENCES Games (GameId)
);
CREATE TABLE Items
(
    ItemId          VARCHAR(50) PRIMARY KEY,
    ItemName        VARCHAR(50),
    ItemDescription VARCHAR(50),
    Rarity          VARCHAR(50),
    Type            VARCHAR(50),
    ItemIcon        VARCHAR(50),
    GameId          VARCHAR(50),
    FOREIGN KEY (GameId) REFERENCES Games (GameId)
);

CREATE TABLE Events
(
    EventId      VARCHAR(50) PRIMARY KEY,
    EventName    VARCHAR(50),
    StartDate    TIME,
    PricePerUser MONEY,
    Description  VARCHAR(50),
    Icon         VARCHAR(50),
    EventState   VARCHAR(50),
    EndDate      TIME,
    PaidFor      BOOLEAN,
    GameId       VARCHAR(50),
    PlaceId      VARCHAR(50),
    FOREIGN KEY (GameId) REFERENCES Games (GameId),
    FOREIGN KEY (PlaceId) REFERENCES Places (PlaceId)
);
CREATE TABLE Users
(
    UserId VARCHAR(50) PRIMARY KEY,
    Name   VARCHAR(50),
    Email  VARCHAR(50),
    Avatar VARCHAR(50)
);
CREATE TABLE UsersCredential
(
    UserCredentialId VARCHAR(50) PRIMARY KEY,
    Password         VARCHAR(50),
    UserId           VARCHAR(50),
    FOREIGN KEY (UserId) REFERENCES Users (UserId)
);
CREATE TABLE Players
(
    PlayerId    VARCHAR(50) PRIMARY KEY,
    GameRoleId  VARCHAR(50),
    UserId      VARCHAR(50),
    EventId     VARCHAR(50),
    Nick        VARCHAR(50),
    Coordinates POINT,
    FOREIGN KEY (GameRoleId) REFERENCES GameRoles (GameRoleId),
    FOREIGN KEY (UserId) REFERENCES Users (UserId),
    FOREIGN KEY (EventId) REFERENCES Events (EventId)
);

CREATE TABLE Equipments
(
    EquipmentId VARCHAR(50) PRIMARY KEY,
    ItemState   VARCHAR(50),
    ItemId      VARCHAR(50),
    PlayerId    VARCHAR(50),
    FOREIGN KEY (ItemId) REFERENCES Items (ItemId),
    FOREIGN KEY (PlayerId) REFERENCES Players (PlayerId)
);

CREATE TABLE Payments
(
    PaymentId     VARCHAR(50) PRIMARY KEY,
    PaymentType   VARCHAR(50),
    PaymentDate   Time,
    PaymentState  VARCHAR(50),
    PaymentAmount MONEY,
    UserId        VARCHAR(50),
    EventId       VARCHAR(50),
    FOREIGN KEY (UserId) REFERENCES Users (UserId),
    FOREIGN KEY (EventId) REFERENCES Events (EventId)
);