namespace LeanovaLUExample.LeanovaLUExample;

using Microsoft.Sales.Document;

pageextension 50900 SalesOrderExt extends "Sales Order"
{
    actions
    {
        addafter(Category_Report)
        {
            group("Extensionsforce Examples Promoted")
            {
                Caption = 'Extensionsforce Examples';

                actionref("Create LU Promoted"; "Create LU")
                {
                }
                actionref("Post By Promoted"; "Post by LU")
                {
                }
            }
        }

        addbefore("F&unctions")
        {

            action("Create LU")
            {
                Caption = 'Create - Logistic Unit';
                Image = Item;
                ApplicationArea = All;
                ToolTip = 'Create new logistic unit';

                trigger OnAction()
                var
                    LogisticUnitManagement: Codeunit "Logistic Unit Management";
                    LogisticUnit: Record "TMAC Unit";
                begin
                    LogisticUnit := LogisticUnitManagement.CreateLogisticUnit(Rec, 'C20DC', 'BIC U 7878390', 'Container')
                end;
            }

            action("Post By LU")
            {
                Caption = 'Post By - Logistic Unit';
                Image = Item;
                ApplicationArea = All;
                ToolTip = 'Post By Logistic unit';

                trigger OnAction()
                var
                    LogisticUnitManagement: Codeunit "Logistic Unit Management";
                begin
                    LogisticUnitManagement.PostByLogisticUnit(Rec, 'PLT0002');
                end;
            }
        }
    }
}