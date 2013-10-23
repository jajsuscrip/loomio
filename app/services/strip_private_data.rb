class StripPrivateData

  def self.go
    unless Rails.env.production?
      puts "Wiping all private data."
      Group.unscoped.where('viewable_by != ?', 'everyone').destroy_all
      Group.unscoped.where('archived_at IS NOT NULL').destroy_all

      User.unscoped.each do |user|
        user.update_attributes(password: 'password')
      end
      puts "DONE"
    end
  end

end
