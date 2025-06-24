tableextension 50112 CustomerExt extends Customer
{
    fields
    {
        field(50100; RichText; Blob)
        {
            Caption = 'Rich Text';
            DataClassification = CustomerContent;
        }
    }
}
