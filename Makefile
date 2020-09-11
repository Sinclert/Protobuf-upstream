SCRIPTS_FOLDER="scripts"


.PHONY: check
check:
	@echo "Checking shell scripts format"
	@shellcheck --shell=sh $(shell find $(SCRIPTS_FOLDER) -type f -name "*.sh")


.PHONY: setup-plugins
setup-plugins:
	@echo "Setting up language plugins"
	@pip install betterproto[compiler]==1.2.5
