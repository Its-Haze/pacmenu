PREFIX    ?= $(HOME)/.local
DESTDIR   ?=
BINDIR     = $(DESTDIR)$(PREFIX)/bin
LIBDIR     = $(DESTDIR)$(PREFIX)/lib/archer
SHAREDIR   = $(DESTDIR)$(PREFIX)/share
BASHCOMPDIR = $(SHAREDIR)/bash-completion/completions
ZSHCOMPDIR  = $(SHAREDIR)/zsh/site-functions
FISHCOMPDIR = $(SHAREDIR)/fish/vendor_completions.d
DESKTOPDIR  = $(SHAREDIR)/applications
LICENSEDIR  = $(SHAREDIR)/licenses/archer

SCRIPTS = bin/archer bin/archer-install bin/archer-remove bin/archer-search

.PHONY: install uninstall check dev clean help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

install: ## Install archer to PREFIX (default: ~/.local)
	install -Dm755 bin/archer         "$(BINDIR)/archer"
	install -Dm755 bin/archer-install "$(BINDIR)/archer-install"
	install -Dm755 bin/archer-remove  "$(BINDIR)/archer-remove"
	install -Dm755 bin/archer-search  "$(BINDIR)/archer-search"
	install -Dm644 lib/archer-core.sh "$(LIBDIR)/archer-core.sh"
	install -Dm644 completions/archer.bash "$(BASHCOMPDIR)/archer"
	install -Dm644 completions/_archer     "$(ZSHCOMPDIR)/_archer"
	install -Dm644 completions/archer.fish "$(FISHCOMPDIR)/archer.fish"
	install -Dm644 desktop/archer.desktop  "$(DESKTOPDIR)/archer.desktop"
	install -Dm644 LICENSE                 "$(LICENSEDIR)/LICENSE"
	@echo ""
	@echo "Installed archer to $(PREFIX)"
	@echo "Make sure $(PREFIX)/bin is in your PATH."

uninstall: ## Remove all installed archer files
	rm -f  "$(BINDIR)/archer"
	rm -f  "$(BINDIR)/archer-install"
	rm -f  "$(BINDIR)/archer-remove"
	rm -f  "$(BINDIR)/archer-search"
	rm -rf "$(LIBDIR)"
	rm -f  "$(BASHCOMPDIR)/archer"
	rm -f  "$(ZSHCOMPDIR)/_archer"
	rm -f  "$(FISHCOMPDIR)/archer.fish"
	rm -f  "$(DESKTOPDIR)/archer.desktop"
	rm -rf "$(LICENSEDIR)"
	@echo "Uninstalled archer from $(PREFIX)"

check: ## Run shellcheck and syntax validation
	@echo "Running shellcheck..."
	@shellcheck $(SCRIPTS) lib/archer-core.sh install.sh
	@echo ""
	@echo "Running bash -n syntax check..."
	@for f in $(SCRIPTS) lib/archer-core.sh install.sh; do \
		echo "  $$f"; \
		bash -n "$$f"; \
	done
	@echo ""
	@echo "All checks passed."

dev: ## Create symlinks for live development
	@mkdir -p "$(PREFIX)/bin" "$(PREFIX)/lib/archer"
	ln -sf "$(CURDIR)/bin/archer"         "$(PREFIX)/bin/archer"
	ln -sf "$(CURDIR)/bin/archer-install" "$(PREFIX)/bin/archer-install"
	ln -sf "$(CURDIR)/bin/archer-remove"  "$(PREFIX)/bin/archer-remove"
	ln -sf "$(CURDIR)/bin/archer-search"  "$(PREFIX)/bin/archer-search"
	ln -sf "$(CURDIR)/lib/archer-core.sh" "$(PREFIX)/lib/archer/archer-core.sh"
	@echo "Dev symlinks created. Changes in repo are live."

clean: ## Remove archer cache
	rm -rf "$${XDG_CACHE_HOME:-$$HOME/.cache}/archer"
	@echo "Cache cleaned."
