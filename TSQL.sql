
/***

RFM (Recency, Frequency, Monetary) Analizi 

RFM Mantığı Nedir?
	•	Recency (Yenilik - R): Müşterinin son alışverişinden bugüne kaç gün geçti? (Sayı ne kadar küçükse müşteri o kadar aktif)
	•	Frequency (Sıklık - F): Müşteri toplam kaç tane sipariş verdi? (Sayı ne kadar büyükse müşteri o kadar sadık)
	•	Monetary (Harcama - M): Müşteri şirkete toplam kaç TL bıraktı? (Sayı ne kadar büyükse müşteri o kadar değerli)

***/

-- 1. TABLO VE VERİ OLUŞTURMA
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    OrderStatus VARCHAR(20)
);

INSERT INTO Orders VALUES 
(1, 101, '2026-09-01', 1500.00, 'Completed'),
(2, 101, '2026-08-15', 800.00, 'Completed'),
(3, 102, '2026-03-10', 250.00, 'Completed'),
(4, 103, '2026-09-08', 3400.00, 'Completed'),
(5, 103, '2026-09-05', 1200.00, 'Completed'),
(6, 104, '2025-11-20', 100.00, 'Completed'),
(7, 105, '2026-08-30', 450.00, 'Completed');

-- 2. RFM SORGUSU
WITH Raw_RFM AS (
    SELECT 
        CustomerID,
        DATEDIFF(DAY, MAX(OrderDate), CAST('2026-09-10' AS DATE)) AS RecencyValue,
        COUNT(DISTINCT OrderID) AS FrequencyValue,
        SUM(TotalAmount) AS MonetaryValue
    FROM Orders
    WHERE OrderStatus = 'Completed'
    GROUP BY CustomerID
),
RFM_Scores AS (
    SELECT 
        CustomerID,
        RecencyValue,
        FrequencyValue,
        MonetaryValue,
        NTILE(3) OVER (ORDER BY RecencyValue DESC) AS R_Score,
        NTILE(3) OVER (ORDER BY FrequencyValue ASC) AS F_Score,
        NTILE(3) OVER (ORDER BY MonetaryValue ASC) AS M_Score
    FROM Raw_RFM
)
SELECT 
    CustomerID,
    RecencyValue AS [Gecen_Gun],
    FrequencyValue AS [Siparis_Sayisi],
    MonetaryValue AS [Toplam_Ciro],
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Score,
    CASE 
        WHEN R_Score >= 3 AND F_Score >= 3 THEN 'Sampiyonlar'
        WHEN R_Score >= 2 AND F_Score >= 2 THEN 'Sadik Musteriler'
        WHEN R_Score <= 1 THEN 'Risk Altindakiler / Churn'
        ELSE 'Diger'
    END AS CustomerSegment
FROM RFM_Scores
ORDER BY MonetaryValue DESC;
