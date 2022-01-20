pageextension 50024 "Order Processor Ext" extends "Order Processor Role Center"
{


    actions
    {
        // Add changes to page actions here
        modify(CashReceiptJournals)
        {
            Visible = false;
        }
        addafter(CashReceiptJournals)
        {
            action(CashReceiptJournals2)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Journals ';
                Image = Journals;
                RunObject = Page "General Journal Batch Cust.";
                RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                    Recurring = CONST(false));
                ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
            }

        }

        // addafter("Posted Documents")
        // {

        //     group(Setup)
        //     {
        //         Caption = 'Sales Person Setup';
        //         action(SalesPoersonBatchSetup)
        //         {
        //             ApplicationArea = Basic, Suite;
        //             Caption = 'SalesPerson Batch Setup';
        //             RunObject = page "SalesPerson Batch Setup";
        //         }
        //     }



        // }

    }


}