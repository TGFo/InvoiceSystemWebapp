USE InvoiceDB;
GO

CREATE PROCEDURE spGetAllInvoices
AS
BEGIN
    SELECT *
    FROM 
        Invoices;
END
GO

CREATE PROCEDURE spGetAllCustomers
AS
BEGIN
    SELECT *
    FROM 
        Customers;
END
GO

CREATE PROCEDURE spGetAllItems
AS
BEGIN
    SELECT *
    FROM 
        Items;
END
GO

CREATE PROCEDURE spGetInvoiceById
    @InvoiceID INT
AS
BEGIN
    SELECT 
        *
    FROM 
        Invoices
    WHERE 
        InvoiceID = @InvoiceID;
END
GO

CREATE PROCEDURE spGetCustomerById
    @CustomerID INT
AS
BEGIN
    SELECT 
        *
    FROM 
        Customers
    WHERE 
        CustomerID = @CustomerID;
END
GO

CREATE PROCEDURE spGetInvoiceItems
    @InvoiceID INT
AS
BEGIN
    SELECT 
        ii.InvoiceItemID,
        i.ItemID,
        i.Name AS ItemName,
        i.UnitPrice,
        ii.Quantity,
        (ii.Quantity * i.UnitPrice) AS TotalPrice
    FROM InvoiceItems ii
    INNER JOIN Items i ON ii.ItemID = i.ItemID
    WHERE ii.InvoiceID = @InvoiceID;
END
GO

CREATE PROCEDURE spUpdateInvoice
    @InvoiceID INT,
    @CustomerID INT,
    @InvoiceDate DATETIME,
    @TotalAmount DECIMAL(18,2)
AS
BEGIN
    UPDATE Invoices
    SET 
        CustomerID = @CustomerID,
        InvoiceDate  = @InvoiceDate,
        TotalAmount  = @TotalAmount
    WHERE 
        InvoiceID = @InvoiceID;
END
GO

CREATE PROCEDURE spUpdateInvoiceItem
    @InvoiceItemID INT,
    @InvoiceID INT,
    @ItemID INT,
    @Quantity INT
AS
BEGIN
    UPDATE InvoiceItems
    SET InvoiceID = @InvoiceID,
        ItemID = @ItemID,
        Quantity = @Quantity
    WHERE InvoiceItemID = @InvoiceItemID;
END
GO

CREATE PROCEDURE spUpdateCustomer
    @CustomerID INT,
    @Name NVARCHAR(100),
    @Address NVARCHAR(255),
    @ContactInfo NVARCHAR(100)
AS
BEGIN
    UPDATE Customers
    SET Name = @Name,
        Address = @Address,
        ContactInfo = @ContactInfo
    WHERE CustomerID = @CustomerID;
END
GO

CREATE PROCEDURE spAddInvoice
    @CustomerID INT,
    @InvoiceDate DATETIME,
    @TotalAmount DECIMAL(18,2)
AS
BEGIN
    INSERT INTO Invoices (CustomerID, InvoiceDate, TotalAmount)
    VALUES (@CustomerID, @InvoiceDate, @TotalAmount);

    SELECT SCOPE_IDENTITY() AS NewInvoiceID;
END
GO

CREATE PROCEDURE spAddInvoiceItem
    @InvoiceID INT,
    @ItemID INT,
    @Quantity INT
AS
BEGIN
    INSERT INTO InvoiceItems (InvoiceID, ItemID, Quantity)
    VALUES (@InvoiceID, @ItemID, @Quantity);
    SELECT SCOPE_IDENTITY() AS NewInvoiceItemID;
END
GO

CREATE PROCEDURE spAddCustomer
    @Name NVARCHAR(100),
    @Address NVARCHAR(255),
    @ContactInfo NVARCHAR(100)
AS
BEGIN
    INSERT INTO Customers (Name, Address, ContactInfo)
    VALUES (@Name, @Address, @ContactInfo);
    SELECT SCOPE_IDENTITY() AS NewCustomerID;
END
GO

CREATE PROCEDURE spDeleteInvoice
    @InvoiceID INT
AS
BEGIN
    DELETE FROM Invoices
    WHERE InvoiceID = @InvoiceID;
END
GO

CREATE PROCEDURE spDeleteInvoiceItem
    @InvoiceItemID INT
AS
BEGIN
    DELETE FROM InvoiceItems
    WHERE InvoiceItemID = @InvoiceItemID;
END
GO

CREATE PROCEDURE spDeleteCustomer
    @CustomerID INT
AS
BEGIN
    DELETE FROM Customers
    WHERE CustomerID = @CustomerID;
END
GO