# Logistics Units Examples
This repository contains example codes for working with the Logistics Units extension for Microsoft Dynamics 365 Business Central.

[Appsource page of the Logistic Units extension](https://appsource.microsoft.com/en-us/product/dynamics-365-business-central/PUBID.extensionsforcelimited1647259189111%7CAID.logisticunits%7CPAPPID.c383b772-f29f-4c05-b1ac-7801c76750af?tab=Overview)

  
   ![alt text](https://github.com/ExtensionsForce/LogisticUnitsExamples/blob/main/github/AppsourceLogisticUnits.png)

All examples are contained in the Logistic Unit Management codeunit.

  ![alt text](https://github.com/ExtensionsForce/LogisticUnitsExamples/blob/main/github/LogisticUnitManagement.png)

The user interface will be posted in the appropriate documents.

   ![alt text](https://github.com/ExtensionsForce/LogisticUnitsExamples/blob/main/github/Example1.png)

Current examples:
1) Create logistics unit for sales order.

2) Post by Logistic Unit

   procedure PostByLogisticUnit(var SalesHeader: Record "Sales Header"; LogisticUnitNo: Code[20])

