UPDATE SALES 
SET SALES.[Tỉnh/TP] = Van_don.[Tỉnh/Thành]
FROM SALES
LEFT JOIN Van_don ON SALES.[Khách hàng] = Van_don.[Tên người nhận]
WHERE SALES.[Tỉnh/TP] IS NULL;

--- Sales

-- Add a new column with DATE data type
ALTER TABLE Sales 
ADD Ngày DATE; 

-- Update the new column with converted values
UPDATE Sales
SET Ngày = TRY_CONVERT(DATE, Date, 103);

-- Drop the original column
ALTER TABLE Sales DROP COLUMN Date;

ALTER TABLE Sales ADD So_dien_thoai VARCHAR(15);
UPDATE Sales
SET So_dien_thoai = 
    CASE 
        WHEN LEFT(CAST(CAST(SĐT AS BIGINT) AS VARCHAR), 2) = '84' 
        THEN '0' + RIGHT(CAST(CAST(SĐT AS BIGINT) AS VARCHAR), LEN(CAST(CAST(SĐT AS BIGINT) AS VARCHAR)) - 2) 
        ELSE '0' + CAST(CAST(SĐT AS BIGINT) AS VARCHAR) 
    END;

ALTER TABLE Sales DROP COLUMN SĐT;

ALTER TABLE Sales  
ALTER COLUMN [Số lượng bộ sách] INT;  

ALTER TABLE Sales  
ALTER COLUMN [Số lần tương tác] INT;

ALTER TABLE Sales ADD Time TIME;
UPDATE Sales
SET Time = 
    CONVERT(TIME, 
        CASE 
            WHEN RIGHT(Giờ, 2) = 'CH' AND LEFT(Giờ, 2) <> '12' 
                THEN CONVERT(VARCHAR, CAST(LEFT(Giờ, 2) AS INT) + 12) + SUBSTRING(Giờ, 3, 6)
            WHEN RIGHT(Giờ, 2) = 'SA' AND LEFT(Giờ, 2) = '12'
                THEN '00' + SUBSTRING(Giờ, 3, 6)
            ELSE LEFT(Giờ, 8) 
        END
    );

ALTER TABLE Sales DROP COLUMN Giờ;

ALTER TABLE Sales ADD Giờ TIME(0);
UPDATE Sales  
SET Giờ = CONVERT(TIME(0), Time);

ALTER TABLE Sales DROP COLUMN Time;

SELECT * FROM Sales;

--- MKT

-- Thêm cột mới với định dạng mong muốn
ALTER TABLE MKT 
ADD Date DATE; 

-- Update the new column with converted values
UPDATE MKT
SET Date = TRY_CONVERT(DATE, Ngày, 103);

-- Drop the original column
ALTER TABLE MKT DROP COLUMN Ngày;

ALTER TABLE MKT  
ALTER COLUMN [Impression] INT;  

ALTER TABLE MKT  
ALTER COLUMN [Reach] INT;

ALTER TABLE MKT  
ALTER COLUMN [Click] INT;

UPDATE MKT
SET [ME1 (ME đã bao gồm thuế + phí)] = REPLACE([ME1 (ME đã bao gồm thuế + phí)], '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([ME1 (ME đã bao gồm thuế + phí)], '.', '')) IS NOT NULL;

UPDATE MKT
SET [Giá Mess_(Cmt + Inbox)] = REPLACE([Giá Mess_(Cmt + Inbox)], '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([Giá Mess_(Cmt + Inbox)], '.', '')) IS NOT NULL;

UPDATE MKT
SET [Giá Lead] = REPLACE([Giá Lead], '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([Giá Lead], '.', '')) IS NOT NULL;

UPDATE MKT
SET [Paid Revenue 1] = REPLACE([Paid Revenue 1], '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([Paid Revenue 1], '.', '')) IS NOT NULL;

UPDATE MKT
SET [Doanh thu] = REPLACE([Doanh thu], '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([Doanh thu], '.', '')) IS NOT NULL;

UPDATE MKT
SET [Chi phí Marketing] = REPLACE([Chi phí Marketing], '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([Chi phí Marketing], '.', '')) IS NOT NULL;


SELECT * FROM MKT;

-- Vận đơn

SELECT * FROM Van_don;

UPDATE Van_don
SET [STT] = REPLACE([STT], ' ', '')
WHERE TRY_CAST(REPLACE([STT], ' ', '') AS INT) IS NOT NULL;

ALTER TABLE Van_don
ALTER COLUMN [Ngày đóng gói] DATE;

ALTER TABLE Van_don
ALTER COLUMN [Ngày hẹn giao] DATE;

ALTER TABLE Van_don 
ALTER COLUMN [Ngày xuất kho] DATE;

ALTER TABLE Van_don 
ALTER COLUMN [Ngày giao hàng] DATE;

UPDATE Van_don
SET [Tiền khách phải trả cho đơn] = REPLACE([Tiền khách phải trả cho đơn] , '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([Tiền khách phải trả cho đơn], '.', '')) IS NOT NULL;

UPDATE Van_don
SET [Khách hàng đã trả] = REPLACE([Khách hàng đã trả] , '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([Khách hàng đã trả], '.', '')) IS NOT NULL;

UPDATE Van_don
SET [Tổng tiền thu hộ] = REPLACE([Tổng tiền thu hộ] , '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([Tổng tiền thu hộ], '.', '')) IS NOT NULL;

UPDATE Van_don
SET [Phí trả đối tác] = REPLACE([Phí trả đối tác] , '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([Phí trả đối tác], '.', '')) IS NOT NULL;

UPDATE Van_don
SET [Đơn giá] = REPLACE([Đơn giá] , '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([Đơn giá], '.', '')) IS NOT NULL;

UPDATE Van_don
SET [CK sản phẩm] = REPLACE([CK sản phẩm] , '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([CK sản phẩm], '.', '')) IS NOT NULL;

UPDATE Van_don
SET [Tổng tiền hàng] = REPLACE([Tổng tiền hàng] , '.', '')
WHERE TRY_CONVERT(NUMERIC(18, 2), REPLACE([Tổng tiền hàng], '.', '')) IS NOT NULL;


