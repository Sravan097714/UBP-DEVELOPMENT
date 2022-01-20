tableextension 50009 BankAccountReconineExt extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; "Debit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Credit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Debit Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Credit Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}