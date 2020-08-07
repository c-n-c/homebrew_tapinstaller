# homebrew_tapinstaller

This repository contains different installer directories (like hellotap) which have : 
- formula.rb ~ formula template
- installation files 
- makefile rules to zip, upload zip to https server (like artifactory), 
  create formula, upload formula
- gocd automation code.

##### GOCD AUTOMATION

These installer source is zipped as per the makefile rules with help of GOCD, 
and published into Artifactory or other HTTPS server. The formula template 
is also parsed by GOCD pipeline and updated with version and SHA256 of the 
zipped installer. The compiled formula is uploaded into the Example Tap github repository.

