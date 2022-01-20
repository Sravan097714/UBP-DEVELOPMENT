pageextension 50017 "Item Journal" extends "Item Journal"
{
    layout
    {
        modify("Gen. Prod. Posting Group") { Visible = true; }
    }

    actions
    {
        addafter("&Get Standard Journals")
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
                    GenImportData.ImportItemJnlFile();
                end;
            }
        }
    }
}