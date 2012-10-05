# Enables strong_parameters on everything by default
ActiveRecord::Base.class_eval { include ActiveModel::ForbiddenAttributesProtection }
