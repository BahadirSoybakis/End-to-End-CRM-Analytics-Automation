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


### 2. BPMN 2.0 Process Modeling
Modeled cross-departmental business logic in Draw.io using BPMN 2.0 standards:

Trigger: Customer form submission & SQL segmentation execution.

Exclusive Gateway: Branching logic based on RFM results.

Actions:

Champions 👉 Automated personalized marketing discount campaign.

At-Risk 👉 High-priority Call Center retention task creation.

### 3. Salesforce Flow Builder Automation
Integrated segmentation output directly into Salesforce CRM:

Custom Object Management: Added Customer_Segment__c Picklist to the Contact object.

Record-Triggered Flow: Configured an automated flow triggering when Customer_Segment__c equals "Risk Altındakiler".

Action: Automatically generates a high-priority Task assigned to Call Center agents for immediate retention outreach.

### 4. Power BI Executive Dashboard Architecture
Structured a Star Schema data model (Fact_Orders, Dim_Customers, Dim_Segments) to power real-time executive decision-making.

Key DAX Measures Included:

Total Revenue: SUM(Fact_Orders[TotalAmount])

ARPU: DIVIDE([Total Revenue], DISTINCTCOUNT(Fact_Orders[CustomerID]), 0)

At-Risk Revenue: CALCULATE([Total Revenue], Dim_Segments[CustomerSegment] = "Risk Altındakiler")

📈 Key Outcomes & Business Impact
Automation: Reduced manual retention list management time to zero using event-driven Salesforce Flows.

Data Integration: Seamless pipeline logic connecting raw T-SQL databases to operational CRM and executive dashboards.

Proactive Engagement: Automated early-warning system for churn-risk customers.

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
