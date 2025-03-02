# Sistema de Agendamento e Gerenciamento de Salas, Professores, Alunos e Eventos

## Descrição

Este projeto foi desenvolvido na disciplina de Banco de Dados I por José Carlos Souza e Ana Luisa Faria Gomes. O objetivo é implementar um sistema de agendamento e gerenciamento de salas, professores, alunos e eventos. Utilizando SQL, foram criadas diversas tabelas inter-relacionadas para garantir um controle eficiente e flexível dos dados. A estrutura do banco de dados abrange funcionalidades como agendamentos de salas, gestão de alunos, disciplinas, feedbacks e assistentes.

## Funcionalidades

- **Agendamento de Salas**: Cadastro e organização das salas de aula disponíveis para eventos e aulas.
- **Cadastro de Professores**: Gerenciamento de dados de professores e suas respectivas disciplinas.
- **Cadastro de Alunos**: Registro dos alunos e seus cursos/disciplinas.
- **Gestão de Eventos**: Agendamento e controle de eventos em salas específicas.
- **Feedbacks**: Coleta e armazenamento de feedbacks dos alunos sobre eventos/disciplinas.
- **Assistentes**: Atribuição de assistentes para eventos ou disciplinas.

## Estrutura do Banco de Dados

O banco de dados é composto pelas seguintes tabelas principais:

- **Salas**: Contém informações sobre as salas de aula disponíveis para agendamentos.
- **Agendamentos**: Relaciona as salas com os eventos e as datas/hora de utilização.
- **Alunos**: Armazena dados de alunos, como nome, matrícula, e disciplinas associadas.
- **Disciplinas**: Contém os cursos/disciplinas oferecidos, com a ligação aos professores.
- **Professores**: Informações sobre os professores e suas disciplinas.
- **Assistentes**: Dados sobre assistentes que podem ser alocados para eventos ou disciplinas.
- **Feedbacks**: Armazena a avaliação dos alunos em relação aos eventos e disciplinas.

## Relacionamentos

As tabelas estão interligadas por meio de chaves estrangeiras. Cada agendamento relaciona-se a uma sala e a um evento específico. Alunos podem estar vinculados a várias disciplinas, com as quais podem fornecer feedbacks. Assistentes são atribuídos a professores ou disciplinas.

## Requisitos

- **Banco de Dados**: MySQL ou MariaDB.
- **Ferramentas de Desenvolvimento**: Qualquer editor SQL para execução dos comandos e visualização do banco de dados.

## Como Executar

1. Clone este repositório para o seu ambiente local:
    ```bash
    git clone <URL_do_repositório>
    ```
2. Importe o script SQL para o seu servidor de banco de dados.
   - Certifique-se de ter um banco de dados criado para importar o conteúdo.
   - Execute os comandos SQL presentes no arquivo de script para criar as tabelas e os relacionamentos.

3. Utilize uma ferramenta de consulta SQL (como MySQL Workbench ou DBeaver) para interagir com o banco de dados e testar as funcionalidades do sistema.

## Exemplo de Estrutura das Tabelas

    ```sql
    CREATE TABLE Salas (
        id INT PRIMARY KEY,
        nome VARCHAR(100) NOT NULL,
        capacidade INT
    );

    CREATE TABLE Alunos (
        id INT PRIMARY KEY,
        nome VARCHAR(100) NOT NULL,
        matricula VARCHAR(15) NOT NULL
    );

    CREATE TABLE Professores (
        id INT PRIMARY KEY,
        nome VARCHAR(100) NOT NULL,
        email VARCHAR(100)
    );

    CREATE TABLE Disciplinas (
        id INT PRIMARY KEY,
        nome VARCHAR(100) NOT NULL,
        professor_id INT,
        FOREIGN KEY (professor_id) REFERENCES Professores(id)
    );
    ```

## Contribuições

Este projeto foi desenvolvido como parte de uma disciplina acadêmica por José Carlos Souza e Ana Luisa Faria Gomes. Contribuições futuras são bem-vindas para melhorar a funcionalidade ou adaptar o sistema a novas necessidades.

## Licença

Este projeto está sob a licença MIT.
