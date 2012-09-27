module StudentsHelper
  def options_for_graduation_year
    options = []
    current_year = Date.today.year
    end_year     = current_year + Student::GRADUATION_YEAR_OFFSET

    until current_year > end_year do
      options << [current_year, current_year]
      current_year += 1
    end

    options
  end
end
