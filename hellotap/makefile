current_dir = $(notdir $(shell pwd))
change_id = ${COMMIT}
art_user="${ARTUSR}"
art_password="${ARTPWD}"
art_server_string=${ARTIFACTORY}/artifactory/
git_user=${GITUSR}
git_password=${GITPWD}
version=${VERSION}
# discard the following variable after testing, and replace it with ${ARTIFACTORY} for changing uri of download.
# for testing artifactory is pointing to 127.0.0.1
art_destination_string=127.0.0.1

zip: install.sh
	@echo $(version) > testfile.txt
	zip $(current_dir).zip install.sh testfile.txt makefile

upload_zip:
	$(eval checksum =  $(shell echo `sha256sum $(current_dir).zip | cut -d " " -f 1`))
	@echo "Upload checksum: $(checksum)"
	curl -v --user $(art_user):$(art_password) --data-binary @$(current_dir).zip -X PUT "http://$(art_server_string)$(artfolder)/$(current_dir).zip"


generate_formula:
	$(eval checksum =  $(shell echo `sha256sum $(current_dir).zip | cut -d " " -f 1`))
	$(eval uri = http:\/\/$(art_destination_string)\/artifactory\/test\/$(current_dir).zip)
	@sed -e "s/SHASUM/$(checksum)/" -e "s/URI/$(uri)/" -e "s/VERSION/$(version)/" formula.rb > $(current_dir)-test.rb
	$(eval uri_release = http:\/\/$(art_destination_string)\/artifactory\/release\/$(current_dir).zip)
	@sed -e "s/SHASUM/$(checksum)/" -e "s/URI/$(uri_release)/" -e "s/VERSION/$(version)/" formula.rb > $(current_dir).rb


upload_formula:
	rm -rf /tmp/example-tap
	git clone https://github.com/c-n-c/homebrew-example-tap.git /tmp/example-tap
	cp $(current_dir).rb /tmp/example-tap/
	cd /tmp/example-tap; \
	git config --local user.name "gocd user"; \
	git config --local user.email "gocd_user@someorg.com"; \
	git add $(current_dir).rb; \
	git commit -m "formula added for $(current_dir) installer changeid: $(change_id)"; \
	git push https://$(git_user):$(git_password)@github.com/c-n-c/homebrew-example-tap.git --all

# CD helpers :
cleanup_mac_agent:
	bash -c "if [ -f /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/$(current_dir).rb ]; then \
                    rm -rf /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/$(current_dir).rb; \
                    fi; \
                    brew info $(current_dir); \
                    if [ `echo $?` ]; then \
                    brew uninstall $(current_dir); fi "

copy_test_forumula:
	cp "$(current_dir)-test.rb" \
	"/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/$(current_dir).rb"

install_tests_on_mac:
	brew install --build-from-source /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/hellotap.rb

run_tests_on_mac:
	brew test /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/hellotap.rb

# reusing the same makefile which is meant for ci-cd to execute inside formula installation script.
install:
	if [ -f /usr/bin/say ]; \
	then say "MAC SAYS! hello tap installation completed"; \
	fi





