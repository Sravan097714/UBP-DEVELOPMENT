codeunit 50000 "Event Subscriber"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure OnAfterConfirmPost(var SalesHeader: Record "Sales Header")
    var
        UserSetUp: Record "User Setup";
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            if SalesHeader.Ship and SalesHeader.Invoice then begin
                UserSetUp.Get(UserId);
                if not UserSetUp."Ship & Invoice Sales Order" then
                    Error('Do not have permission to ship');
            end else
                if SalesHeader.Ship then begin
                    UserSetUp.Get(UserId);
                    if not UserSetUp."Ship Sales Order" then
                        Error('Do not have permission to ship and invoice');
                end else
                    if SalesHeader.Invoice then begin
                        UserSetUp.Get(UserId);
                        if not UserSetUp."Invoice Sales Order" then
                            Error('Do not have permission to invoice');
                    end;
        end else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
                UserSetUp.Get(UserId);
                if not UserSetUp."Invoice Sales Order" then
                    Error('Do not have permission to invoice');
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure PurchOnAfterConfirmPost(var PurchaseHeader: Record "Purchase Header")
    var
        UserSetUp: Record "User Setup";
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            if PurchaseHeader.Receive and PurchaseHeader.Invoice then begin
                UserSetUp.Get(UserId);
                if not UserSetUp."Receive & Invoice Purch. Order" then
                    Error('Do not have permission to ship');
            end else
                if PurchaseHeader.Receive then begin
                    UserSetUp.Get(UserId);
                    if not UserSetUp."Receive Purchase Order" then
                        Error('Do not have permission to ship and invoice');
                end else
                    if PurchaseHeader.Invoice then begin
                        UserSetUp.Get(UserId);
                        if not UserSetUp."Invoice Purchase Order" then
                            Error('Do not have permission to invoice');
                    end;
        end else
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then begin
                UserSetUp.Get(UserId);
                if not UserSetUp."Invoice Purchase Order" then
                    Error('Do not have permission to invoice');
            end;


    end;

    var
        myInt: Integer;
}