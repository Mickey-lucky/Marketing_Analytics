# Marketing_Campaign_Analytics
## Introduction 
Project Overview: ShopEasy, an online retail business, is facing reduced customer engagement and conversion rates despite launching several new online marketing campaigns. They requested data analyst  to help conduct a detailed analysis and visualization and identify areas for improvement in their marketing strategies. 
[Project live report](https://app.powerbi.com/view?r=eyJrIjoiN2E0NDJjOWQtY2M5YS00MGIwLTk2ODAtZWJhNTQ3YjIxOWVlIiwidCI6ImM2ZTU0OWIzLTVmNDUtNDAzMi1hYWU5LWQ0MjQ0ZGM1YjJjNCJ9)<br><br>


## Tools & Platform 
SQL, Power BI Desktop, SQL Server, Python, Dax Language, Power Query, Jupyter Notebook

## Functions or Library Used:
SQL: Join, CTE, Len, Upper, Replace, CHharindex, Left, Right, window function (ROW_NUMBER), Case when etc.<br>
Python: Pandas, Nltk, pyodbc, SentimentIntensityAnalyzer, Apply, Lambda, function etc.<br>
DAX: Calculate, All, Divide, Sum, Distinctcount, Selectedvalue, Variable, Average, If, Switch etc.

## Key Steps:
1. Import Database into SQL Server and perform data cleaning, data aggregation in SQL <br><br>
 ![SQL!](https://github.com/user-attachments/assets/17920f2b-6d81-46f5-9d91-5ea32a727901)<br><br>
 ![SQL!](https://github.com/user-attachments/assets/a81491ab-1d0c-4f72-8db6-dd33d6df4976)<br><br>
 ![SQL!](https://github.com/user-attachments/assets/46d02bb5-84bb-4670-a035-c7186ef25480)<br><br>
 
2. Establish connection with SQL Server and	Perform customer review sentiment analysis using Python<br><br>
![python!](https://github.com/user-attachments/assets/7757b635-d8bb-4d5c-967e-0078106f1ba2)<br><br>
![python!](https://github.com/user-attachments/assets/d38ed2dd-f02b-4a97-be8d-ddd660d3ee43)<br><br>
![python!](https://github.com/user-attachments/assets/f3952db6-6085-423a-b2f1-918117b2b14d)<br><br>
![python!](https://github.com/user-attachments/assets/cac1f963-5b19-4a8f-b938-0d785d53b749)<br><br>

3. import data from SQL Server to PowerBI <br><br>
 ![import data from sql server](https://github.com/user-attachments/assets/a43266f4-c088-4e50-a090-6d855a5b33a4)<br><br>
  
4.	Create measures, KPI, and data visualization <br><br>
 ![measures!](https://github.com/user-attachments/assets/48d28f3a-24c8-4051-9f7e-53a1dc37e16f)<br><br>
 ![customer engagement!](https://github.com/user-attachments/assets/4c3c7458-a7e3-4646-87f2-ad3195eaaff2)<br><br>
 ![customer journey!](https://github.com/user-attachments/assets/c8129c7b-9277-48a0-b7cc-a8e6bc2833b0)<br><br>
 ![customer review!](https://github.com/user-attachments/assets/f7e28f2e-25ce-43a6-a212-7fed11af9da6)<br><br>

## Insight
1. Customer Like% declining YOY (indicative of product offering not so favored by customers)<br>
    ----- engagement rate 4.49%, low engagement<br>
    -----products with higher view_click% have lower purchase% than prodcut with lower view_click rate<br>
    ![customer review!](https://github.com/user-attachments/assets/0f64af58-f109-4a07-975a-39c0e55bf6e4))<br><br>
2. campaign numer remained the same, but the view count on the declining trend every year. (check the view trend in 2023 and 2024)<br>
    ![engagment view count!](https://github.com/user-attachments/assets/4ae3578b-5002-4ec5-ae05-2cda6ac9ee9d)<br><br>
    ![engagment view count!](https://github.com/user-attachments/assets/1ad48951-23ef-48b7-8484-c79b29659340)<br><br>
3. Campaign platform: Blog and Social Media have higher engagement than Video and Newsletter
4. Product offering belong to higher price category have higher buy rate
5. Customer rating during time range around July and August are relatively lower
   ----(maybe need to investigate why rating is relatively low in AUgust, maybe due to shortstaff or supply chain issue or other reasons.)
6. Due to limited data here, would recommend the company to dive into negative and mix-negative comments to better identify the pinpoint behind the rationale
