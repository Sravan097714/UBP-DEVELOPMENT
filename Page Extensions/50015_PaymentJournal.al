pageextension 50015 "Payment Journal" extends "Payment Journal"
{
    layout
    {
        addlast(Control1)
        {

        }
    }
    actions
    {
        addafter("Request Approval")
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
                    GenImportData.ImportGenJnlFile();
                end;
            }
        }
    }

}