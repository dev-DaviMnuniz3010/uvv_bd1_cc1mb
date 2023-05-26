






 
-- removi banco dados antigos e usario que pode ser igual o meu
DROP DATABASE uvv;
DROP USER IF EXISTS davi;


--Criei um usuario especifico para ser o “dono” do banco de dados 

CREATE USER davi WITH CREATEDB CREATEROLE PASSWORD 'senha123';

--criei o banco de dados ''uvv''
CREATE DATABASE uvv with
  OWNER  davi
  TEMPLATE  template0
  ENCODING  'UTF8'
  LC_COLLATE  'pt_BR.UTF-8'
  LC_CTYPE 'pt_BR.UTF-8'
 ALLOW_CONNECTIONS true ;
 

--conexao com esse usuario ao banco de dados

\c 'dbname=uvv user=davi password=senha123';

 --criei um esquema dando autorizacao para o meu usuario
 CREATE SCHEMA lojas AUTHORIZATION davi;



ALTER USER davi
SET SEARCH_PATH TO lojas, "$user", public;



CREATE TABLE clientes (
                cliente_id   NUMERIC(38)               NOT NULL,
                email        VARCHAR(255)              NOT NULL,
                nome         VARCHAR(255)              NOT NULL,
                telefone1    VARCHAR(20),
                telefone2    VARCHAR(20),
                telefone3    VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
                
                
                --comentarios 
);
COMMENT ON TABLE  clientes                          IS 'atributos de cada cliente';
COMMENT ON COLUMN clientes.cliente_id               IS 'id de cada cliente';
COMMENT ON COLUMN clientes.email                    IS 'email de cada cliente';
COMMENT ON COLUMN clientes.nome                     IS 'nome de cada cliente';
COMMENT ON COLUMN clientes.telefone1                IS 'telefone do cliente';
COMMENT ON COLUMN clientes.telefone2                IS 'segundo opção de telefone do cliente';
COMMENT ON COLUMN clientes.telefone3                IS 'terceira opção de telefone do cliente';

               --criar tabela

CREATE TABLE produtos (
                produto_id                        NUMERIC(38)     NOT NULL,
                nome                              VARCHAR(255)    NOT NULL,
                preco_unitario                    NUMERIC(10,2), 
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type                  VARCHAR(512),
                imagem_arquivo                    VARCHAR(512),
                imagem_charset                    VARCHAR(512),
                imagem_ultima_atualizacao         DATE,
                CONSTRAINT produtos_pk            PRIMARY KEY (produto_id)             
); 

               --comentarios

COMMENT ON TABLE  produtos                           IS 'Atributos dos produtos de cada loja';
COMMENT ON COLUMN produtos.produto_id                IS 'indentificacao de cada produto';
COMMENT ON COLUMN produtos.nome                      IS 'nome de cada produto';
COMMENT ON COLUMN produtos.preco_unitario            IS 'preco de cada produto';
COMMENT ON COLUMN produtos.detalhes                  IS 'detalhes de cada produto';
COMMENT ON COLUMN produtos.imagem                    IS 'foto de cada produto';
COMMENT ON COLUMN produtos.imagem_mime_type          IS 'Padrão de identificação de tipos de arquivo da foto dos produtos';
COMMENT ON COLUMN produtos.imagem_arquivo            IS 'arquivo da foto de cada produto';
COMMENT ON COLUMN produtos.imagem_charset            IS 'forma como os caracteres são representados e codificados em um sistema de computador de cada imagem do produto';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'ultima atualizacao de imagem';

              --criar tabela

CREATE TABLE lojas (
                loja_id                 NUMERIC                NOT NULL,
                nome                    VARCHAR(255)           NOT NULL,
                endereco_web            VARCHAR(100),
                endereco_fisico         VARCHAR(512),
                latitude                NUMERIC,
                longitude               NUMERIC,
                logo                    BYTEA,
                logo_mime_type          VARCHAR(512),
                logo_arquivo            VARCHAR(512),
                logo_charset            VARCHAR(512),
                logo_ultima_atualziacao DATE,
                CONSTRAINT lojas_pk     PRIMARY KEY (loja_id)
                
               --comentarios 
);
COMMENT ON TABLE  lojas                             IS 'Atributos de cada loja';
COMMENT ON COLUMN lojas.loja_id                     IS 'Id de cada loja';
COMMENT ON COLUMN lojas.nome                        IS 'nome de cada loja';
COMMENT ON COLUMN lojas.endereco_web                IS 'link na internet de cada loja';
COMMENT ON COLUMN lojas.endereco_fisico             IS 'endereco de cada loja';
COMMENT ON COLUMN lojas.latitude                    IS 'latitude de cade loja';
COMMENT ON COLUMN lojas.longitude                   IS 'longitude de cada tabela';
COMMENT ON COLUMN lojas.logo                        IS 'logo de cada loja';
COMMENT ON COLUMN lojas.logo_mime_type              IS 'Padrão de identificação de tipos de arquivo da logo';
COMMENT ON COLUMN lojas.logo_arquivo                IS 'arquivo da logo de cada loja';
COMMENT ON COLUMN lojas.logo_charset                IS 'forma como os caracteres são representados e codificados em um sistema de computador de cada logo';
COMMENT ON COLUMN lojas.logo_ultima_atualziacao     IS 'data da atualizacao da logo de cada loja';

             -- criar tabelas

CREATE TABLE pedidos (
                pedido_id               NUMERIC(38)              NOT NULL,
                data_hora               TIMESTAMP                NOT NULL,
                cliente_id              NUMERIC(38)              NOT NULL,
                status                  VARCHAR(15)              NOT NULL,
                loja_id                 NUMERIC(38)              NOT NULL,
                lojas_loja_id           NUMERIC                  NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);

            --comentarios


COMMENT ON TABLE  pedidos                           IS 'Atributos de cada pedido';
COMMENT ON COLUMN pedidos.pedido_id                 IS 'id de cada pedido';
COMMENT ON COLUMN pedidos.data_hora                 IS 'data e hora de cada pedido';
COMMENT ON COLUMN pedidos.cliente_id                IS 'id de cada cliente';
COMMENT ON COLUMN pedidos.status                    IS 'status de cada pedido';
COMMENT ON COLUMN pedidos.loja_id                   IS 'id de cada loja';
COMMENT ON COLUMN pedidos.lojas_loja_id             IS 'Id de cada loja';

           --criar tabelas

CREATE TABLE envios (
                envio_id             NUMERIC(38)                 NOT NULL,
                loja_id              NUMERIC(38)                 NOT NULL,
                cliente_id           NUMERIC(38)                 NOT NULL,
                endereco_entrega     VARCHAR(512)                NOT NULL,
                status               VARCHAR(15)                 NOT NULL, 
                lojas_loja_id        NUMERIC                     NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id) 
);

          --comentarios


COMMENT ON TABLE  envios                           IS 'atributos dos envios';
COMMENT ON COLUMN envios.envio_id                  IS 'id de cada envio';
COMMENT ON COLUMN envios.loja_id                   IS 'id de cada loja';
COMMENT ON COLUMN envios.cliente_id                IS 'id de cada cliente';
COMMENT ON COLUMN envios.endereco_entrega          IS 'endereco da entrega';
COMMENT ON COLUMN envios.status                    IS 'status de cada envio';
COMMENT ON COLUMN envios.lojas_loja_id             IS 'Id de cada loja';
 
           --criar tabelas


CREATE TABLE pedido_itens (
                pedido_id            NUMERIC(38)                 NOT NULL,
                produto_id           NUMERIC(38)                 NOT NULL,
                preco_unitario       NUMERIC(10,2)               NOT NULL,
                numero_da_linha      NUMERIC(38)                 NOT NULL,
                quantidade           NUMERIC(38)                 NOT NULL,
                envio_id             NUMERIC(38),
                CONSTRAINT pedido_itens_pk PRIMARY KEY (pedido_id, produto_id)
);

           --comentarios

COMMENT ON TABLE  pedido_itens                     IS 'atributos dos itens de cada pedido';
COMMENT ON COLUMN pedido_itens.pedido_id           IS 'id de cada pedido';
COMMENT ON COLUMN pedido_itens.produto_id          IS 'indentificacao de cada produto';
COMMENT ON COLUMN pedido_itens.preco_unitario      IS 'preco unitario de cada item dos pedidos';
COMMENT ON COLUMN pedido_itens.numero_da_linha     IS 'numero da linha do item de cada pedido';
COMMENT ON COLUMN pedido_itens.quantidade          IS 'quantidade de itens de cada pedido';
COMMENT ON COLUMN pedido_itens.envio_id            IS 'id de cada envio';


          --criar tabelas

CREATE TABLE estoques (
                estoque_id           NUMERIC(38)                 NOT NULL,
                loja_id              NUMERIC(38)                 NOT NULL,
                produto_id           NUMERIC(38)                 NOT NULL,
                quantidade           NUMERIC(38)                 NOT NULL, 
                lojas_loja_id        NUMERIC                     NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);

         --comentarios

COMMENT ON TABLE  estoques                        IS 'atributos de cada estoque';
COMMENT ON COLUMN estoques.estoque_id             IS 'id de cada estoque';
COMMENT ON COLUMN estoques.loja_id                IS 'id de cada loja';
COMMENT ON COLUMN estoques.produto_id             IS 'id de cada produto';
COMMENT ON COLUMN estoques.quantidade             IS 'quantidade de produtos em cada estoque';
COMMENT ON COLUMN estoques.lojas_loja_id          IS 'Id de cada loja';


ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido_itens ADD CONSTRAINT produtos_pedido_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (lojas_loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (lojas_loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (lojas_loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido_itens ADD CONSTRAINT pedidos_pedido_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedido_itens ADD CONSTRAINT envios_pedido_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Aqui estao as restricoes do status do pedido

ALTER TABLE pedidos  ADD CONSTRAINT status_pedido_restricao           CHECK          ( status IN ( 'cancelado', 'completo','aberto','pago','reembolsado','enviado'));

--Aqui esta restricoes do status do envio

ALTER TABLE envios ADD CONSTRAINT status_envios_restricao             CHECK          (status IN ('criado', 'enviado', 'transito', 'entregue'));

--Aqui estao a restricao dos estoques

ALTER TABLE estoques ADD CONSTRAINT quant_neg_estoques_restricao      CHECK          (quantidade >= 0); 

--Aqui esta a restricao dos pedidos

ALTER TABLE pedido_itens ADD CONSTRAINT quant_neg_pedidos_restricao   CHECK          (quantidade >= 0);
 
--Aqui esta a restricao do preco dos produtos

ALTER TABLE produtos ADD CONSTRAINT preco_neg_produto_restricao       CHECK          (preco_unitario >= 0);

--Aqui esta a restricao do preco do pedido

ALTER TABLE pedido_itens ADD CONSTRAINT preco_neg_pedido_restricao    CHECK          ( preco_unitario >=0);

--Aqui esta a restricao que faz com que pelo menos um dos enderecos nao seja nulo

ALTER TABLE lojas ADD CONSTRAINT endereco_fisico_web_restricao        CHECK          ( (endereco_fisico IS NOT NULL)  or (endereco_web IS NOT NULL ) );






























