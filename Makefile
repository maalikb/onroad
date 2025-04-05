certs:
	chmod +x deploy.sh
	mkcert --cert-file ./caddy/cert.crt --key-file ./caddy/cert.key localhost analytics.localhost

makemigrations:
	docker-compose -f development.yml exec django python manage.py makemigrations

collectstatic:
	docker-compose -f development.yml exec django python manage.py collectstatic --noinput
	
migrate:
	docker-compose -f development.yml exec django python manage.py migrate

showmigrations:
	docker-compose -f development.yml exec django python manage.py showmigrations

hasura:
	hasura console --admin-secret onroad --console-port 9800 --endpoint https://localhost/hasura/ --project hasura

seed:
	hasura seeds apply --endpoint https://localhost/hasura/ --admin-secret onroad --project hasura

caddy-reload-dev:
	docker-compose -f development.yml exec caddy caddy reload --config /etc/caddy/Caddyfile

caddy-reload-prod:
	docker-compose exec caddy caddy reload --config /etc/caddy/Caddyfile
	