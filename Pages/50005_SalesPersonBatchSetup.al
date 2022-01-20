page 50005 "SalesPerson Batch Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SalesPerson Batch Setup";

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("Batch Name"; "Batch Name")
                {
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
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}