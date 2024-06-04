namespace LeanovaLUExample.LeanovaLUExample;

using Microsoft.Sales.Document;

pageextension 50900 SalesOrderExt extends "Sales Order"
{
    actions
    {
        addafter(Category_Report)
        {
            group("LU Examples Promoted")
            {
                Caption = 'LU Examples Examples';

                actionref("Create LU Promoted"; "Create LU")
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

            action("Create LU 2")
            {
                Caption = 'Leanova - Create - Logistic Unit - 2';
                Image = Item;
                ApplicationArea = All;
                ToolTip = 'Create new logistic unit';

                trigger OnAction()
                var
                    LogisticUnitManagement: Codeunit "Logistic Unit Management";
                begin
                    Message('test');
                end;
            }
        }
    }
}