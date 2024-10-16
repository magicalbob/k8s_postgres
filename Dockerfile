FROM postgres:13.11

CMD ["sh", "-c", "chown -R 999:999 /var/lib/postgresql/data"]
