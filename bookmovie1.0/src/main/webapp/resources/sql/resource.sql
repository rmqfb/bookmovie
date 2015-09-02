CREATE USER bookmovie IDENTIFIED BY bookmovie ACCOUNT UNLOCK;
GRANT CONNECT, RESOURCE TO bookmovie;
CONN bookmovie/bookmovie;
