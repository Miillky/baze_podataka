create user vedran identified by 'lozinka';

grant create table to vedran;
grant create session to vedran;
alter user vedran quota unlimited on users;

select username, accout status from dba_users where username = 'vedran';
