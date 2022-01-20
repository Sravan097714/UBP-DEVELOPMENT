pageextension 50018 FixedAssetJrnExt extends "Fixed Asset Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(EditInExcel)
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
                    GenImportData: Codeunit "FA Import Files";
                begin
                    GenImportData.SetJournalTemplateBatch(Rec."Journal Template Name", Rec."Journal Batch Name");
                    GenImportData.ImportFAJnl();
                end;
            }
        }
    }

    var
        myInt: Integer;
}