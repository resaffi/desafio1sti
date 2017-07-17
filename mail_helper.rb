module MailHelper
  extend self

  DOMINIO = '@id.uff.br'.freeze

  def print_hash(hash)
    hash.each { |k, v| puts "#{k}- #{v}" }
  end

  def print_options(first_name, hash_options)
    puts "#{first_name.capitalize}, por favor escolha uma das opções abaixo para o seu UFFMail:"
    print_hash(hash_options)
  end

  def split_name(student)
    nomes = student.nome.split(' ')
    first_name = nomes[0].downcase
    second_name ||= nomes[1].downcase
    last_name = nomes[-1].downcase
    second_name == last_name ? [first_name, second_name] : [first_name, second_name, last_name]
  end

  def email_options(aluno)
    names_split_arr = split_name(aluno)
    hash = options_list(names_split_arr)
    print_options(names_split_arr[0], hash)
    hash
  end

  def options_list(options)
    first_option = "#{options.first}#{options.last}" + DOMINIO
    second_option = "#{options.first}#{options.last[0]}" + DOMINIO
    third_option = "#{options.first}_#{options.last}" + DOMINIO
    fourth_option = "#{options.first[0]}#{options.last}" + DOMINIO
    fifth_option = "#{options.first}#{options.last.slice(0..2)}" + DOMINIO
    { 1 => first_option, 2 => second_option, 3 => third_option, 4 => fourth_option, 5 => fifth_option }
  end
end
