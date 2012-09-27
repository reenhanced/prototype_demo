module StudentsHelper
  def options_for_graduation_year
    options = []
    current_year = Date.today.year
    end_year     = current_year + Student::GRADUATION_YEAR_OFFSET

    options = (current_year .. end_year).map { |year| [year, year] }
  end
end
