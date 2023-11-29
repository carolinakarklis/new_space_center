## Descrição
O Centro de Comando Espacial funciona como uma API para o registro de viagens espaciais, veículos, etc.

### Dependências
* Ruby 3.1.2
* Rails 7

### Diagrama
<img width="1138" alt="Captura de Tela 2023-11-29 às 01 46 58" src="https://github.com/carolinakarklis/new_space_center/assets/151457822/0c74ec18-6f41-450c-89d7-0abb7385722c">

### Instruções para rodar o projeto

* `bundle install`
* `bundle exec rails db:create db:migrate db:seed`
* Para rodar os testes: `bundle exec rspec`

**Observação:** Você pode acessar a API de produção através da URL `https://new-space-center-5a79882744b3.herokuapp.com`, utilizando o Bearer Token `ec68339123cd4cc913ea19ec970c96d4`. Para mais informações da API, acesse a [documentação](https://github.com/carolinakarklis/new_space_center/wiki/Documenta%C3%A7%C3%A3o-da-API)

### Atenção especial

Nesse desafio, priorizei a qualidade e funcionalidade de todos endpoints e regras de negócio. Aqui está uma lista de coisas que eu faria caso continuasse o projeto:

* Adicionaria validações no nível do banco de dados e model, como presença dos campos.
* Utilizaria o serializer de Erro em todos os métodos dos controllers que fosse necessário.
* Implementaria o `Documentável`/`Visualizável` utilizando o active storage.
* Melhoraria a segurança do token enviado na gem [space_register](https://github.com/carolinakarklis/space_register), utilizando uma env var.
* Adicionaria mais cenários de testes com diferentes possibilidades de erro, e incluiria testes de integração na gem citada.
* Todas as regras do status da viagem estão funcionando igual os requisitos, é possível iniciar, abortar e falhar a viagem. Faltou agendar a viagem via Sidekiq, é algo que eu faria também com mais tempo.
