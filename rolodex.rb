

class Rolodex
  attr_reader :contacts

  @@index = 1000

  def initialize
    @contacts = []
  end

  def add_contact(contact)
    contact.id = @@index
    @@index += 1
    @contacts << contact
  end
  
  # def modify_contact(contact_to_modify)
  #     contacts.each do |contact|
  #     if contact.id == contact_to_modify
  #     puts "#{contact.first_name} #{contact.last_name} <#{contact.email}>, #{contact.id}"
  #   end
  #   end
  # end

    def get_contact_by_id(id)
    retrieved_contact = nil
    @contacts.each do |contact|
      retrieved_contact = contact if contact.id == id
    end
    retrieved_contact
  end

  def update_contact id, first_name, last_name, email, notes
    
    contact = get_contact_by_id(id)
    
    if contact
      contact.first_name = first_name
      contact.last_name  = last_name
      contact.email      = email
    end

    contact
  end

  def delete_contact(contact_to_delete)
    @contacts.delete(contact_to_delete)
    puts "Deleted!".bg_red
  end

end
