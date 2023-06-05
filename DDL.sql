CREATE TABLE Sale
(
    SalesID	INT,
    OrderID	INT,
    Customer	VARCHAR(512),
    Product	VARCHAR(512),
    Date	VARCHAR(512),
    Quantity	INT,
    UnitPrice	INT
);

CREATE TABLE Sale_Profit
(
    Product	VARCHAR(512),
    ProfitRatio	VARCHAR(512)
);

CREATE TABLE chart 
(
    Id	INT,
    name	VARCHAR(512),
    manager	VARCHAR(512),
    Manager_Id	INT
);