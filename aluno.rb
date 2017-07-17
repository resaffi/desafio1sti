class Aluno
  attr_accessor :nome, :matricula, :telefone, :email, :uffmail, :status

  def initialize(options = {})
    @nome = options['nome']
    @matricula = options['matricula']
    @telefone = options['telefone']
    @email = options['email']
    @uffmail = options['uffmail']
    @status = status_to_bool(options['status'])
  end

  def ativo?
    status
  end

  private

  def status_to_bool(status)
    status == 'Ativo' ? true : false
  end
end
