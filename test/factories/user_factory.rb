Factory.define :user do |t|
  t.sequence(:first_name) { |n| "user#{n}" }
  t.sequence(:last_name) { |n| "last#{n}" }
  t.user_role_id UserRole.admin.id
  t.user_status_id UserStatus.active.id
  t.email {|a| "#{a.first_name}.#{a.last_name}@example.com".downcase }
  t.password 'pass123'
  t.password_confirmation 'pass123'
end