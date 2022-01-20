pageextension 50010 UserSetupExts extends "User Setup"
{
    layout
    {
        addafter("Service Resp. Ctr. Filter")
        {
            field("Discount Amount(Max)"; Rec."Discount Amount(Max)")
            {
                ApplicationArea = all;
            }
            field("Ship Sales Order"; Rec."Ship Sales Order")
            {
                ApplicationArea = all;
            }
            field("Invoice Sales Order"; Rec."Invoice Sales Order")
            {
                ApplicationArea = all;
            }
            field("Ship & Invoice Sales Order"; Rec."Ship & Invoice Sales Order")
            {
                ApplicationArea = all;
            }
            field("Receive Purchase Order"; Rec."Receive Purchase Order")
            {
                ApplicationArea = all;
            }
            field("Invoice Purchase Order"; Rec."Invoice Purchase Order")
            {
                ApplicationArea = all;
            }
            field("Receive & Invoice Purch. Order"; Rec."Receive & Invoice Purch. Order")
            {
                ApplicationArea = all;
            }
            field("Modify Unit Price"; "Modify Unit Price")
            {
                ApplicationArea = all;
            }
            field("Batch Name"; "Batch Name")
            {
                Visible = false;
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    GenJournalBatchRec: Record "Gen. Journal Batch";
                    GenJournalPage: Page "General Journal BatchDropdown";

                begin
                    GenJournalBatchRec.Reset();

                    GenJournalPage.SetRecord(GenJournalBatchRec);
                    GenJournalPage.SetTableView(GenJournalBatchRec);
                    GenJournalPage.LookupMode(true);
                    if GenJournalPage.RunModal = Action::LookupOK then begin
                        GenJournalPage.GetRecord(GenJournalBatchRec);
                        "Batch Name" := GenJournalBatchRec.Name;

                    end;


                end;


            }
            field("Batches Assigned"; "Batches Assigned")
            {
                ApplicationArea = all;
            }
            field("ReOpen Sales Order"; "ReOpen Sales Order")
            {
                Caption = 'Re-Open Sales Order';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {

            action(SalesPersonBatchSetup)
            {
                ApplicationArea = all;
                Promoted = true;
                Caption = 'SalesPerson Batch Setup';
                RunObject = page "SalesPerson Batch Setup";
                RunPageLink = "User ID" = field("User ID");
            }
        }

    }



    // Add changes to page actions here

}