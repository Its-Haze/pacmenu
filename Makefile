PREFIX    ?= $(HOME)/.local
DESTDIR   ?=
BINDIR     = $(DESTDIR)$(PREFIX)/bin
LIBDIR     = $(DESTDIR)$(PREFIX)/lib/pacmenu
SHAREDIR   = $(DESTDIR)$(PREFIX)/share
BASHCOMPDIR = $(SHAREDIR)/bash-completion/completions
ZSHCOMPDIR  = $(SHAREDIR)/zsh/site-functions
FISHCOMPDIR = $(SHAREDIR)/fish/vendor_completions.d
DESKTOPDIR  = $(SHAREDIR)/applications
LICENSEDIR  = $(SHAREDIR)/licenses/pacmenu

SCRIPTS = bin/pacmenu bin/pacmenu-install bin/pacmenu-remove bin/pacmenu-search

.PHONY: install uninstall check dev clean help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

install: ## Install pacmenu to PREFIX (default: ~/.local)
	install -Dm755 bin/pacmenu         "$(BINDIR)/pacmenu"
	install -Dm755 bin/pacmenu-install "$(BINDIR)/pacmenu-install"
	install -Dm755 bin/pacmenu-remove  "$(BINDIR)/pacmenu-remove"
	install -Dm755 bin/pacmenu-search  "$(BINDIR)/pacmenu-search"
	install -Dm644 lib/pacmenu-core.sh "$(LIBDIR)/pacmenu-core.sh"
	install -Dm644 completions/pacmenu.bash "$(BASHCOMPDIR)/pacmenu"
	install -Dm644 completions/_pacmenu     "$(ZSHCOMPDIR)/_pacmenu"
	install -Dm644 completions/pacmenu.fish "$(FISHCOMPDIR)/pacmenu.fish"
	install -Dm644 desktop/pacmenu.desktop  "$(DESKTOPDIR)/pacmenu.desktop"
	install -Dm644 LICENSE                  "$(LICENSEDIR)/LICENSE"
	@echo ""
	@echo "Installed pacmenu to $(PREFIX)"
	@echo "Make sure $(PREFIX)/bin is in your PATH."

uninstall: ## Remove all installed pacmenu files
	rm -f  "$(BINDIR)/pacmenu"
	rm -f  "$(BINDIR)/pacmenu-install"
	rm -f  "$(BINDIR)/pacmenu-remove"
	rm -f  "$(BINDIR)/pacmenu-search"
	rm -rf "$(LIBDIR)"
	rm -f  "$(BASHCOMPDIR)/pacmenu"
	rm -f  "$(ZSHCOMPDIR)/_pacmenu"
	rm -f  "$(FISHCOMPDIR)/pacmenu.fish"
	rm -f  "$(DESKTOPDIR)/pacmenu.desktop"
	rm -rf "$(LICENSEDIR)"
	@echo "Uninstalled pacmenu from $(PREFIX)"

check: ## Run shellcheck and syntax validation
	@echo "Running shellcheck..."
	@shellcheck $(SCRIPTS) lib/pacmenu-core.sh install.sh
	@echo ""
	@echo "Running bash -n syntax check..."
	@for f in $(SCRIPTS) lib/pacmenu-core.sh install.sh; do \
		echo "  $$f"; \
		bash -n "$$f"; \
	done
	@echo ""
	@echo "All checks passed."

dev: ## Create symlinks for live development
	@mkdir -p "$(PREFIX)/bin" "$(PREFIX)/lib/pacmenu"
	ln -sf "$(CURDIR)/bin/pacmenu"         "$(PREFIX)/bin/pacmenu"
	ln -sf "$(CURDIR)/bin/pacmenu-install" "$(PREFIX)/bin/pacmenu-install"
	ln -sf "$(CURDIR)/bin/pacmenu-remove"  "$(PREFIX)/bin/pacmenu-remove"
	ln -sf "$(CURDIR)/bin/pacmenu-search"  "$(PREFIX)/bin/pacmenu-search"
	ln -sf "$(CURDIR)/lib/pacmenu-core.sh" "$(PREFIX)/lib/pacmenu/pacmenu-core.sh"
	@echo "Dev symlinks created. Changes in repo are live."

clean: ## Remove pacmenu cache
	rm -rf "$${XDG_CACHE_HOME:-$$HOME/.cache}/pacmenu"
	@echo "Cache cleaned."
