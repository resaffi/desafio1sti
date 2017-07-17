require_relative('aluno')

class SetAlunos
  attr_accessor :hash_alunos

  def initialize(data)
    @hash_alunos = return_hash(data)
  end

  # cria um hash do tipo { "matricula" => Aluno(obj) }
  def return_hash(alunos_data)
    alunos_data.reduce({}) { |hash, row| make_student_hash(hash, row) }
  end

  def make_student_hash(hash, row)
    row_hash = row.to_hash
    aluno = Aluno.new(row_hash)
    matricula = row_hash['matricula']
    hash.update(matricula => aluno)
  end

  def find_by_key(key)
    hash_alunos[key]
  end
end
