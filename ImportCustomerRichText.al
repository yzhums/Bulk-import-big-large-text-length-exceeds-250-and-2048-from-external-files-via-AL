xmlport 50101 "Import Customer Rich Text"
{
    Caption = 'Import Customer Rich Text';
    Format = VariableText;
    Direction = Import;
    TextEncoding = UTF8;
    UseRequestPage = false;
    FileName = 'CustomerRichText.csv';
    TableSeparator = '<NewLine>';

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'RichText';

                textelement(CustomerNo)
                { }
                textelement(RichText)
                {
                    TextType = BigText;
                }

                trigger OnAfterInitRecord()
                begin
                    if IsFirstline then begin
                        IsFirstline := false;
                        currXMLport.Skip();
                    end;
                end;

                trigger OnBeforeInsertRecord()
                var
                    Cust: Record Customer;
                    InStream: InStream;
                    EntityText: Record "Entity Text";
                    OutStream: OutStream;
                begin
                    if Cust.Get(CustomerNo) then begin
                        Clear(Cust.RichText);
                        Cust.RichText.CreateOutStream(OutStream, TextEncoding::UTF8);
                        RichText.Write(OutStream);
                        Cust.Modify();
                        i += 1;
                    end;
                    currXMLport.Skip();
                end;
            }
        }
    }

    var
        IsFirstline: Boolean;
        i: Integer;
        Msg: Label 'Imported Rich text for %1 customer(s).';
        Test: BigText;

    trigger OnPreXmlPort()
    begin
        i := 0;
        IsFirstline := true;
    end;

    trigger OnPostXmlPort()
    begin
        Message(Msg, i);
    end;
}
