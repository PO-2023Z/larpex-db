docker build -t postgres-larpex .
docker run -p 5432:5432 --name postgres-larpex-container postgres-larpex
pause

