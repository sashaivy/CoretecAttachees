//Codeunit 50142 "Validate ID"
// {
//local procedure ValidateIdentification()
//var
// i: Integer;
//begin
// case "IdentificationType" of
//"IdentificationType"::"National ID":
//begin
// Length check
// if (StrLen("IdentificationNumber") <> 7) and
// (StrLen("IdentificationNumber") <> 8) then
// Error('A National ID must contain 7 or 8 digits.');

// Digits only
//  for i := 1 to StrLen("IdentificationNumber") do
//if not ("IdentificationNumber"[i] in ['0'..'9']) then
//     Error('A National ID can contain digits only.');
// end;

// "IdentificationType"::"Passport Number":
// begin
// Example validation
//if StrLen("IdentificationNumber") < 6 then
//   Error('Enter a valid passport number.');
//end;
//  end;
//end;
//}