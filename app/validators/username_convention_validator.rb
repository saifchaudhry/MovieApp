class UsernameConventionValidator < ActiveModel::EachValidator
  def validate_each(record, field, value)
    unless value.blank?
      record.errors[field] << "is not alphanumeric (letters, numbers or underscore)" unless value =~ /^[[:alnum:]_]+$/
      record.errors[field] << "contains illegal characters" unless value.ascii_only?
    end
  end
end