/// <summary>
/// Create Logistic Unit Examples
/// </summary>
codeunit 50900 "Logistic Unit Management"
{
    EventSubscriberInstance = Manual; //Diable auto

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
        UnitBuild: Codeunit "TMAC Unit Build Management";
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

    /// <summary>
    /// Example: Post Logistic Unit by Logistic Unit
    /// </summary>
    /// <param name="SalesHeader"></param>
    /// <param name="LogisticUnitNo"></param>
    procedure PostByLogisticUnit(var SalesHeader: Record "Sales Header"; LogisticUnitNo: Code[20])
    var
        UnitPost: Codeunit "TMAC Unit Post";
        LogisticUnitManagement: Codeunit "Logistic Unit Management";
    begin
        BindSubscription(LogisticUnitManagement); //to disable selection dialog window we bind this codeunit with correct event handler
        UnitPost.PostByLogisticUnit(LogisticUnitNo, Database::"Sales Line", Database::"Sales Shipment Line");
        UnbindSubscription(LogisticUnitManagement);
    end;

    /// <summary>
    /// Diable Option Dialog of posting
    /// </summary>
    /// <param name="SalesHeader"></param>
    /// <param name="HideDialog"></param>
    /// <param name="IsHandled"></param>
    /// <param name="DefaultOption"></param>
    /// <param name="PostAndSend"></param>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", OnBeforeConfirmSalesPost, '', false, false)]
    internal procedure "Sales-Post (Yes/No)_OnBeforeConfirmSalesPost"(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
    begin
        HideDialog := true;
        DefaultOption := 3;
        SalesHeader.Ship := true;
        SalesHeader.Invoice := true;
    end;
}
