CREATE TABLE BankAccounts (
    AccountID INT PRIMARY KEY,
    HolderName VARCHAR(50),
    Balance DECIMAL(10,2)
);

INSERT INTO BankAccounts (AccountID, HolderName, Balance) VALUES
(1, 'Alice', 1500.00),
(2, 'Bob', 250.00),
(3, 'Charlie', 6000.00),
(4, 'Diana', 50.00);

SELECT *FROM BankAccounts;

CREATE PROCEDURE UpdateBalance
    @AccountID INT,
    @Amount DECIMAL(10,2),
    @TransactionType VARCHAR(10)
AS
BEGIN
    IF @TransactionType = 'DEPOSIT'
        UPDATE BankAccounts
        SET Balance = Balance + @Amount
        WHERE AccountID = @AccountID;

    ELSE IF @TransactionType = 'WITHDRAW'
        BEGIN
            DECLARE @CurrentBalance DECIMAL(10,2);

            SELECT @CurrentBalance = Balance
            FROM BankAccounts
            WHERE AccountID = @AccountID;

            IF @CurrentBalance >= @Amount
                UPDATE BankAccounts
                SET Balance = Balance - @Amount
                WHERE AccountID = @AccountID;
            ELSE
                PRINT 'Insufficient funds';
        END
END;
GO

-- Run it:
EXEC UpdateBalance @AccountID=2, @Amount=100, @TransactionType='WITHDRAW';

CREATE FUNCTION GetAccountStatus(@AccountID INT)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @balance DECIMAL(10,2);
    DECLARE @status VARCHAR(20);

    SELECT @balance = Balance FROM BankAccounts WHERE AccountID = @AccountID;

    IF @balance >= 5000
        SET @status = 'VIP';
    ELSE IF @balance >= 1000
        SET @status = 'Regular';
    ELSE
        SET @status = 'Low Balance';

    RETURN @status;
END;
GO

-- Use it:
SELECT HolderName, dbo.GetAccountStatus(AccountID) AS Status
FROM BankAccounts;


