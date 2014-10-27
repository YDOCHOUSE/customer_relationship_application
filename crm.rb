require_relative './contact.rb'
require_relative './rolodex.rb'
require_relative './coloring.rb'


system "clear"
class CRM
  attr_reader :name

  def initialize(name)
    @name = name
    @rolodex = Rolodex.new
    @notice = ""
  end

  def print_main_menu
    puts "[1 ] " + " Add a contact".magenta
    puts "[2 ] " +" Modify a contact".magenta
    puts "[3 ] " +" Display all contacts".magenta
    puts "[4 ] " +" Display one contact".magenta
    puts "[5 ] " +" Display an attribute".magenta
    puts "[6 ] " +" Delete a contact".magenta
    puts "[7 ] " +" Exit".magenta
    puts "Enter a number:"
  end

  def main_menu
    puts "============================".bg_magenta
    puts "Welcome to: #{@name}".magenta
    puts "============================".bg_magenta
    while true
      print_main_menu
      input = gets.chomp.to_i
      return if input == 7
      choose_option(input)
    end
  end

  def choose_option(option)
    case option
    when 1 then add_contact
    when 2 then modify_contact
    when 3 then display_all_contacts
    when 4 then display_particular_contact
    when 5 then display_attribute_menu
    when 6 then delete_contact
    else
      puts "Invalid option. Try again!"
      return
    end
  end

  def search_input
    gets.chomp.to_s
  end

  def user_input
    gets.chomp.to_i
  end

  def add_contact
    print "First Name: "
    first_name = gets.chomp
    print "Last Name: "
    last_name = gets.chomp
    print "Email: "
    email = gets.chomp
    print "Note: "
    note = gets.chomp

    contact = Contact.new(first_name, last_name, email, note)
    @rolodex.add_contact(contact)
  end

  def display_all_contacts
      @rolodex.contacts.each do |contact|
      puts "#{contact.first_name} #{contact.last_name} <#{contact.email}>, #{contact.id}"
      end
  end

  def get_contact_id
    id_from_user = gets.chomp.to_i
  end

  def modify_contact
    puts "Which contact do you want to modify? (select by I.D.)"
    display_all_contacts
    #  @rolodex.contacts.each do |contact|
    #   puts "Name: #{contact.first_name}, #{contact.last_name}, I.d.- #{contact.id}"
    # end
    contact_to_modify_id = get_contact_id
    @rolodex.get_contact_by_id(contact_to_modify_id)
  first_name, last_name, email, notes = get_contact_from_user
    
  updated_contact = @rolodex.update_contact contact_to_modify_id, first_name, last_name, email, notes
  end

    def get_contact_from_user 

      print "First name: "
      first_name = gets.chomp.to_s

      print "Last name : "
      last_name = gets.chomp.to_s

      print "email     : "
      email = gets.chomp.to_s

      print "Notes     : "
      notes = gets.chomp.to_s
      return first_name, last_name, email, notes
    end

    def display_particular_contact
      puts "Enter the Id of the user you would like to display. (See display all if Id is unknown)"
      id_to_display =  get_contact_id
      contact = @rolodex.get_contact_by_id(id_to_display)
      puts contact.id, contact.first_name, contact.last_name, contact.email, contact.note
    end

      def delete_contact
        display_all_contacts
        print "Enter the ID of the contact to DELETE: "
        contact_to_delete = @rolodex.get_contact_by_id(user_input) 
        puts "Are you sure you want to delete this contact. (y/n) : "
        confirm = gets.chomp.to_s
        if confirm == "y"
        @rolodex.delete_contact(contact_to_delete)
        end
      end


      def display_attribute_menu
        puts "========================================".bg_magenta
        puts "Please select an attribute to search by.".bold
        puts "========================================".bg_magenta 
        puts "[1 ] " + " Search by First Name".magenta
        puts "[2 ] " +" Search by Last Name".magenta
        puts "[3 ] " +" Seach by Email".magenta
        puts "[4 ] " +" Search by Id".magenta
        puts "[5 ]" + " Exit to main menu".magenta
        puts "Enter a number".magenta.bg_red.bold
        input = user_input
        attribute_case(input)
      end
  

      def attribute_case(input)
        case input
         when 1 
          puts "Select by first name: "
          input = search_input
          @rolodex.contacts.each do |contact|
            if contact.first_name == input
            puts "#{contact.first_name}".magenta + " (#{contact.id} <#{contact.email}>)".gray
          end
      end
        when 2
          puts "Select by last name: "
          input = search_input
          @rolodex.contacts.each do |contact|
            if contact.last_name == input
            puts "#{contact.last_name}".magenta + " (#{contact.id} <#{contact.email}>)".gray
          end
      end
        when 3
          puts "Select by Email: "
          input = search_input
          @rolodex.contacts.each do |contact|
            if contact.email == input
            puts "#{contact.email}".magenta + " (#{contact.id} <#{contact.first_name}, #{contact.last_name}>)".gray
          end
      end
        when 4
          puts "Select by by ID: "
          input = search_input
          @rolodex.contacts.each do |contact|
            if contact.id == input
            puts "#{contact.id}".magenta + " (#{contact.first_name} <#{contact.email}>)".gray
          end
      end
        else
        puts "Command not recognized!".bg_red
        return 
    end 
  end

end


crm = CRM.new("Bitmaker Labs CRM".bold)
crm.main_menu
