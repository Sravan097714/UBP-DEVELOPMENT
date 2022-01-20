page 50000 XMLPortsRun
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Item)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50000);
                end;
            }
            action(Customer)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50001);
                end;
            }
            action(ShipAddress)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50002);
                end;
            }
            action(SalesLineNonInventory)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50003);
                end;
            }
            action(SalesLineService)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50004);
                end;
            }
        }
    }

    var
        myInt: Integer;
}