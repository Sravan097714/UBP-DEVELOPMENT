pageextension 50013 SalesJnl extends "Sales Journal"
{
    layout
    {

    }


    actions

    {
        addafter("Apply Entries")
        {
            action("Import Entries")
            {
                ApplicationArea = All;
                Caption = 'Import Entries';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                ToolTip = 'Import journal from desktop';

                trigger OnAction()
                var
                    GenImportData: Codeunit "Import Files";
                begin
                    GenImportData.SetJournalTemplateBatch(Rec."Journal Template Name", Rec."Journal Batch Name");
                    GenImportData.ImportPurchaseJnl();
                end;
            }
        }
    }
}

