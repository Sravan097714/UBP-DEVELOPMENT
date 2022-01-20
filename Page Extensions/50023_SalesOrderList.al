pageextension 50023 SalesOrderList extends "Sales Order List"
{
    layout
    {
        addafter("Quote No.")
        {
            field("Created By"; "Created By")
            {
                ApplicationArea = all;
            }

        }
    }


}