# Load decorator presenter classes
ActiveSupport::Dependencies.autoload_paths << "#{Rails.root}/app/decorators/**/*.rb"

Audited.audit_class = Audit
