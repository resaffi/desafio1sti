require_relative 'spec_helper'
#require_relative '../mail_helper'
#require_relative '../aluno'

describe MailHelper do
  let (:aluno) { build(:aluno) }
  describe '.split_name' do
    it 'separa o nome em [nome,sobrenome]' do
      expect(MailHelper.split_name(aluno)).to eq(%w[aluno teste])
    end
    it 'separa o nome em [nome,segundo_nome,sobrenome]' do
      aluno.nome = 'Nome1 Nome2 Nome3'
      expect(MailHelper.split_name(aluno)).to eq(%w[nome1 nome2 nome3])
    end
  end

  describe '.email_options' do
    it 'retorna as opçoes de uffmail como um hash' do
      hash = { 1 => 'alunoteste@id.uff.br',
               2 => 'alunot@id.uff.br',
               3 => 'aluno_teste@id.uff.br',
               4 => 'ateste@id.uff.br',
               5 => 'alunotes@id.uff.br' }
      expect(MailHelper.email_options(aluno)).to eq(hash)
    end
  end

  describe '.print_options' do
    it 'imprime em STDOUT as opçoes de uffmail' do
      names_split_arr = MailHelper.split_name(aluno)
      hash = MailHelper.options_list(names_split_arr)
      expect { MailHelper.print_options(names_split_arr.first, hash) }.to output("Aluno, por favor escolha uma das opções abaixo para o seu UFFMail:\n1- alunoteste@id.uff.br\n2- alunot@id.uff.br\n3- aluno_teste@id.uff.br\n4- ateste@id.uff.br\n5- alunotes@id.uff.br\n").to_stdout
    end
  end


end
