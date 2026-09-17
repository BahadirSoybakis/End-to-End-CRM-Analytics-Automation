
# 🚀 End-to-End CRM Analytics, Process Automation & Business Intelligence Case Study

This repository demonstrates a complete, enterprise-grade CRM solution integrating database-level customer segmentation, business process modeling, automated CRM workflow execution, and executive reporting.

---

## 📌 Architecture & Tech Stack

* **Database & Analytics:** T-SQL (Microsoft SQL Server) – RFM Customer Segmentation
* **Process Modeling:** BPMN 2.0 (Draw.io) – Cross-functional Swimlane Workflows
* **CRM Automation:** Salesforce Enterprise (Flow Builder & Object Management)
* **Business Intelligence:** Microsoft Power BI – Executive Dashboards & DAX Data Modeling

---

## 🛠️ Project Phases & Implementation

### 1. T-SQL RFM Customer Segmentation
Raw transactional data processed using T-SQL window functions (`NTILE`, `DATEDIFF`, `COUNT(DISTINCT)`) to evaluate customer **Recency**, **Frequency**, and **Monetary** values.

```sql
-- Segmenting customers based on Recency and Monetary scores
SELECT 
    CustomerID,
    RecencyScore,
    FrequencyScore,
    MonetaryScore,
    CASE 
        WHEN RecencyScore >= 4 AND MonetaryScore >= 4 THEN 'Champions'
        WHEN RecencyScore <= 2 AND MonetaryScore <= 2 THEN 'At-Risk / Churn'
        ELSE 'Loyal Customers'
    END AS CustomerSegment
FROM #RFM_Scores;
