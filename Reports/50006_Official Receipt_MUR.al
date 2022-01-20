report 50006 "Official Receipt-MUR"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\OfficialReceiptMUR.rdl';
    Caption = 'Official Receipt-MUR';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem("G/L Register"; "G/L Register")
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Source Code" = FILTER('CASHRECJNL'));
            RequestFilterFields = "No.";
            column(CompInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(GLNo_; "G/L Register"."No.")
            {
            }
            column(CompInfo_Name; CompanyInfo.Name)
            {
            }
            column(User_ID; "User ID")
            {

            }
            column(OrderTakenBy; OrderTakenBy)
            { }
            dataitem(CopyLoop; Integer)
            {
                column(OutputNo_; OutputNo)
                {
                }
                column(CompArr1_; CompanyArr[1])
                {
                }
                column(CompArr2_; CompanyArr[2])
                {
                }
                column(CompArr3_; CompanyArr[3])
                {
                }
                column(CompArr4_; CompanyArr[4])
                {
                }
                column(CompArr5_; CompanyArr[5])
                {
                }
                column(CompArr6_; CompanyArr[6])
                {
                }
                column(CompArr7_; CompanyArr[7])
                {
                }
                column(CompArr8_; CompanyArr[8])
                {
                }
                column(CompArr9_; CompanyArr[9])
                {
                }
                column(CompArr10_; CompanyArr[10])
                {
                }
                column(Title2_; Title[2])
                {
                }

                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemTableView = SORTING("Entry No.")
                                        WHERE("Source Code" = FILTER('CASHRECJNL'),
                                              Amount = FILTER(> 0),
                                              Reversed = FILTER('No'));
                    RequestFilterFields = "Document No.", "Document Type", "Source Code", "Posting Date";
                    column(ClientCode_; ClientCode)
                    {
                    }
                    column(ClientName; ClientName) { }
                    column(EntryNo_BLE; "G/L Entry"."Entry No.")
                    {
                    }
                    column(Title1_; Title[1])
                    {
                    }
                    column(DocumentNo_BLE; "G/L Entry"."Document No.")
                    {
                    }
                    column(CustArray1_; CustArray[1])
                    {
                    }
                    column(CustArray2_; CustArray[2])
                    {
                    }
                    column(CustArray3_; CustArray[3])
                    {
                    }
                    column(CustArray4_; CustArray[4])
                    {
                    }
                    column(CustArray5_; CustArray[5])
                    {
                    }
                    column(CustArray6_; CustArray[6])
                    {
                    }
                    column(CustArray7_; CustArray[7])
                    {
                    }
                    column(PostingDate_BLE; "G/L Entry"."Posting Date")
                    {
                    }
                    // column(SalesPersonCode; "G/L Entry"."Shortcut Dimension 5 Code")
                    // {

                    // }
                    column(SalesPersonCode; SalesPersonName)
                    {

                    }
                    column(CurrencyCode_CLE; CustledgEntry."Currency Code")
                    {
                    }
                    column(CurrencyCode_Lbl; CurrencyCode)
                    {
                    }
                    column(DotText_; DotText)
                    {
                    }
                    column(NumberText1_; NumberText[1])
                    {
                    }
                    column(NumberText2_; NumberText[2])
                    {
                    }
                    column(CustomerName; CustArray[6])
                    {
                    }
                    column(ExtDocNo_BLE; "G/L Entry"."External Document No.")
                    {
                    }
                    column(AmtInFigures_; AmtInFigures)
                    {
                    }
                    column(ParticularsLBL_; ParticularsLbl)
                    {
                    }
                    column(ParticularsVal_; ParticularsVal)
                    {
                    }
                    column(AppliedAmt_; AppliedAmt)
                    {
                    }
                    column(UnAppliedAmt_; UnAppliedAmt)
                    {
                    }
                    column(PostingDate; "Detailed Cust. Ledg. Entry"."Posting Date")
                    {
                    }
                    column(TotalAmt_; TotalAmt)
                    {
                    }
                    column(CurrencyCode_; CurCod)
                    {
                    }
                    column(Amount_BLE; "G/L Entry".Amount)
                    {
                    }
                    column(PaymentMethodDesc_; PaymentMethodDesc)
                    {
                    }
                    column(Description_BLE; "G/L Entry".Description)
                    {
                    }
                    column(RemAmount_; RemAmount)
                    {
                    }
                    dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
                    {
                        DataItemLink = "Transaction No." = FIELD("Transaction No.");
                        DataItemTableView = SORTING("Customer No.", "Posting Date", "Entry Type", "Currency Code")
                                            WHERE("Entry Type" = FILTER(Application));
                        column(DocNo_CLE; CustLedgerEntry."Document No.")
                        {
                        }
                        column(DocType_; DocType)
                        {
                        }
                        column(DocumentDate_; CustLedgerEntry."Document Date")
                        {
                        }
                        column(DetAmount_; DetAmount)
                        {
                        }
                        column(Amount_DCLE; "Detailed Cust. Ledg. Entry"."Amount (LCY)" * -1)
                        {
                        }


                        trigger OnAfterGetRecord();
                        begin


                            IF ("G/L Entry"."Document Type" <> "G/L Entry"."Document Type"::Payment) AND
                            ("G/L Entry"."Bal. Account Type" <> "G/L Entry"."Bal. Account Type"::Customer) THEN
                                CurrReport.SKIP;

                            IF ("Detailed Cust. Ledg. Entry"."Cust. Ledger Entry No." IN ["G/L Register"."From Entry No."]) OR
                               ("Detailed Cust. Ledg. Entry"."Cust. Ledger Entry No." IN ["G/L Register"."To Entry No."]) THEN
                                CurrReport.SKIP;


                            IF CustLedgerEntry.GET("Detailed Cust. Ledg. Entry"."Cust. Ledger Entry No.") THEN BEGIN
                                DocType := CustLedgerEntry."Document Type";
                            END;

                            IF CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment THEN
                                CurrReport.SKIP;
                        end;
                    }
                    dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                    {
                        DataItemLink = "Transaction No." = FIELD("Transaction No.");
                        DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code")
                                            WHERE("Source Code" = FILTER('CASHRECJNL'));

                        trigger OnAfterGetRecord();
                        begin

                            IF ("G/L Entry"."Document Type" <> "G/L Entry"."Document Type"::Payment) AND
                            ("G/L Entry"."Bal. Account Type" <> "G/L Entry"."Bal. Account Type"::Customer) THEN
                                CurrReport.SKIP;

                            "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Amount (LCY)");
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin


                        CLEAR(ClientCode);
                        Clear(ClientName);
                        CLEAR(CustArray);
                        CLEAR(RemAmount);
                        Clear(PaymentMethodDesc);
                        Clear(SalesPersonName);

                        "G/L Entry".CalcFields("Shortcut Dimension 5 Code");

                        DimensionValuerec.SetRange(code, "G/L Entry"."Shortcut Dimension 5 Code");
                        // DimensionValuerec.SetRange("Global Dimension No.", 5);
                        if DimensionValuerec.FindFirst() then
                            SalesPersonName := DimensionValuerec.Name;

                        //Error('Code %1 name %2', "G/L Entry"."Shortcut Dimension 5 Code", SalesPersonName);

                        IF Customer.GET("Bal. Account No.") THEN BEGIN
                            CustArray[1] := Customer.Address;
                            CustArray[2] := Customer."Address 2";
                            CustArray[3] := Customer.City;
                            CustArray[4] := 'VAT REG NO. : ' + Customer."VAT Registration No.";
                            CustArray[6] := Customer.Name;
                            ClientName := Customer.Name;

                            /* IF Customer."Business Registraton No." <> '' THEN BEGIN
                                CustArray[5] := 'BRN :' + Customer."Business Registraton No.";

                                //CustArray[6] := Text008;
                            END; */
                            /* PaymentMethod.Reset();
                             PaymentMethod.SETRANGE(PaymentMethod.Code, "Cust. Ledger Entry"."Payment Method Code");
                             IF PaymentMethod.FIND('-') then
                                 PaymentMethodDesc := PaymentMethod.Description;
                                 */
                            COMPRESSARRAY(CustArray);
                        END;


                        IF Vendor.GET("Bal. Account No.") THEN BEGIN
                            CustArray[1] := Vendor.Address;
                            CustArray[2] := Vendor."Address 2";
                            CustArray[3] := Vendor.City;
                            CustArray[4] := 'VAT REG NO. : ' + Vendor."VAT Registration No.";
                            CustArray[6] := Vendor.Name;


                            /* IF Vendor."Business Registraton No." <> '' THEN BEGIN
                                CustArray[5] := 'BRN :' + Vendor."Business Registraton No.";
                                //CustArray[6] := Text008;
                            END; */
                            COMPRESSARRAY(CustArray);

                        END;


                        IF "Bal. Account Type" IN
                         ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor, "Bal. Account Type"::"G/L Account"] THEN
                            ClientCode := "Bal. Account No."
                        ELSE
                            ClientCode := '';


                        // CurCod := COPYSTR("Currency Code", 1, 3);
                        IF CurCod = '' THEN BEGIN
                            GLSetup.GET;
                            CurCod := COPYSTR(GLSetup."LCY Code", 1, 3);
                        END;


                        // PaymentMethod.SETRANGE(PaymentMethod.Code, "Payment Method");
                        /*IF PaymentMethod.FIND('-') THEN
                            PaymentMethodDesc := PaymentMethod.Description;*/
                        Clear(PaymentMethodDesc);
                        /* CustledgEntry.Reset();
                         CustledgEntry.SetRange(CustledgEntry."Payment Method Code", PaymentMethod.Code);
                         IF CustledgEntry.FIND('-') THEN
                         */
                        // PaymentMethod.Reset();
                        // PaymentMethod.SetRange(Code, CustledgEntry."Payment Method Code");
                        /*IF PaymentMethod.Get(CustledgEntry."Payment Method Code") THEN begin
                            PaymentMethodDesc := PaymentMethod.Description;
                            Message('%1----%2', PaymentMethod.Description, PaymentMethod.Code);
                        end;*/


                        CheckReport.InitTextVariable();
                        CheckReport.FormatNoText(NumberText, Amount, '');

                        CustledgEntry.SETRANGE(CustledgEntry."Transaction No.", "G/L Entry"."Transaction No.");
                        IF CustledgEntry.FIND('-') THEN BEGIN
                            CustledgEntry.CALCFIELDS(CustledgEntry."Remaining Amt. (LCY)");
                            RemAmount := CustledgEntry."Remaining Amt. (LCY)";
                            IF PaymentMethod.Get(CustledgEntry."Payment Method Code") THEN begin
                                PaymentMethodDesc := PaymentMethod.Description;

                            end;

                        END;



                        IF ("G/L Entry"."Document Type" = "G/L Entry"."Document Type"::Payment) AND
                        ("G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::Customer) THEN BEGIN
                            CLEAR(AppliedAmt);
                            CLEAR(UnAppliedAmt);
                            CLEAR(TotalAmt);
                            DetCustLedgerEntry.RESET;
                            DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Entry Type", DetCustLedgerEntry."Entry Type"::Application);
                            DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Transaction No.", "G/L Entry"."Transaction No.");
                            DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Document No.", "G/L Entry"."Document No.");
                            DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Initial Document Type", DetCustLedgerEntry."Initial Document Type"::Invoice);
                            DetCustLedgerEntry.SETRANGE(DetCustLedgerEntry."Source Code", 'CASHRECJNL');
                            IF DetCustLedgerEntry.FIND('-') THEN BEGIN

                                REPEAT
                                    AppliedAmt += ABS(DetCustLedgerEntry."Amount (LCY)");
                                UNTIL DetCustLedgerEntry.NEXT = 0;

                                UnAppliedAmt := 0;
                                TotalAmt := ABS(AppliedAmt) + UnAppliedAmt;
                            END ELSE BEGIN
                                CustLedgerEntry.RESET;
                                CustLedgerEntry.SETRANGE(CustLedgerEntry."Document No.", "G/L Entry"."Document No.");
                                CustLedgerEntry.SETRANGE(CustLedgerEntry."Transaction No.", "G/L Entry"."Transaction No.");
                                CustLedgerEntry.SETRANGE(CustLedgerEntry."Source Code", 'CASHRECJNL');
                                IF CustLedgerEntry.FIND('-') THEN BEGIN

                                    AppliedAmt := 0;
                                    CustLedgerEntry.CALCFIELDS(CustLedgerEntry."Amount (LCY)");
                                    UnAppliedAmt := ABS("Cust. Ledger Entry"."Amount (LCY)");
                                    TotalAmt := AppliedAmt + ABS(UnAppliedAmt);
                                END;
                            END;

                        END;

                        IF ("G/L Entry"."Document Type" = "G/L Entry"."Document Type"::Payment) AND
                        ("G/L Entry"."Bal. Account Type" = "G/L Entry"."Bal. Account Type"::"G/L Account") THEN BEGIN
                            CLEAR(AppliedAmt);
                            CLEAR(UnAppliedAmt);
                            CLEAR(TotalAmt);

                            AppliedAmt := 0;
                            UnAppliedAmt := ABS("G/L Entry"."Amount");
                            TotalAmt := AppliedAmt + ABS(UnAppliedAmt);
                        END;
                    end;

                    trigger OnPreDataItem();
                    begin

                        SETRANGE("Entry No.", "G/L Register"."From Entry No.", "G/L Register"."To Entry No.");
                        CurrReport.CREATETOTALS(Amount, RemAmount, "Amount");
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(Title[2]);
                    OutputNo += 1;

                    IF OutputNo > 1 THEN
                        Title[2] := Text002
                    ELSE
                        CLEAR(Title[2]);
                end;

                trigger OnPostDataItem();
                begin



                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "G/L Register".FIND('-') THEN
                            REPEAT
                                "G/L Register"."No. Printed" := "G/L Register"."No. Printed" + 1;
                                "G/L Register".MODIFY;
                                COMMIT;
                            UNTIL "G/L Register".NEXT = 0;
                    END;
                end;

                trigger OnPreDataItem();
                begin
                    // if "G/L Register"."No. Printed" = 0 then
                    //     SETRANGE(Number, 1, 2)
                    // else
                    //     SETRANGE(Number, 1, 2);

                    //  if "G/L Register"."No. Printed" = 0 then
                    //     SETRANGE(Number, 1, 2);



                    SETRANGE(Number, 1, 2);


                end;
            }

            trigger OnAfterGetRecord();
            begin
                IF CompanyInfo.GET THEN;
                CompanyInfo.CALCFIELDS(Picture);
                //Formataddress.CompanyRCTS(CompanyArr, CompanyInfo);
                Title[1] := Text001;
                CLEAR(Title[2]);
                IF "G/L Register"."No. Printed" > 1 THEN
                    Title[2] := Text002
                ELSE
                    CLEAR(Title[2]);



                User.RESET;
                User.SETRANGE(User."User Name", "G/L Register"."User ID");
                IF User.FINDLAST THEN BEGIN
                    OrderTakenBy := User."Full Name";
                end;


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
    }

    var
        GLRegFilter: Text[250];
        CompanyInfo: Record 79;
        CheckReport: Report 1401;
        NumberText: array[2] of Text[60];
        CurCod: Code[10];
        CustledgEntry: Record 21;
        GL: Record 17;
        GLSetup: Record 98;
        CustArray: array[7] of Text[100];
        Customer: Record 18;
        Vendor: Record 23;
        CompanyArr: array[10] of Text[100];
        Title: array[3] of Text[30];
        PaymentMethod: Record 289;
        PaymentMethodDesc: Text[30];
        ClientCode: Text[30];
        Amts: Decimal;
        RemAmount: Decimal;
        DocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        CustLedgerEntry: Record 21;
        IsCopy: Text[4];
        ClientName: Text[100];
        CustBRNText: Text[30];
        CustLabel: Text[10];
        BRNText: Text[30];
        CountryRegion: Record 9;
        DetCustLedgerEntry: Record 379;
        AppliedAmt: Decimal;
        UnAppliedAmt: Decimal;
        TotalAmt: Decimal;
        DetAmount: Decimal;
        AmtInFigures: Decimal;
        BankName: Text[100];
        BankRec: Record 270;
        CurrencyCode: Text[30];
        ParticularsLbl: Text[15];
        ParticularsVal: Text[100];
        DotText: Text[2];
        OutputNo: Integer;
        Text000: Label 'Access Denied!';
        Text001: Label 'OFFICIAL RECEIPT';
        Text002: Label 'COPY';
        Text003: Label 'Payment Receipt';
        Text004: Label 'Payment Voucher';
        Text005: Label 'Page %1';
        Text006: Label 'Pmt. Disc. Given';
        Text007: Label 'Pmt. Disc. Rcvd.';
        Text008: Label 'BRN : ';
        //Formataddress: Codeunit "Format Addresses";
        User: Record 2000000120;
        OrderTakenBy: Text;
        GLAcc: Record 15;
        GenJournalLine: Record 81;
        SalesPersonName: Text;
        DimensionValuerec: record "Dimension Value";
}

