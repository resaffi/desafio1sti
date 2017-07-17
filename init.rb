require_relative 'set_alunos'
require_relative 'mail_helper' 
require_relative 'csv_parser'
class Init
  attr_accessor :hash_alunos, :matricula, :query_result, :csv_object

  def initialize
    @csv_object = CSVParser.new
    @hash_alunos = SetAlunos.new(csv_object.parse_csv)
  end

  def greeting
    puts 'Digite sua matricula:'
  end

  def get_matricula_from_user
    @matricula = STDIN.gets.chomp
  end

  def answer
    query_result ? student_found : failure
  end

  def query_result
    @query_result ||= hash_alunos.find_by_key(@matricula)
  end

  def failure
    puts 'Matricula não encontrada'
  end

  def student_found
    if query_result.ativo?
      start_process(@query_result)
    else
      puts 'Aluno inativo'
    end
  end

  def start_process(aluno)
    options = options_email(aluno)
    handle_user_input(options)
  end

  def options_email(aluno)
    MailHelper.email_options(aluno)
  end

  def handle_user_input(options, break_after_loop = false)
    loop do
      choice = get_uffmail_input
      uffmail = get_uffmail_choices(options, choice)
      if uffmail
        print_email_success(uffmail)
        break
      else
        puts 'Opçao invalida'
        break if break_after_loop
      end
    end
  end

  def print_email_success(uffmail)
    puts "A criação de seu e-mail (#{uffmail}) será feita nos próximos minutos.
            Um SMS foi enviado para #{@query_result.telefone} com a sua senha de acesso."
    @csv_object.write_to_csv(@query_result, uffmail)
  end

  def get_uffmail_input
    STDIN.gets.chomp.to_i
  end

  def get_uffmail_choices(options, choice)
    options[choice]
  end
end
