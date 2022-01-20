xmlport 50003 "Export Sales Line NonInv"
{
    Direction = Export;
    Format = VariableText;
    schema
    {
        textelement(NodeName1)
        {
            tableelement(SalesLine; "Sales Line")
            {
                SourceTableView = where("Document Type" = const(Order));
                textattribute(DefaultCode)
                {

                }
                textattribute(SalesOrderNo)
                {
                    trigger OnBeforePassVariable()
                    begin
                        SalesOrderNo := SalesLine."Document No.";
                    end;
                }
                textattribute(CustomerNo)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CustomerNo := SalesLine."Sell-to Customer No.";
                    end;
                }
                textattribute(ItemCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemCode := SalesLine."No.";
                    end;
                }
                textattribute(QuantityOrder)
                {
                    trigger OnBeforePassVariable()
                    begin
                        QuantityOrder := DelChr(format(SalesLine.Quantity), '=', ',');
                    end;
                }
                textattribute(OrderDate)
                {
                    trigger OnBeforePassVariable()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        if SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") then
                            OrderDate := Format(SalesHeader."Order Date");
                    end;
                }
                textattribute(Time)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Time := format(DT2Time(CurrentDateTime));
                    end;
                }
                textattribute(UniqueCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UniqueCode := Format(SalesLine."Document Type") + SalesLine."Document No." + Format(SalesLine."Line No.");
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    Item: Record Item;
                begin
                    if Item.Get(SalesLine."No.") then begin
                        if Not (Item.Type = Item.Type::"Non-Inventory") then
                            currXMLport.Skip();
                    end else
                        currXMLport.Skip();
                    if PrevSalesOrderNo <> SalesLine."Document No." then begin
                        PrevSalesOrderNo := SalesLine."Document No.";
                        DefaultCode := 'E';
                    end else
                        DefaultCode := 'D';
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }

    var
        myInt: Integer;
        PrevSalesOrderNo: Code[20];
}