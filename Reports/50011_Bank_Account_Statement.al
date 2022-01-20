report 50011 "Bank Account Statements"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\Bank Account Statement-RCTS.rdl';
    Caption = 'Bank Account Statement';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            DataItemTableView = SORTING("Bank Account No.", "Statement No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Bank Account No.", "Statement No.";
            column(ComanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(BankAccStmtTableCaptFltr; TABLECAPTION + ': ' + BankAccStmtFilter)
            {
            }
            column(BankAccStmtFilter; BankAccStmtFilter)
            {
            }
            column(StmtNo_BankAccStmt; "Statement No.")
            {
                IncludeCaption = true;
            }
            column(Amt_BankAccStmtLineStmt; "Bank Account Statement Line"."Statement Amount")
            {
            }
            column(AppliedAmt_BankAccStmtLine; "Bank Account Statement Line"."Applied Amount")
            {
            }
            column(BankAccNo_BankAccStmt; "Bank Account No.")
            {
            }
            column(BankAccStmtCapt; BankAccStmtCaptLbl)
            {
            }
            column(CurrReportPAGENOCapt; CurrReportPAGENOCaptLbl)
            {
            }
            column(BnkAccStmtLinTrstnDteCapt; BnkAccStmtLinTrstnDteCaptLbl)
            {
            }
            column(BnkAcStmtLinValDteCapt; BnkAcStmtLinValDteCaptLbl)
            {
            }
            column(TotalamountBankLedger; "Bank Account Ledger Entry".Amount)
            {
            }
            column(TotalAmountLcyBankLedger; "Bank Account Ledger Entry"."Amount (LCY)") { }
            column(Statement_Ending_Balance; "Statement Ending Balance") { }
            column(Balance_Last_Statement; "Balance Last Statement") { }
            column(Statement_No_; "Statement No.") { }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."),
                               "Statement No." = FIELD("Statement No.");
                DataItemTableView = SORTING("Bank Account No.", "Statement No.", "Statement Line No.");
                column(TrnsctnDte_BnkAcStmtLin; FORMAT("Transaction Date"))
                {
                }
                column(Type_BankAccStmtLine; Type)
                {
                    IncludeCaption = true;
                }
                column(LineDocNo_BankAccStmt; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(AppliedEntr_BankAccStmtLine; "Applied Entries")
                {
                    IncludeCaption = true;
                }
                column(Amt1_BankAccStmtLineStmt; "Statement Amount")
                {
                    IncludeCaption = true;
                }
                column(AppliedAmt1_BankAccStmtLine; "Applied Amount")
                {
                    IncludeCaption = true;
                }
                column(Desc_BankAccStmtLine; Description)
                {
                    IncludeCaption = true;
                }
                column(ValueDate_BankAccStmtLine; FORMAT("Value Date"))
                {
                }

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS("Statement Amount", "Applied Amount");
                end;
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                column(BankAccountNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bank Account No.")
                {
                }
                column(EntryNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Entry No.")
                {
                }
                column(PostingDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(DocumentType_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document Type")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document No.")
                {
                }
                column(Amount_BankAccountLedgerEntry; "Bank Account Ledger Entry".Amount)
                {
                }
                column(Description_BankAccountLedgerEntry; "Bank Account Ledger Entry".Description)
                {
                }
                column(Amount__LCY_; "Amount (LCY)") { }

                trigger OnPreDataItem()
                begin
                    "Bank Account Ledger Entry".SetCurrentKey("Posting Date");
                    "Bank Account Ledger Entry".SETRANGE("Bank Account No.", "Bank Account Statement"."Bank Account No.");
                    "Bank Account Ledger Entry".SetFilter("Posting Date", '<=%1', "Bank Account Statement"."Statement Date");
                    "Bank Account Ledger Entry".SETRANGE(Open, TRUE);
                    CurrReport.CREATETOTALS(Amount, "Amount (LCY)");
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(
                  "Bank Account Statement Line"."Statement Amount",
                  "Bank Account Statement Line"."Applied Amount", "Bank Account Ledger Entry".Amount, "Bank Account Ledger Entry"."Amount (LCY)");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        TotalCaption = 'Total';
    }

    trigger OnPreReport()
    begin
        BankAccStmtFilter := "Bank Account Statement".GETFILTERS;
    end;

    var
        BankAccStmtFilter: Text;
        BankAccStmtCaptLbl: Label 'Bank Account Statement';
        CurrReportPAGENOCaptLbl: Label 'Page';
        BnkAccStmtLinTrstnDteCaptLbl: Label 'Transaction Date';
        BnkAcStmtLinValDteCaptLbl: Label 'Value Date';
}

