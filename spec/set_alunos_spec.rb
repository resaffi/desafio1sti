require_relative 'spec_helper'

describe SetAlunos do
  context 'quando um objeto SetAlunos é instanciado' do
    it ' variavel de instancia @hash_alunos é valida' do
      csv_obj = CSVParser.new('teste.csv')
      parsed_csv = csv_obj.parse_csv
      set_alunos = SetAlunos.new(parsed_csv)
      expect(set_alunos.hash_alunos).to be_truthy
    end
  end
end
