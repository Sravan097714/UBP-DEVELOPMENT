report 50066 "Attachment Advice"
{
    // //>>TBS82-ELL-26/06/17 : Modification mise en page
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\AttachmentAdvice.rdl';
    UsageCategory = ReportsAndAnalysis;

    Caption = 'Attachment Advice';
    AdditionalSearchTerms = 'Attachment Advice';
    Permissions = TableData 270 = m;

    dataset
    {
        dataitem(GenJnlLine; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
            RequestFilterFields = "Journal Template Name", "Journal Batch Name";
            column(JnlTemplName_GenJnlLine; "Journal Template Name")
            {
            }
            column(JnlBatchName_GenJnlLine; "Journal Batch Name")
            {
            }
            column(LineNo_GenJnlLine; "Line No.")
            {
            }
            column(BankAccountNo; "Bal. Account No.")
            {
            }
            column(PrintedOnCaption; PrintedOnCaptionLbl)
            {
            }
            column(TitleCaption; Text001)
            {
            }
            column(CurrentDateTime; CURRENTDATETIME)
            {
            }
            column(UserName; UserSetup."Name on documents")
            {
            }
            column(PrintedByCaption; PrintedByCaptionLbl)
            {
            }
            column(CompanyAddr_1; CompanyAddr[1])
            {
            }
            column(CompanyAddr_2; CompanyAddr[2])
            {
            }
            column(CompanyAddr_3; CompanyAddr[3])
            {
            }
            column(CompanyAddr_4; CompanyAddr[4])
            {
            }
            column(CompanyAddr_5; CompanyAddr[5])
            {
            }
            column(FaxNoCaption; FaxNoCaptionLbl)
            {
            }
            column(PhoneCaption; PhoneCaptionLbl)
            {
            }
            column(BRNCaption; BRNCaptionLbl)
            {
            }
            column(VATNoCaption; VATNoCaptionLbl)
            {
            }
            column(BRN; CompanyInfo.BRN)
            {
            }
            column(VATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CheckToAddr1; CheckToAddr[1])
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(CheckDocNo; CheckDocNo)
            {
            }
            dataitem(CheckPages; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(CheckDateText; CheckDateText)
                {
                }
                column(CheckNoText; CheckNoText)
                {
                }
                column(FirstPage; FirstPage)
                {
                }
                column(CheckNoTextCaption; CheckNoTextCaptionLbl)
                {
                }
                dataitem(PrintSettledLoop; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 30;
                    column(NetAmount; NetAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineDiscountLineDisc; TotalLineDiscount - LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineAmountLineAmount; TotalLineAmount - LineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalLineAmountLineAmount2; TotalLineAmount - LineAmount2)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount; LineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineDiscount; LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmountLineDiscount; LineAmount + LineDiscount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(DocNo; DocNo)
                    {
                    }
                    column(DocDate; DocDate)
                    {
                    }
                    column(DocDescription; DocDescription)
                    {
                    }
                    column(CurrencyCode2; CurrencyCode2)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(CurrentLineAmount; CurrentLineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(ExtDocNo; ExtDocNo)
                    {
                    }
                    column(LineAmountCaption; LineAmountCaptionLbl)
                    {
                    }
                    column(LineDiscountCaption; LineDiscountCaptionLbl)
                    {
                    }
                    column(AmountCaption; AmountCaptionLbl)
                    {
                    }
                    column(CashBookNoCaption; CashBookNoCaptionLbl)
                    {
                    }
                    column(DateCaption; DateCaptionLbl)
                    {
                    }
                    column(CurrencyCodeCaption; CurrencyCodeCaptionLbl)
                    {
                    }
                    column(SupplierInvoiceCaption; SupplierInvoiceCaptionLbl)
                    {
                    }
                    column(OurReferenceCaption; OurReferenceCaptionLbl)
                    {
                    }
                    column(BankAccountCaption; BankAccountCaptionLbl)
                    {
                    }
                    column(NoOfLines; NoOfLines)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF FoundLast THEN BEGIN
                            IF RemainingAmount <> 0 THEN BEGIN
                                DocNo := '';
                                ExtDocNo := '';
                                DocDate := 0D;
                                DocDescription := '';
                                LineAmount := RemainingAmount;
                                LineAmount2 := RemainingAmount;
                                CurrentLineAmount := LineAmount2;
                                LineDiscount := 0;
                                RemainingAmount := 0;
                            END ELSE
                                CurrReport.BREAK;
                        END ELSE BEGIN
                            CASE ApplyMethod OF
                                ApplyMethod::OneLineOneEntry:
                                    BEGIN
                                        CASE BalancingType OF
                                            BalancingType::Customer:
                                                BEGIN
                                                    CustLedgEntry.RESET;
                                                    CustLedgEntry.SETCURRENTKEY("Document No.");
                                                    CustLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                    CustLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                    CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                    CustLedgEntry.FIND('-');
                                                    CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                END;
                                            BalancingType::Vendor:
                                                BEGIN
                                                    VendLedgEntry.RESET;
                                                    VendLedgEntry.SETCURRENTKEY("Document No.");
                                                    VendLedgEntry.SETRANGE("Document Type", GenJnlLine."Applies-to Doc. Type");
                                                    VendLedgEntry.SETRANGE("Document No.", GenJnlLine."Applies-to Doc. No.");
                                                    VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                    VendLedgEntry.FIND('-');
                                                    VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                END;
                                        END;
                                        RemainingAmount := RemainingAmount - LineAmount2;
                                        CurrentLineAmount := LineAmount2;
                                        FoundLast := TRUE;
                                    END;
                                ApplyMethod::OneLineID:
                                    BEGIN
                                        CASE BalancingType OF
                                            BalancingType::Customer:
                                                BEGIN
                                                    CustUpdateAmounts(CustLedgEntry, RemainingAmount);
                                                    FoundLast := (CustLedgEntry.NEXT = 0) OR (RemainingAmount <= 0);
                                                    IF FoundLast AND NOT FoundNegative THEN BEGIN
                                                        CustLedgEntry.SETRANGE(Positive, FALSE);
                                                        FoundLast := NOT CustLedgEntry.FIND('-');
                                                        FoundNegative := TRUE;
                                                    END;
                                                END;
                                            BalancingType::Vendor:
                                                BEGIN
                                                    VendUpdateAmounts(VendLedgEntry, RemainingAmount);
                                                    FoundLast := (VendLedgEntry.NEXT = 0) OR (RemainingAmount <= 0);
                                                    IF FoundLast AND NOT FoundNegative THEN BEGIN
                                                        VendLedgEntry.SETRANGE(Positive, FALSE);
                                                        FoundLast := NOT VendLedgEntry.FIND('-');
                                                        FoundNegative := TRUE;
                                                    END;
                                                END;
                                        END;
                                        RemainingAmount := RemainingAmount - LineAmount2;
                                        CurrentLineAmount := LineAmount2;
                                    END;
                                ApplyMethod::MoreLinesOneEntry:
                                    BEGIN
                                        CurrentLineAmount := GenJnlLine2.Amount;
                                        LineAmount2 := CurrentLineAmount;
                                        GenJnlLine2.TESTFIELD("Bank Payment Type", GenJnlLine2."Bank Payment Type"::"Computer Check");
                                        IF GenJnlLine2."Applies-to Doc. No." = '' THEN BEGIN
                                            DocNo := '';
                                            ExtDocNo := '';
                                            DocDate := 0D;
                                            DocDescription := '';
                                            LineAmount := CurrentLineAmount;
                                            LineDiscount := 0;
                                        END ELSE BEGIN
                                            CASE BalancingType OF
                                                BalancingType::"G/L Account":
                                                    BEGIN
                                                        DocNo := GenJnlLine2."Document No.";
                                                        ExtDocNo := GenJnlLine2."External Document No.";
                                                        LineAmount := CurrentLineAmount;
                                                        LineDiscount := 0;
                                                    END;
                                                BalancingType::Customer:
                                                    BEGIN
                                                        CustLedgEntry.RESET;
                                                        CustLedgEntry.SETCURRENTKEY("Document No.");
                                                        CustLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                        CustLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                        CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                        CustLedgEntry.FIND('-');
                                                        CustUpdateAmounts(CustLedgEntry, CurrentLineAmount);
                                                        LineAmount := CurrentLineAmount;
                                                    END;
                                                BalancingType::Vendor:
                                                    BEGIN
                                                        VendLedgEntry.RESET;
                                                        IF GenJnlLine2."Source Line No." <> 0 THEN
                                                            VendLedgEntry.SETRANGE("Entry No.", GenJnlLine2."Source Line No.")
                                                        ELSE BEGIN
                                                            VendLedgEntry.SETCURRENTKEY("Document No.");
                                                            VendLedgEntry.SETRANGE("Document Type", GenJnlLine2."Applies-to Doc. Type");
                                                            VendLedgEntry.SETRANGE("Document No.", GenJnlLine2."Applies-to Doc. No.");
                                                            VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                        END;
                                                        VendLedgEntry.FIND('-');
                                                        VendUpdateAmounts(VendLedgEntry, CurrentLineAmount);
                                                        LineAmount := CurrentLineAmount;
                                                    END;
                                                BalancingType::"Bank Account":
                                                    BEGIN
                                                        DocNo := GenJnlLine2."Document No.";
                                                        ExtDocNo := GenJnlLine2."External Document No.";
                                                        LineAmount := CurrentLineAmount;
                                                        LineDiscount := 0;
                                                    END;
                                            END;
                                        END;
                                        FoundLast := GenJnlLine2.NEXT = 0;
                                    END;
                            END;
                        END;
                        TotalLineAmount := TotalLineAmount + LineAmount2;
                        TotalLineDiscount := TotalLineDiscount + LineDiscount;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF FirstPage THEN BEGIN
                            FoundLast := TRUE;
                            CASE ApplyMethod OF
                                ApplyMethod::OneLineOneEntry:
                                    FoundLast := FALSE;
                                ApplyMethod::OneLineID:
                                    CASE BalancingType OF
                                        BalancingType::Customer:
                                            BEGIN
                                                CustLedgEntry.RESET;
                                                CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                                                CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                                CustLedgEntry.SETRANGE(Open, TRUE);
                                                CustLedgEntry.SETRANGE(Positive, TRUE);
                                                CustLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                FoundLast := NOT CustLedgEntry.FIND('-');
                                                IF FoundLast THEN BEGIN
                                                    CustLedgEntry.SETRANGE(Positive, FALSE);
                                                    //>>TBS82
                                                    NoOfLines := CustLedgEntry.COUNT;
                                                    //<<TBS82
                                                    FoundLast := NOT CustLedgEntry.FIND('-');
                                                    FoundNegative := TRUE;
                                                END ELSE
                                                    FoundNegative := FALSE;
                                            END;
                                        BalancingType::Vendor:
                                            BEGIN
                                                VendLedgEntry.RESET;
                                                VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                                                VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                                VendLedgEntry.SETRANGE(Open, TRUE);
                                                VendLedgEntry.SETRANGE(Positive, TRUE);
                                                VendLedgEntry.SETRANGE("Applies-to ID", GenJnlLine."Applies-to ID");
                                                FoundLast := NOT VendLedgEntry.FIND('-');
                                                IF FoundLast THEN BEGIN
                                                    VendLedgEntry.SETRANGE(Positive, FALSE);
                                                    //>>TBS82
                                                    NoOfLines := VendLedgEntry.COUNT;
                                                    //<<TBS82
                                                    FoundLast := NOT VendLedgEntry.FIND('-');
                                                    FoundNegative := TRUE;
                                                END ELSE
                                                    FoundNegative := FALSE;
                                            END;
                                    END;
                                ApplyMethod::MoreLinesOneEntry:
                                    FoundLast := FALSE;
                            END;
                        END
                        ELSE
                            FoundLast := FALSE;

                        IF DocNo = '' THEN
                            CurrencyCode2 := GenJnlLine."Currency Code";

                        TotalText := Text019;

                        IF GenJnlLine."Currency Code" <> '' THEN
                            NetAmount := STRSUBSTNO(Text063, GenJnlLine."Currency Code")
                        ELSE BEGIN
                            GLSetup.GET;
                            NetAmount := STRSUBSTNO(Text063, GLSetup."LCY Code");
                        END;
                    end;
                }
                dataitem(PrintCheck; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(CheckAmountText; CheckAmountText)
                    {
                    }
                    column(CheckDateText2; CheckDateText)
                    {
                    }
                    column(DescriptionLine2; DescriptionLine[2])
                    {
                    }
                    column(DescriptionLine1; DescriptionLine[1])
                    {
                    }
                    column(CheckToAddr17; CheckToAddr[1])
                    {
                    }
                    column(CheckToAddr2; CheckToAddr[2])
                    {
                    }
                    column(CheckToAddr4; CheckToAddr[4])
                    {
                    }
                    column(CheckToAddr3; CheckToAddr[3])
                    {
                    }
                    column(CheckToAddr5; CheckToAddr[5])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr8; CompanyAddr[8])
                    {
                    }
                    column(CompanyAddr7; CompanyAddr[7])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CheckNoText2; CheckNoText)
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(TotalLineAmount; TotalLineAmount)
                    {
                        AutoFormatExpression = GenJnlLine."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(VoidText; VoidText)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        Decimals: Decimal;
                        CheckLedgEntryAmount: Decimal;
                    begin
                        ChecksPrinted := ChecksPrinted + 1;
                        FirstPage := FALSE;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF FoundLast THEN
                        CurrReport.BREAK;
                end;

                trigger OnPostDataItem()
                begin
                    CLEAR(CheckManagement);
                end;

                trigger OnPreDataItem()
                begin
                    FirstPage := TRUE;
                    FoundLast := FALSE;
                    TotalLineAmount := 0;
                    TotalLineDiscount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF OneCheckPrVendor AND (GenJnlLine."Currency Code" <> '') AND
                   (GenJnlLine."Currency Code" <> Currency.Code)
                THEN BEGIN
                    Currency.GET(GenJnlLine."Currency Code");
                    Currency.TESTFIELD("Conv. LCY Rndg. Debit Acc.");
                    Currency.TESTFIELD("Conv. LCY Rndg. Credit Acc.");
                END;

                IF "Bank Payment Type" = "Bank Payment Type"::"Computer Check" THEN
                    TESTFIELD("Exported to Payment File", FALSE);

                IF Amount = 0 THEN BEGIN
                    CurrReport.SKIP;
                END;
                TESTFIELD("Bal. Account Type", "Bal. Account Type"::"Bank Account");
                BankAcc2.GET("Bal. Account No.");

                IF ("Account No." <> '') AND ("Bal. Account No." <> '') THEN BEGIN
                    BalancingType := "Account Type";
                    BalancingNo := "Account No.";
                    RemainingAmount := Amount;
                    IF OneCheckPrVendor THEN BEGIN
                        ApplyMethod := ApplyMethod::MoreLinesOneEntry;
                        GenJnlLine2.RESET;
                        GenJnlLine2.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                        GenJnlLine2.SETRANGE("Journal Template Name", "Journal Template Name");
                        GenJnlLine2.SETRANGE("Journal Batch Name", "Journal Batch Name");
                        GenJnlLine2.SETRANGE("Posting Date", "Posting Date");
                        GenJnlLine2.SETRANGE("Document No.", "Document No.");
                        GenJnlLine2.SETRANGE("Account Type", "Account Type");
                        GenJnlLine2.SETRANGE("Account No.", "Account No.");
                        GenJnlLine2.SETRANGE("Bal. Account Type", "Bal. Account Type");
                        GenJnlLine2.SETRANGE("Bal. Account No.", "Bal. Account No.");
                        GenJnlLine2.SETRANGE("Bank Payment Type", "Bank Payment Type");
                        GenJnlLine2.FIND('-');
                        RemainingAmount := 0;
                    END ELSE
                        IF "Applies-to Doc. No." <> '' THEN
                            ApplyMethod := ApplyMethod::OneLineOneEntry
                        ELSE
                            IF "Applies-to ID" <> '' THEN
                                ApplyMethod := ApplyMethod::OneLineID
                            ELSE
                                ApplyMethod := ApplyMethod::Payment;
                END;
                CLEAR(CheckToAddr);
                CLEAR(SalesPurchPerson);
                CASE BalancingType OF
                    BalancingType::"G/L Account":
                        BEGIN
                            CheckToAddr[1] := GenJnlLine.Description;
                            IF PrintForCheck THEN
                                CurrReport.SKIP;
                        END;
                    BalancingType::Customer:
                        BEGIN
                            Cust.GET(BalancingNo);
                            Cust.Contact := '';
                            FormatAddr.Customer(CheckToAddr, Cust);
                            IF Cust."Salesperson Code" <> '' THEN
                                SalesPurchPerson.GET(Cust."Salesperson Code");
                            IF PrintForCheck THEN BEGIN
                                CustLedgEntry.RESET;
                                CustLedgEntry.SETCURRENTKEY("Customer No.", Open, Positive);
                                CustLedgEntry.SETRANGE("Customer No.", BalancingNo);
                                CustLedgEntry.SETRANGE(Open, TRUE);
                                CustLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                                IF CustLedgEntry.COUNT < 21 THEN
                                    CurrReport.SKIP;
                            END;
                        END;
                    BalancingType::Vendor:
                        BEGIN
                            Vend.GET(BalancingNo);
                            Vend.Contact := '';
                            FormatAddr.Vendor(CheckToAddr, Vend);
                            IF Vend."Purchaser Code" <> '' THEN
                                SalesPurchPerson.GET(Vend."Purchaser Code");
                            IF PrintForCheck THEN BEGIN
                                VendLedgEntry.RESET;
                                VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive);
                                VendLedgEntry.SETRANGE("Vendor No.", BalancingNo);
                                VendLedgEntry.SETRANGE(Open, TRUE);
                                VendLedgEntry.SETRANGE("Applies-to ID", "Applies-to ID");
                                IF VendLedgEntry.COUNT < 21 THEN
                                    CurrReport.SKIP;
                            END;
                        END;
                    BalancingType::"Bank Account":
                        BEGIN
                            BankAcc.GET(BalancingNo);
                            BankAcc.TESTFIELD(Blocked, FALSE);
                            BankAcc.Contact := '';
                            FormatAddr.BankAcc(CheckToAddr, BankAcc);
                            IF BankAcc."Our Contact Code" <> '' THEN
                                SalesPurchPerson.GET(BankAcc."Our Contact Code");
                            IF PrintForCheck THEN
                                CurrReport.SKIP;
                        END;
                END;

                CheckDateText := FORMAT("Posting Date", 0, 4);
                CheckDocNo := "Document No.";
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                ChecksPrinted := 0;

                SETRANGE("Account Type", GenJnlLine."Account Type"::"Fixed Asset");
                IF FIND('-') THEN
                    GenJnlLine.FIELDERROR("Account Type");
                SETRANGE("Account Type");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF BankAcc2."No." <> '' THEN BEGIN
                IF NOT BankAcc2.GET(BankAcc2."No.") THEN
                    BankAcc2."No." := '';
            END;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        UserSetup.GET(USERID);
        OneCheckPrVendor := FALSE;
    end;

    var
        Text001: Label 'Remittance Advice';
        CompanyInfo: Record "Company Information";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlLine3: Record "Gen. Journal Line";
        Cust: Record Customer;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAcc: Record "Bank Account";
        BankAcc2: Record "Bank Account";
        CheckLedgEntry: Record "Check Ledger Entry";
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        FormatAddr: Codeunit "Format Address";
        CheckManagement: Codeunit CheckManagement;
        CompanyAddr: array[8] of Text[50];
        CheckToAddr: array[8] of Text[50];
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        BalancingType: Option "G/L Account",Customer,Vendor,"Bank Account";
        BalancingNo: Code[20];
        CheckNoText: Text[30];
        CheckDateText: Text[30];
        CheckAmountText: Text[30];
        DescriptionLine: array[2] of Text[80];
        DocNo: Text[30];
        ExtDocNo: Text[35];
        VoidText: Text[30];
        LineAmount: Decimal;
        LineDiscount: Decimal;
        TotalLineAmount: Decimal;
        TotalLineDiscount: Decimal;
        RemainingAmount: Decimal;
        CurrentLineAmount: Decimal;
        FoundLast: Boolean;
        FirstPage: Boolean;
        OneCheckPrVendor: Boolean;
        FoundNegative: Boolean;
        ApplyMethod: Option Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        ChecksPrinted: Integer;
        HighestLineNo: Integer;
        TotalText: Text[10];
        DocDate: Date;
        i: Integer;
        CurrencyCode2: Code[10];
        NetAmount: Text[30];
        LineAmount2: Decimal;
        i2: Integer;
        Text019: Label 'Total';
        Text063: Label 'Net Amount %1';
        CheckNoTextCaptionLbl: Label 'Check No.';
        LineAmountCaptionLbl: Label 'Net Amount';
        LineDiscountCaptionLbl: Label 'Discount';
        AmountCaptionLbl: Label 'Amount';
        CurrencyCodeCaptionLbl: Label 'Currency Code';
        CheckDocNo: Text[30];
        NoOfLines: Integer;
        PrintedOnCaptionLbl: Label 'Printed on :';
        PrintedByCaptionLbl: Label 'Printed by : ';
        DateCaptionLbl: Label 'Date :';
        CashBookNoCaptionLbl: Label 'Cash Book Nos : ';
        BankAccountCaptionLbl: Label 'Bank Account :';
        SupplierInvoiceCaptionLbl: Label 'Your Reference';
        OurReferenceCaptionLbl: Label 'Details';
        DocDescription: Text[50];
        PrintForCheck: Boolean;
        FaxNoCaptionLbl: Label 'Fax:';
        PhoneCaptionLbl: Label 'Phone:';
        BRNCaptionLbl: Label 'Business Reg No.:';
        VATNoCaptionLbl: Label 'VAT No.:';
        PageCaptionLbl: Label 'Page :';

    local procedure CustUpdateAmounts(var CustLedgEntry2: Record 21; RemainingAmount2: Decimal)
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY(
              "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Customer);
            GenJnlLine3.SETRANGE("Account No.", CustLedgEntry2."Customer No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", CustLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", CustLedgEntry2."Document No.");
            IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            ELSE
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
        END;

        DocNo := CustLedgEntry2."Document No.";
        ExtDocNo := CustLedgEntry2."External Document No.";
        DocDate := CustLedgEntry2."Posting Date";
        CurrencyCode2 := CustLedgEntry2."Currency Code";
        DocDescription := CustLedgEntry2.Description;

        CustLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount :=
          -ABSMin(
            CustLedgEntry2."Remaining Amount" -
            CustLedgEntry2."Remaining Pmt. Disc. Possible" -
            CustLedgEntry2."Accepted Payment Tolerance",
            CustLedgEntry2."Amount to Apply");
        LineAmount2 :=
          ROUND(
            ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount),
            Currency."Amount Rounding Precision");

        IF ((CustLedgEntry2."Document Type" IN [CustLedgEntry2."Document Type"::Invoice,
                                                CustLedgEntry2."Document Type"::"Credit Memo"]) AND
            (CustLedgEntry2."Remaining Pmt. Disc. Possible" <> 0) AND
            (CustLedgEntry2."Posting Date" <= CustLedgEntry2."Pmt. Discount Date")) OR
           CustLedgEntry2."Accepted Pmt. Disc. Tolerance"
        THEN BEGIN
            LineDiscount := -CustLedgEntry2."Remaining Pmt. Disc. Possible";
            IF CustLedgEntry2."Accepted Payment Tolerance" <> 0 THEN
                LineDiscount := LineDiscount - CustLedgEntry2."Accepted Payment Tolerance";
        END ELSE BEGIN
            IF RemainingAmount2 >=
               ROUND(
                 -ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                   CustLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision")
            THEN
                LineAmount2 :=
                  ROUND(
                    -ExchangeAmt(CustLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                      CustLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision")
            ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  ROUND(
                    ExchangeAmt(CustLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                      LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    local procedure VendUpdateAmounts(var VendLedgEntry2: Record 25; RemainingAmount2: Decimal)
    begin
        IF (ApplyMethod = ApplyMethod::OneLineOneEntry) OR
           (ApplyMethod = ApplyMethod::MoreLinesOneEntry)
        THEN BEGIN
            GenJnlLine3.RESET;
            GenJnlLine3.SETCURRENTKEY(
              "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
            GenJnlLine3.SETRANGE("Account Type", GenJnlLine3."Account Type"::Vendor);
            GenJnlLine3.SETRANGE("Account No.", VendLedgEntry2."Vendor No.");
            GenJnlLine3.SETRANGE("Applies-to Doc. Type", VendLedgEntry2."Document Type");
            GenJnlLine3.SETRANGE("Applies-to Doc. No.", VendLedgEntry2."Document No.");
            IF ApplyMethod = ApplyMethod::OneLineOneEntry THEN
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine."Line No.")
            ELSE
                GenJnlLine3.SETFILTER("Line No.", '<>%1', GenJnlLine2."Line No.");
        END;

        DocNo := VendLedgEntry2."Document No.";
        ExtDocNo := VendLedgEntry2."External Document No.";
        DocDate := VendLedgEntry2."Posting Date";
        CurrencyCode2 := VendLedgEntry2."Currency Code";
        DocDescription := VendLedgEntry2.Description;
        VendLedgEntry2.CALCFIELDS("Remaining Amount");

        LineAmount :=
          -ABSMin(
            VendLedgEntry2."Remaining Amount" -
            VendLedgEntry2."Remaining Pmt. Disc. Possible" -
            VendLedgEntry2."Accepted Payment Tolerance",
            VendLedgEntry2."Amount to Apply");

        LineAmount2 :=
          ROUND(
            ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2, LineAmount),
            Currency."Amount Rounding Precision");

        IF ((VendLedgEntry2."Document Type" IN [VendLedgEntry2."Document Type"::Invoice,
                                                VendLedgEntry2."Document Type"::"Credit Memo"]) AND
            (VendLedgEntry2."Remaining Pmt. Disc. Possible" <> 0) AND
            (GenJnlLine."Posting Date" <= VendLedgEntry2."Pmt. Discount Date")) OR
           VendLedgEntry2."Accepted Pmt. Disc. Tolerance"
        THEN BEGIN
            LineDiscount := -VendLedgEntry2."Remaining Pmt. Disc. Possible";
            IF VendLedgEntry2."Accepted Payment Tolerance" <> 0 THEN
                LineDiscount := LineDiscount - VendLedgEntry2."Accepted Payment Tolerance";
        END ELSE BEGIN
            IF ABS(RemainingAmount2) >=
               ABS(ROUND(
                   ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                     VendLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision"))
            THEN BEGIN
                LineAmount2 :=
                  ROUND(
                    -ExchangeAmt(VendLedgEntry2."Posting Date", GenJnlLine."Currency Code", CurrencyCode2,
                      VendLedgEntry2."Amount to Apply"), Currency."Amount Rounding Precision");
                LineAmount :=
                  ROUND(
                    ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                    LineAmount2), Currency."Amount Rounding Precision");
            END ELSE BEGIN
                LineAmount2 := RemainingAmount2;
                LineAmount :=
                  ROUND(
                    ExchangeAmt(VendLedgEntry2."Posting Date", CurrencyCode2, GenJnlLine."Currency Code",
                    LineAmount2), Currency."Amount Rounding Precision");
            END;
            LineDiscount := 0;
        END;
    end;

    local procedure ExchangeAmt(PostingDate: Date; CurrencyCode: Code[10]; CurrencyCode2: Code[10]; Amount: Decimal) Amount2: Decimal
    begin
        IF (CurrencyCode <> '') AND (CurrencyCode2 = '') THEN
            Amount2 :=
              CurrencyExchangeRate.ExchangeAmtLCYToFCY(
                PostingDate, CurrencyCode, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode))
        ELSE
            IF (CurrencyCode = '') AND (CurrencyCode2 <> '') THEN
                Amount2 :=
                  CurrencyExchangeRate.ExchangeAmtFCYToLCY(
                    PostingDate, CurrencyCode2, Amount, CurrencyExchangeRate.ExchangeRate(PostingDate, CurrencyCode2))
            ELSE
                IF (CurrencyCode <> '') AND (CurrencyCode2 <> '') AND (CurrencyCode <> CurrencyCode2) THEN
                    Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(PostingDate, CurrencyCode2, CurrencyCode, Amount)
                ELSE
                    Amount2 := Amount;
    end;

    local procedure ABSMin(Decimal1: Decimal; Decimal2: Decimal): Decimal
    begin
        IF ABS(Decimal1) < ABS(Decimal2) THEN
            EXIT(Decimal1);
        EXIT(Decimal2);
    end;

    [Scope('Internal')]
    procedure InputBankAccount()
    begin
        IF BankAcc2."No." <> '' THEN BEGIN
            BankAcc2.GET(BankAcc2."No.");
        END;
    end;

    [Scope('Internal')]
    procedure InitPrintForCheck()
    begin
        PrintForCheck := TRUE;
    end;
}

