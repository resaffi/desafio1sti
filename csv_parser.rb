require 'csv'

class CSVParser
  FILE_PATH = 'alunos.csv'.freeze
  attr_accessor :csv_data, :parsed_csv
  def initialize(file = FILE_PATH)
    @csv_data = File.open(file, 'a+')
  rescue
    puts 'Erro ao abrir'
  end

  def parse_csv
    @parsed_csv = CSV.parse(@csv_data, headers: true)
  rescue CSV::MalformedCSVError
    puts 'Bad CSV'
  end

  def write_to_csv(aluno, uffmail)
    table = CSV.table(@csv_data)
    delete_from_table(table, aluno.nome, 0)
    register = find_register(@parsed_csv, 'nome', aluno.nome)
    register['uffmail'] = uffmail
    table << register
    write_to_file(FILE_PATH, table.to_csv)
  end

  def write_to_file(file_path, data)
    File.open(file_path, 'w') { |f| f.write(data) }
  end

  def delete_from_table(table, condition, index)
    table.delete_if { |row| row[index] == condition }
  end

  def find_register(data, column, value)
    data.find { |row| row[column] == value }
  end
end
