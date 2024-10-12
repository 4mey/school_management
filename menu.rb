require_relative 'school'

# @param user [Object] the instance of the user
# @return [String] the message to the user
# @return [Object] the method of operation to be performed
def menu(user)
  loop do
    puts '********Welcome to School Management System**************'
    puts '1. Add Student'
    puts '2. View Students'
    puts '3. Add Teacher'
    puts '4. View Teachers'
    puts '5. Add Class'
    puts '6. View Classes'
    puts '7. Assign Student to Class'
    puts '8. Quit'
    puts '**********************************************************'
    print 'Enter your choice:  '
    choice = gets.chomp.to_i
    case choice
    when 1
      user.add_students
    when 2
      user.view_students
    when 3
      user.add_teachers
    when 4
      user.view_teachers
    when 5
      user.add_class
    when 6
      user.view_class
    when 7
      user.assign_student
    when 8
      puts 'Exiting...'
      exit
    else
      puts 'Enter Valid Operation'
    end
  end
end

user = School.new
menu(user)
