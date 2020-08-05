current_dir = $(notdir $(shell pwd))

art_user="gocd"
art_password="test1234"
art_server_string="localhost:8082/artifactory/generic-local"

git_user=${GITUSR}
git_password=${GITPWD}

zip: install.sh
	zip $(current_dir).zip install.sh testfile.txt makefile

upload_zip:
	curl -v --user $(art_user):$(art_password) --data-binary @$(current_dir).zip -X PUT "http://$(art_server_string)/$(current_dir).zip"


generate_formula:
	$(eval checksum =  $(shell echo `sha256sum $(current_dir).zip | cut -d " " -f 1`))
	$(eval uri = http:\/\/localhost:8082\/artifactory\/test\/$(current_dir).zip)
	@sed -e "s/SHASUM/$(checksum)/" -e "s/URI/$(uri)/" formula.rb > $(current_dir).rb


upload_formula:
	rm -rf /tmp/example-tap
	git clone https://github.com/c-n-c/homebrew-example-tap.git /tmp/example-tap
	cp $(current_dir).rb /tmp/example-tap/
	cd /tmp/example-tap; \
	git config --local user.name "gocd user"; \
	git config --local user.email "gocd_user@someorg.com"; \
	git add $(current_dir).rb; \
	git commit -m "formula added for $(current_dir) installer"; \
	git push https://$(git_user):$(git_password)@github.com/c-n-c/homebrew-example-tap.git --all

install:
	if [ -f /usr/bin/say ]; \
	then say "hellotap installation completed !"; \
	fi





