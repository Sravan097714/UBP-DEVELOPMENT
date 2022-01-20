pageextension 50003 SalesOrdersubform extends "Sales Order Subform"
{
    layout
    {
        modify("Line No.")
        {
            Visible = true;
            Editable = false;
        }
        modify("Line Discount %")
        {
            Editable = false;
        }

        modify("Inv. Discount Amount")
        {
            Visible = false;
        }
        modify("Line Discount Amount")
        {
            Caption = 'Line Discount Amount Total';
            Visible = true;
            Editable = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Unit Price")
        {
            Editable = EditableUnitprice;
        }
        modify(Type)
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField(Type, Rec.Type::Item);
            end;
        }
        addbefore("Line Discount Amount")
        {
            field("Line Discount Amount Per Unit"; Rec."Line Discount Amount Per Unit")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    DeltaUpdateTotals();
                end;
            }
        }
        movefirst(Control1; "Line No.")
        addbefore(Type)
        {

            field("Corresponding Item Line No"; "Corresponding Item Line No")
            {
                ApplicationArea = all;
            }
        }
        modify("No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                StdText: Record "Standard Text";
                StdTextList: Page "Standard Text Codes";

                GLAccount: Record "G/L Account";
                GLAccList: Page "G/L Account List";

                Item: Record Item;
                ItemList: Page "Item List";

                Resource: Record Resource;
                ResourcesList: Page "Resource List";

                FixedAsset: Record "Fixed Asset";
                FixedAssetList: Page "Fixed Asset List";

                ItemCharge: Record "Item Charge";
                ItemChargeList: Page "Item Charges";

            begin
                case Type of
                    Type::" ":
                        begin
                            Clear(StdTextList);
                            StdText.Reset();
                            StdTextList.SetTableView(StdText);
                            StdTextList.SetRecord(StdText);
                            StdTextList.LookupMode(true);
                            if StdTextList.RunModal() = Action::LookupOK then begin
                                StdTextList.GetRecord(StdText);
                                Rec.Validate("No.", StdText.Code);
                            end;
                        end;

                    Type::"G/L Account":
                        begin
                            GLAccount.Reset();
                            GLAccList.SetTableView(GLAccount);
                            GLAccList.SetRecord(GLAccount);
                            GLAccList.LookupMode(true);
                            if GLAccList.RunModal() = Action::LookupOK then begin
                                GLAccList.GetRecord(GLAccount);
                                Rec.Validate("No.", GLAccount."No.");
                            end;
                        end;

                    Type::Item:
                        begin
                            Item.Reset();
                            Item.SetFilter(Type, '%1|%2', Item.Type::"Non-Inventory", Item.Type::Service);
                            ItemList.SetTableView(Item);
                            ItemList.SetRecord(Item);
                            ItemList.LookupMode(true);
                            if ItemList.RunModal() = Action::LookupOK then begin
                                ItemList.GetRecord(Item);
                                Rec.Validate("No.", Item."No.");
                            end;
                        end;

                    Type::Resource:
                        begin
                            Resource.Reset();
                            ResourcesList.SetTableView(Resource);
                            ResourcesList.SetRecord(Resource);
                            ResourcesList.LookupMode(true);
                            if ResourcesList.RunModal() = Action::LookupOK then begin
                                ResourcesList.GetRecord(Resource);
                                Rec.Validate("No.", Resource."No.");
                            end;
                        end;


                    Type::"Fixed Asset":
                        begin
                            FixedAsset.Reset();
                            FixedAssetList.SetTableView(FixedAsset);
                            FixedAssetList.SetRecord(FixedAsset);
                            FixedAssetList.LookupMode(true);
                            if FixedAssetList.RunModal() = Action::LookupOK then begin
                                FixedAssetList.GetRecord(FixedAsset);
                                Rec.Validate("No.", FixedAsset."No.");
                            end;
                        end;

                    Type::"Charge (Item)":
                        begin
                            ItemCharge.Reset();
                            ItemChargeList.SetTableView(ItemCharge);
                            ItemChargeList.SetRecord(ItemCharge);
                            ItemChargeList.LookupMode(true);
                            if ItemChargeList.RunModal() = Action::LookupOK then begin
                                ItemChargeList.GetRecord(ItemCharge);
                                Rec.Validate("No.", ItemCharge."No.");
                            end;
                        end;
                end;
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        Usersetup: Record "User Setup";
    begin
        if Usersetup.Get(UserId) then
            EditableUnitprice := Usersetup."Modify Unit Price"
        else
            EditableUnitprice := false;
    end;

    var
        myInt: Integer;
        EditableUnitprice: Boolean;
}