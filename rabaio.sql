-- Nome: Nathan Álex da Silva Oliveira
-- Turma: CC1MC
--

-- removendo usuario e base de dados caso ja exista.
DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS nathanalex;

-- Criando usuário
CREATE USER nathanalex 
CREATEDB
CREATEROLE
LOGIN
ENCRYPTED PASSWORD 'nathanalex';

-- Criando base de dados 
CREATE DATABASE uvv
OWNER = nathanalex
TEMPLATE = template0
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = true;

--Conectando e mudando de usuário
\c "host=localhost dbname=uvv user=nathanalex password='nathanalex'";

-- CRIANDO SCHEMA E VERIFICANDO SE JA EXISTE ALGUM
CREATE SCHEMA IF NOT EXISTS lojas AUTHORIZATION nathanalex;

--setando pacote para lojas.
SET search_path TO lojas;

-- Criando a tabela produtos
CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                image_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);

-- Inserindo comentário a tabela produtos
COMMENT ON TABLE produtos IS 'Tabela onde estão os produtos';

-- Comentando as colunas da tabela produtos
COMMENT ON COLUMN produtos.produto_id IS 'Chave primária da tabela produtos';
COMMENT ON COLUMN produtos.nome IS 'Campo que comporta os nomes dos produtos';
COMMENT ON COLUMN produtos.preco_unitario IS 'Campo que comporta o preço unitáro dos produtos';
COMMENT ON COLUMN produtos.detalhes IS 'Campo que comporta os detalhes dos produtos';
COMMENT ON COLUMN produtos.imagem IS 'Campo que comporta a imagem do produto';
COMMENT ON COLUMN produtos.image_mime_type IS 'Campo que comporta a mime type da imagem';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Campo que comporta o arquivo da imagem';
COMMENT ON COLUMN produtos.imagem_charset IS 'Campo que comporta a codificação de caracteres da imagem';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Campo que comporta a data da ultima atualização da imagem';

-- Criando a tabela lojas
CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longetude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

-- Inserindo comentário a tabela lojas
COMMENT ON TABLE lojas IS 'Tabela para a identificação das lojas';

-- Comentando as colunas da tabela lojas
COMMENT ON COLUMN lojas.loja_id IS 'Chave primaria da tabela Lojas';
COMMENT ON COLUMN lojas.nome IS 'Campo que contém o nome das lojas';
COMMENT ON COLUMN lojas.endereco_web IS 'Campo que contém o endeereço web das lojas';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Campo que comporta o endereço fisico da loja';
COMMENT ON COLUMN lojas.latitude IS 'Comporta a latitude local da loja fisica';
COMMENT ON COLUMN lojas.longetude IS 'Campo que comporta a longetude local da loja';
COMMENT ON COLUMN lojas.logo IS 'Campo que comporta a logo da loja';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Campo que comporta a mime type da logo';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Campo que comporta o arquivo de imagem da logo';
COMMENT ON COLUMN lojas.logo_charset IS 'Campo que comporta codificação de caractere da logo';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Campo que comporta a data de atualização da logo';

-- Criando a tabela estoque
CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

-- Inserindo comentário a tabela estoque
COMMENT ON TABLE estoques IS 'tabela que contem o estoque';

-- Comentando as colunas da tabela estoque
COMMENT ON COLUMN estoques.estoque_id IS 'Chave primaria da tabela estoques';
COMMENT ON COLUMN estoques.quantidade IS 'Campo que comporta a quantidade de produtos existentes';
COMMENT ON COLUMN estoques.loja_id IS 'Chave primaria da tabela Lojas';
COMMENT ON COLUMN estoques.produto_id IS 'Chave primária da tabela produtos';

-- Criando a tabela clientes
CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

-- Inserindo comentário a tabela clientes
COMMENT ON TABLE clientes IS 'tabela com dados dos clientes';

-- Comentando as colunas da tabela clientes
COMMENT ON COLUMN clientes.cliente_id IS 'chave primária da tabela clientes';
COMMENT ON COLUMN clientes.email IS 'Campo que comporta o email do cliente';
COMMENT ON COLUMN clientes.nome IS 'Campo que comporta o nome do cliente';
COMMENT ON COLUMN clientes.telefone1 IS 'Campo que comporta o um telefone do cliente';
COMMENT ON COLUMN clientes.telefone2 IS 'campo que comporta um telefone do cliente';
COMMENT ON COLUMN clientes.telefone3 IS 'campo que comporta um telefone do cliente';

-- Criando a tabela envios
CREATE TABLE envios (
                envios_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envios_id)
);

-- Inserindo comentário a tabela envios
COMMENT ON TABLE envios IS 'Tabela de envios';

-- Comentando as colunas da tabela envios
COMMENT ON COLUMN envios.envios_id IS 'Chave primaria da tabela envios';
COMMENT ON COLUMN envios.endereco_entrega IS 'Campo que comporta o endereço de entrega do cliente na tabela envios';
COMMENT ON COLUMN envios.status IS 'Campo que comporta o status do envio';
COMMENT ON COLUMN envios.cliente_id IS 'chave primária da tabela clientes';
COMMENT ON COLUMN envios.loja_id IS 'Chave primaria da tabela Lojas';

-- Criando a tabela pedidos
CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                status VARCHAR(15) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

-- Inserindo comentário a tabela pedidos
COMMENT ON TABLE pedidos IS 'Tabela com ira conter os pedidos';

-- Comentando as colunas da tabela envios
COMMENT ON COLUMN pedidos.pedido_id IS 'Chave primária da tabela pedidos';
COMMENT ON COLUMN pedidos.data_hora IS 'Data e hora que que foi feito o pedido';
COMMENT ON COLUMN pedidos.status IS 'status do pedido';
COMMENT ON COLUMN pedidos.cliente_id IS 'chave primária da tabela clientes';
COMMENT ON COLUMN pedidos.loja_id IS 'Chave primaria da tabela Lojas';

-- Criando a tabela pedidos_itens
CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (pedido_id, produto_id)
);

-- Inserindo comentário a tabela pedidos_itens
COMMENT ON TABLE pedidos_itens IS 'Tabela com os itens dos pedidos';

-- Comentando as colunas da tabela pedidos_itens
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Chave primaria da tabela pedidos_itens';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Chave primária da tabela produtos';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Campo que comporta o numero da linha';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Campo que comporta o preço unitário do item';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Campo que comporta a quantidade de cada item';

-- Inserindo chave estrangeira na tabela pedidos_itens, PK da tabela produtos
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Inserindo chave estrangeira na tabela estoques, PK da tabela produtos
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Inserindo chave estrangeira na tabela pedidos, PK da tabela lojas
ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Inserindo chave estrangeira na tabela estoques, PK da tabela lojas
ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Inserindo chave estrangeira na tabela envios, PK da tabela produtos
ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Inserindo chave estrangeira na tabela pedidos, PK da tabela clientes
ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Inserindo chave estrangeira na tabela envios, PK da tabela clientes
ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Inserindo chave estrangeira na tabela pedidos_itens, PK da tabela pedidos
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criando check para o email da tabela clientes ser válido.
ALTER TABLE clientes
ADD CONSTRAINT check_clientes_email 
CHECK (email like '%@%');

-- Criando check para o status do pedido na tabela pedidos ser válido
ALTER TABLE pedidos
ADD CONSTRAINT check_pedidos_status
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- CRIANDO CHECK PARA O STATUS DO ENVIO NA TABELA ENVIO SER VÁLIDA
ALTER TABLE envios
ADD CONSTRAINT check_envio_status
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- CRIANDO CHECK PARA O PREÇO UNITÁRIO PARA VERIFICAR SE O VALOR DA UNIDADE NÃO É NEGATIVO; 
ALTER TABLE pedidos_itens
ADD CONSTRAINT check_pedidos_itens_preco_unitario
CHECK (preco_unitario >= 0);

-- CRIANDO CHECK PARA VERIFICAR SE A QUANTIDADE NÃO É NEGATIVO
ALTER TABLE pedidos_itens
ADD CONSTRAINT check_pedidos_itens_quantidade
CHECK (quantidade >= 0);

-- CRIANDO CHECK DO PREÇO UNITÁRIO PARA VERIFICAR SE O VALOR DA UNIDADE NÃO É NEGATIVO; 
ALTER TABLE produtos
ADD CONSTRAINT check_produtos_preco_unitario
CHECK (preco_unitario >= 0);

-- CRIANDO CHECK PARA VERIFICAR SE O INSERT INSERIU UM ENDEREÇO EM PELO MENOS NO DADO ENDEREÇO_WEB OU ENDEREÇO FISICO
ALTER TABLE lojas
ADD CONSTRAINT check_lojas_endereco
CHECK ((endereco_web IS NOT NULL) OR (endereco_fisico IS NOT NULL));

-- CRIANDO CHECK PARA VERIFICAR SE A QUANTIDADE NÃO É NEGATIVO
ALTER TABLE estoques
ADD CONSTRAINT check_estoques_quantidade
CHECK (quantidade >= 0);


