namespace LeanovaLUExample.LeanovaLUExample;
using Microsoft.Sales.Document;

/// <summary>
/// Create Logistic Unit Examples
/// </summary>
codeunit 50900 "Logistic Unit Management"
{
    /// <summary>
    /// Example: Create Logistic Unit by Sales Header
    /// </summary>
    /// <param name="SalesHeader"></param>
    /// <param name="LogisticUnitNo"></param>
    procedure CreateLogisticUnit(var SalesHeader: Record "Sales Header"; UnitType: Code[20]; NewLogisticUnitNo: Code[20]; LogisticUnitDescription: Text) LogisticUnit: Record "TMAC Unit"
    var
        SalesLine: Record "Sales Line";
        UnitManagement: Codeunit "TMAC Unit Management";
        UnitLinkManagement: Codeunit "TMAC Unit Link Management";
        UnitBuild:Codeunit "TMAC Unit Build Management";
        SourceDocumentLink: Record "TMAC Source Document Link";
        //UnitNo: Code[20];
    begin
        SalesHeader.TestField(Status, "Sales Document Status"::Released);

        //Get Links to document Lines
        UnitLinkManagement.FillSourceDocumentTable(SourceDocumentLink, Database::"Sales Line", SalesHeader."Document Type".AsInteger(), SalesHeader."No.", 0, 0, 0, false);
        SourceDocumentLink.Reset;
        if SourceDocumentLink.FindSet() then
            repeat
                SourceDocumentLink.Validate("Selected Quantity", SourceDocumentLink.Quantity);
                SourceDocumentLink.Modify(false);
            until SourceDocumentLink.Next() = 0;
        
        //Create Logistiv Unit
        LogisticUnit.Get(UnitManagement.CreateUnitByType(UnitType, LogisticUnitDescription));

        SourceDocumentLink.Reset();
        SourceDocumentLink.SetCurrentKey("Item No.", "Variant Code", "Unit of Measure Code");
        if SourceDocumentLink.findset(false) then
            repeat
                SourceDocumentLink.Validate("Selected Quantity");
                UnitManagement.AddItemToLogisticUnit(LogisticUnit."No.", SourceDocumentLink."Selected Quantity", SourceDocumentLink);
            until SourceDocumentLink.Next() = 0;
    end;
}
