tableextension 50017 "General Ledger SetupExt" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "SalesPerson Document Nos"; Code[20])
        {
            TableRelation = "No. Series";

        }
        // Add changes to table fields here
    }


}