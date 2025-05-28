# Real-Time MBTA Data Pipeline  
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

---

## 📚 Table of Contents  
- [What is this?](#what-is-this)  
- [Getting Started](#getting-started)  
  - [Requirements](#requirements)  
  - [Installation](#installation)  
- [Usage](#usage)  

## 🚌 What is this?

This project is a real-time data pipeline that ingests live vehicle data from the Massachusetts Bay Transportation Authority (MBTA) API. It transforms and stores this data in **SQL Server** using **SSIS**, enabling **real-time dashboards in Power BI**.

Designed with OLTP best practices and historical tracking in mind, this pipeline showcases how public transport data can be processed and visualized in near real-time.

It’s a demo of data engineering skills — API integration, ETL design, SQL Server optimization, and real-time analytics.

## ⚙️ Getting Started  
This section will help you set up the project locally and run it end-to-end.

### Requirements
- SQL Server 2019+  
- SSIS (SQL Server Integration Services)  
- Power BI Desktop  
- Python 3.8+ (optional, if using for API testing)  
- MBTA API Key (free from [MBTA Developers Portal](https://api-v3.mbta.com))

### Installation
1. Clone this repo:  
   ```bash
   git clone https://github.com/Athul0491/mbta-data-pipeline.git
   cd mbta-data-pipeline
2. Open the SSIS project in Visual Studio and deploy the ETL package.

3. Set up SQL Server tables using the provided schema under sql/schema.sql.

4. Run the scheduled package or trigger it manually to start data ingestion.

5. Open the Power BI file under dashboards/ to view live MBTA vehicle data visualizations. (coming soon)

## 🧪 Usage  
This is a real-time analytics project designed for educational and demo purposes. Once deployed, the system will continuously ingest, transform, and display live transit vehicle data from the Boston area.

You can monitor:
- Active vehicle positions  
- Route-level delays  
- Historical vehicle tracking  

Feel free to remix or extend the pipeline to work with other transit APIs or databases!

