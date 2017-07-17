require_relative 'spec_helper'

FactoryGirl.define do
    factory :aluno do
        nome 'Aluno Teste'
        matricula '1'
        telefone  '999-999'
        email 'teste@gmal.com'
        uffmail 'teste@id.uff.br'
        status true
    end
end

describe Init do
    let(:init) { Init.new }
    let(:aluno) { build(:aluno) }

    describe '.greeting' do
        it 'Imprime uma mensagem requisitando a matricula ao usuario' do
            expect { init.greeting }.to output("Digite sua matricula:\n").to_stdout
        end
    end

    describe 'Recebe uma matricula do usuario' do
        it 'recebe uma matricula invalida do usuario' do
            aluno = build(:aluno, matricula: nil)
            init.matricula = aluno.matricula
            expect(init.query_result).to be_nil
            expect { init.answer }.to output("Matricula não encontrada\n").to_stdout
        end
        it 'recebe uma matricula valida do usuario' do
            init.matricula = aluno.matricula
            expect(init.query_result).to be_truthy
        end
    end

    describe 'Usuario escolhe um uffmail' do
        it 'escolha valida de uffmail' do
            init.query_result = aluno
            options = init.options_email(aluno)
            choice = 2
            uffmail = init.get_uffmail_choices(options, choice)
            expect(uffmail).to be_truthy
        end

        it 'escolha invalida de uffmail' do
            init.query_result = aluno
            options = init.options_email(aluno)
            choice = 6
            uffmail = init.get_uffmail_choices(options, choice)
            expect(uffmail).to be_nil
        end
    end
    describe 'Status do aluno ' do
        it 'Aluno é inativo' do
            aluno = build(:aluno, status: false)
            init.query_result = aluno
            expect { init.student_found }.to output("Aluno inativo\n").to_stdout
        end
    end

    describe '.print_email_success' do
        it 'imprime pra STDOUT uma mensagem de sucesso' do
            init.query_result = aluno
            options = init.options_email(aluno)
            choice = 2
            uffmail = init.get_uffmail_choices(options, choice)
            expect{init.print_email_success(uffmail)}.to output("A criação de seu e-mail (alunot@id.uff.br) será feita nos próximos minutos.\n            Um SMS foi enviado para 999-999 com a sua senha de acesso.\n").to_stdout
        end

    end

    describe '.get_uffmail_input' do
        it 'recebe a escolha do email' do
            allow(STDIN).to receive(:gets) { '4' }
            expect(init.get_uffmail_input).to eq(4)
        end
    end
    describe '.get_uffmail_input' do
        it 'recebe a escolha do email' do
            allow(STDIN).to receive(:gets) { '10101' }
            expect(init.get_matricula_from_user).to eq('10101')
        end
    end
    describe '.handle_user_input' do
        it 'inicia um process valido de escolha de uffmail' do
            allow(STDIN).to receive(:gets) { '2' }
            init.query_result = aluno
            options = init.options_email(aluno)
            expect{init.handle_user_input(options)}.to output("A criação de seu e-mail (alunot@id.uff.br) será feita nos próximos minutos.\n            Um SMS foi enviado para 999-999 com a sua senha de acesso.\n").to_stdout
        end
    end
    it 'inicia um processo com uma escolha invalida' do
            allow(STDIN).to receive(:gets) { '6' }
            init.query_result = aluno
            options = init.options_email(aluno)
            expect{init.handle_user_input(options,true)}.to output("Opçao invalida\n").to_stdout
    end

    describe '.start_process' do
        it 'começa o processo de um aluno' do
            allow(STDIN).to receive(:gets) { '2' }
            init.query_result = aluno
            expect{init.start_process(aluno)}.to output.to_stdout
        end

    describe '.student_found' do
        it 'verifica se esta ativo e inicia o processo' do
            allow(STDIN).to receive(:gets) { '2' }
            init.query_result = aluno
            expect { init.student_found }.to output.to_stdout
        end
    end
    end
end
