
use Person
use 

/*
CREATE TABLE [dbo].[Passport]
(
	[passportLastName] NCHAR(20) NOT NULL, 
    [passportFirstName] NCHAR(20) NOT NULL, 
    [passportSeria] NCHAR(2) NOT NULL, 
    [passportNumber] NCHAR(7) NOT NULL 
)
*/

/*
insert into [dbo].[Passport] values('������','������','qq','4246734');
insert into [dbo].[Passport] values('����������','�������','ww','4637531');
insert into [dbo].[Passport] values('��������','���������','ee','3333333');
insert into [dbo].[Passport] values('���','�����','rr','4444444');
insert into [dbo].[Passport] values('�������','�������','tt','5555555');
insert into [dbo].[Passport] values('���','�����','yy','6666666');
insert into [dbo].[Passport] values('������','������','uu','7777777');
insert into [dbo].[Passport] values('������','�����','ii','8888888');
insert into [dbo].[Passport] values('����������','�������','oo','9999999');
insert into [dbo].[Passport] values('������','������','pp','1212121');
*/


CREATE VIEW [view]
AS
SELECT        
	PP1.passportFirstName, PP1.passportLastName, 
	PP1.passportNumber, PP1.passportSeria, 
	PP2.passportNumber AS pn, PP2.passportSeria AS ps
FROM            
	[dbo].[Passport] AS PP1 
INNER JOIN
	[dbo].[Passport] AS PP2 ON 
	PP1.passportFirstName = PP2.passportFirstName AND PP1.passportLastName = PP2.passportLastName
;


SELECT /*TOP 1000 */
	  [passportFirstName]
      ,[passportLastName]
      ,[passportNumber]
      ,[passportSeria]    
  FROM [dbo].[view] where ps='uu' and pn='7777777';