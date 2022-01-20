pageextension 50027 "Charts of Account Ext" extends "G/L Account Card"
{
    layout
    {
        addafter("Omit Default Descr. in Jnl.")
        {
            field("Sales Person"; "Sales Person")
            {
                ApplicationArea = all;
            }
        }


        // Add changes to page layout here
    }


}