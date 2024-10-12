# Class containing all the the required methods for school management
class School
  def initialize
    @students = []
    @teachers = []
    @classes = []
    @assigning_data = []

    # Pattern to match all Alphabets with spaces and also allowed designations
    @name_pattern = /^(Mr.|Mrs.|Ms.|Prof.|Dr.)?[A-Z a-z]+{2}$/

    # Letter 'S' then 3 positive digits
    @student_id_pattern = /^S[0-9]{3}$/

    # Letter 'T' then 3 positive digits
    @teacher_id_pattern = /^T[0-9]{3}$/

    # Any string with more than 3 characters
    @class_name_pattern = /.{3}+/

    # 4 Capital Letter the 3 digits
    @class_code_pattern = /^[A-Z]{4}[0-9]{3}$/
  end

  # @return [String] the message to be conveyed
  # @return [Array] the array containing student data
  # @note : @flag_std variable was raised to 1 when duplicate Student ID was found
  def add_students
    print 'Enter Student Name:  '
    name = gets.chomp.to_s
    if name.match?(@name_pattern)
      print 'Enter Student ID(Eg. S001):  '
      student_id = gets.chomp.to_s
      if student_id.match?(@student_id_pattern)
        @students.each_index do |i|
          if @students[i][:id] == student_id
            puts 'Student ID already exists'
            @flag_std = 1
            break
          else
            @flag_std = nil
          end
        end
        if @flag_std.nil?
          @students << { name: name, id: student_id }
          puts 'Student added succesfully.'
        end
      else
        puts 'Enter Valid Student ID, For eg. S001'
      end
    else
      puts 'Invalid Input, Name should be min 2 characters and only alphabets'
    end
  end

  # @return [String] the message to be conveyed to the user
  # @return [String] the list of student data
  def view_students
    if @students.empty?
      puts 'There are no students in the record'
    else
      @students.each.with_index do |students, i|
        puts "#{i + 1}. Name: #{students[:name]}, ID: #{students[:id]}"
      end
    end
  end

  # @return [String] the message to be conveyed to the user
  # @return [Array] the array containing teacher data
  # @note : @flag_teach variable was raised to 1 when duplicate Teacher ID was found
  def add_teachers
    print 'Enter Teacher Name:  '
    name = gets.chomp.to_s
    if name.match?(@name_pattern)
      print 'Enter Teacher ID(Eg. T001):  '
      teacher_id = gets.chomp.to_s
      if teacher_id.match?(@teacher_id_pattern)
        @teachers.each_index do |i|
          if @teachers[i][:id] == teacher_id
            puts 'Teacher ID already exists'
            @flag_teach = 1
            break
          else
            @flag_teach = nil
          end
        end
        if @flag_teach.nil?
          @teachers << { name: name, id: teacher_id }
          puts 'Teacher added succesfully.'
        end
      else
        puts 'Enter Valid Teacher ID, For eg. T001'
      end
    else
      puts 'Invalid Input, Name should be min 2 characters and only alphabets'
    end
  end

  # @return [String] the message to be conveyed to the user
  # @return [String] the list of teacher data
  def view_teachers
    if @teachers.empty?
      puts 'There are no teachers in the record'
    else
      @teachers.each.with_index do |teachers, i|
        puts "#{i + 1}. Name: #{teachers[:name]}, ID: #{teachers[:id]}"
      end
    end
  end

  # @return [String] the message to be conveyed to the user
  # @return [Array] the array containing class data
  # @note : @flag_class variable was raised to 1 when duplicate Class Code was found
  def add_class
    print 'Enter Class Name:  '
    class_name = gets.chomp.to_s
    if class_name.match?(@class_name_pattern)
      print 'Enter Class Code(Eg. MATH101):  '
      class_code = gets.chomp.to_s
      if class_code.match?(@class_code_pattern)
        @classes.each_index do |i|
          if @classes[i][:class_code] == class_code
            puts 'Class Code already exists.'
            @flag_class = 1
            break
          else
            @flag_class = nil
          end
        end
        if @flag_class.nil?
          @classes << { class_name: class_name, class_code: class_code }
          puts 'Class added succesfully.'
        end
      else
        puts 'Enter Valid Class Code, For eg. MATH101.'
      end
    else
      puts 'Enter Name in Valid format, Minimum 3 characters required.'
    end
  end

  # @return [String] the message to be conveyed to the user
  # @return [String] the list of class data
  def view_class
    if @classes.empty?
      puts 'There are no classes in the record'
    else
      @classes.each.with_index do |classes, i|
        puts "#{i + 1}. Name: #{classes[:class_name]}, Code: #{classes[:class_code]}"
      end
    end
  end

  # @return [String] the message to be conveyed to the user
  # @return [Object] the methods to raise flag values and assign flag values
  # @note : @flag1 and @flag2 were used to crosscheck presence data to assigned
  def assign_student
    print 'Enter Student ID(Eg. S001):  '
    assign_id = gets.chomp.to_s
    if assign_id.match?(@student_id_pattern)
      print 'Enter Class Code(Eg. HIST101):  '
      assign_code = gets.chomp.to_s
      if assign_code.match?(@class_code_pattern)
        checking_unique(assign_id, assign_code)
        assign_to_class(assign_id, assign_code)
      else
        puts 'Enter Valid Class Code, For eg. HIST101.'
      end
    else
      puts 'Enter Valid Student Id, For eg. S001.'
    end
  end

  # @param assign_id [String] the ID of student to be assigned
  # @param assign_code [String] the code of the Class to be assigned
  # @return [Integer] indicating wether entities to be assigned exists
  def checking_unique(assign_id, assign_code)
    @students.each_index do |i|
      if @students[i][:id] == assign_id
        @flag1 = 1
        break
      else
        @flag1 = nil
      end
    end
    @classes.each_index do |i|
      if @classes[i][:class_code] == assign_code
        @flag2 = 1
        break
      else
        @flag2 = nil
      end
    end
  end

  # @param assign_id [String] the ID of student to be assigned
  # @param assign_code [String] the code of the Class to be assigned
  # @return [Array] the array containing data related to assigning of class
  # @return [String] the message to be conveyed to the user
  # @note : You can't assign same class to same student more than once
  def assign_to_class(assign_id, assign_code)
    if @flag1 == 1
      if @flag2 == 1
        data = { id: assign_id, class_code: assign_code }
        if @assigning_data.include?(data)
          puts 'This Class is already assigned to the following student'
        else
          @assigning_data << data
          puts 'Student assigned to class successfully.'
        end
      else
        puts 'Class does not exist for the following code.'
      end
    else
      puts 'Student with following ID does not exist.'
    end
  end
end
