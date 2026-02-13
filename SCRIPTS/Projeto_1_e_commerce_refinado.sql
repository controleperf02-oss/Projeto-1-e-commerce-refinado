-- =========================================================
-- PROJETO 1 - E-COMMERCE REFINADO (PF/PJ, PAGAMENTOS, ENTREGAS)
-- =========================================================

DROP DATABASE IF EXISTS ecommerce_refinado;
CREATE DATABASE IF NOT EXISTS ecommerce_refinado;
USE ecommerce_refinado;

-- Estrutura de Clientes e Pagamentos (Refinado)

-- Cliente Base
CREATE TABLE clientes(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    endereco VARCHAR(255),
    tipo_cliente ENUM('PF', 'PJ') NOT NULL 
) AUTO_INCREMENT = 1;



-- Especialização PF
CREATE TABLE clientes_pf(
    id_pf INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT, 
    nome VARCHAR(45), 
    sobrenome VARCHAR(45), 
    cpf CHAR(11) NOT NULL, 
    CONSTRAINT unico_cpf UNIQUE (cpf),
    CONSTRAINT fk_pf_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON UPDATE CASCADE
) AUTO_INCREMENT = 1;



-- Especialização PJ
CREATE TABLE clientes_pj(
    id_pj INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    razao_social VARCHAR(255) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    CONSTRAINT unico_cnpj UNIQUE (cnpj),
    CONSTRAINT fk_pj_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON UPDATE CASCADE
) AUTO_INCREMENT = 1;



-- Pagamentos (Múltiplas formas por cliente)
CREATE TABLE pagamentos(
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    tipo_pagamento ENUM('Boleto', 'Cartão', 'Dois cartões', 'PIX'),
    limite_disponivel FLOAT,
    CONSTRAINT fk_pagamento_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
) AUTO_INCREMENT = 1;


-- Produtos e Logística

-- Produtos
CREATE TABLE produtos(
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(50) NOT NULL,
    classificacao_kids BOOL DEFAULT FALSE,
    categoria ENUM('Eletrônico','Vestimenta', 'Brinquedos', 'Alimentos','Móveis') NOT NULL,
    avaliacao FLOAT DEFAULT 0,
    dimensoes VARCHAR(10) 
) AUTO_INCREMENT = 1;



-- Pedidos (Conectado ao Pagamento)
CREATE TABLE pedidos(
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido_cliente INT,
    id_pedido_pagamento INT,
    status_pedido ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
    descricao VARCHAR(255),
    frete FLOAT DEFAULT 10,
    CONSTRAINT fk_pedidos_cliente FOREIGN KEY (id_pedido_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_pedidos_pagamento FOREIGN KEY (id_pedido_pagamento) REFERENCES pagamentos(id_pagamento)
) AUTO_INCREMENT = 1;



-- Entregas (O Refinamento novo!)
CREATE TABLE entregas(
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_entrega_pedido INT,
    status_entrega ENUM('Postado', 'Em trânsito', 'Entregue', 'Extraviado') DEFAULT 'Postado',
    codigo_rastreio VARCHAR(50) NOT NULL,
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (id_entrega_pedido) REFERENCES pedidos(id_pedido)
) AUTO_INCREMENT = 1;


-- Estoque, Fornecedores e Vendedores 

-- Estoque
CREATE TABLE estoque(
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    local_estoque VARCHAR(255),
    quantidade INT DEFAULT 0
) AUTO_INCREMENT = 1;


-- Fornecedor
CREATE TABLE fornecedores(
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY, 
    razao_social VARCHAR(255) NOT NULL,
    cnpj CHAR(14) NOT NULL,
    contato CHAR(11) NOT NULL,
    CONSTRAINT unico_fornecedor UNIQUE (cnpj)
) AUTO_INCREMENT = 1;


-- Vendedor (Terceiro)
CREATE TABLE vendedores(
    id_vendedor INT AUTO_INCREMENT PRIMARY KEY, 
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    cnpj CHAR(14),
    cpf CHAR(11),
    localizacao VARCHAR(255),
    contato CHAR(11) NOT NULL,
    CONSTRAINT unico_cnpj_vendedor UNIQUE (cnpj), 
    CONSTRAINT unico_cpf_vendedor UNIQUE (cpf)
) AUTO_INCREMENT = 1;



-- Tabelas de Ligação (Relacionamentos M:N)

-- Produtos em Vendedores
CREATE TABLE produtos_vendedores(
    id_vendedor INT,
    id_produto INT,
    quantidade INT DEFAULT 1,
    PRIMARY KEY (id_vendedor, id_produto),
    CONSTRAINT fk_prod_vendedor FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
    CONSTRAINT fk_prod_produto FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);


 
-- Produtos em Pedidos
CREATE TABLE itens_pedidos(
    id_ip_produto INT,
    id_ip_pedido INT,
    quantidade INT DEFAULT 1,
    status_item ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (id_ip_produto, id_ip_pedido),
    CONSTRAINT fk_item_produto FOREIGN KEY (id_ip_produto) REFERENCES produtos(id_produto),
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_ip_pedido) REFERENCES pedidos(id_pedido)
);



-- Localização do Produto no Estoque
CREATE TABLE produtos_estoque(
    id_pe_produto INT,
    id_pe_estoque INT,
    localizacao VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_pe_produto, id_pe_estoque),
    CONSTRAINT fk_estoque_produto FOREIGN KEY (id_pe_produto) REFERENCES produtos(id_produto),
    CONSTRAINT fk_estoque_local FOREIGN KEY (id_pe_estoque) REFERENCES estoque(id_estoque)
);



CREATE TABLE produtos_fornecedores (
    id_fornecedor INT,
    id_produto INT,
    quantidade_remessa INT DEFAULT 0,
    PRIMARY KEY (id_fornecedor, id_produto),
    CONSTRAINT fk_pf_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor),
    CONSTRAINT fk_pf_produto FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);


-- =================== Povoamento ==========================

-- 1. CLIENTES (Base)
INSERT INTO clientes (endereco, tipo_cliente) VALUES 
('Rua das Flores, 100, SP', 'PF'), ('Av. Paulista, 1500, SP', 'PJ'),
('Rua Chile, 25, RJ', 'PF'), ('Rua Amazonas, 300, MG', 'PJ'),
('Av. Central, 10, DF', 'PF'), ('Rua do Comércio, 55, SC', 'PJ'),
('Rua Alagoas, 99, BA', 'PF');

INSERT INTO clientes (endereco, tipo_cliente) VALUES 
('Rua dos Alfeneiros, 4, SP', 'PF'), 
('Av. das Nações, 101, RJ', 'PF'),    
('Rua da Pizza, 50, MG', 'PJ'),      
('Praça do Sorvete, 12, SC', 'PJ');  


-- Nota: IDs de clientes repetidos aqui simulam endereços familiares/compartilhados.
-- 2. CLIENTES_PF (Dados Obrigatórios)
INSERT INTO clientes_pf (id_cliente, nome, sobrenome, cpf) VALUES 
(1, 'Ricardo', 'Silva', '12345678901'), (3, 'Maria', 'Oliveira', '23456789012'),
(5, 'Carlos', 'Souza', '34567890123'), (7, 'Ana', 'Costa', '45678901234'),
(1, 'Pedro', 'Braga', '56789012345'),
(3, 'Juliana', 'Lins', '67890123456'), (5, 'Roberto', 'Faro', '78901234567');

INSERT INTO clientes_pf (id_cliente, nome, sobrenome, cpf) VALUES 
(8, 'João', 'Silva', '11100011122'), 
(9, 'Paulo', 'Santos', '22200022233');

-- 3. CLIENTES_PJ
INSERT INTO clientes_pj (id_cliente, razao_social, cnpj) VALUES 
(2, 'Tech Solutions LTDA', '12345678000190'), (4, 'Alimentos S.A.', '23456789000180'),
(6, 'Moda & Estilo Eireli', '34567890000170'), (2, 'Logística Express', '45678901000160'),
(4, 'Construtora Forte', '56789012000150'), (6, 'Padaria Central', '67890123000140'),
(2, 'Consultoria VIP', '78901234000130');

INSERT INTO clientes_pj (id_cliente, razao_social, cnpj) VALUES 
(10, 'Pizzaria Coma Bem', '10101010000199'), 
(11, 'Sorveteria Delicia Gelada', '20202020000188');


-- 4. PAGAMENTOS (Critério B: Vários por cliente)
INSERT INTO pagamentos (id_cliente, tipo_pagamento, limite_disponivel) VALUES 
(1, 'PIX', 5000), (1, 'Cartão', 2000), (2, 'Boleto', 10000), (3, 'Cartão', 1500),
(4, 'PIX', 8000), (5, 'Dois cartões', 3000), (6, 'Boleto', 500);

INSERT INTO pagamentos (id_cliente, tipo_pagamento, limite_disponivel) VALUES 
(8, 'Cartão', 1000), (9, 'PIX', 2000), (10, 'Boleto', 5000), (11, 'Cartão', 3000);


-- 5. PRODUTOS
INSERT INTO produtos (nome_produto, classificacao_kids, categoria, avaliacao, dimensoes) VALUES 
('Smartphone X', false, 'Eletrônico', 4.5, '15x7x1'), ('Camiseta Algodão', false, 'Vestimenta', 4.0, null),
('Boneca Articulada', true, 'Brinquedos', 4.8, '30x10x5'), ('Arroz 5kg', false, 'Alimentos', 4.2, null),
('Sofá 3 Lugares', false, 'Móveis', 3.9, '90x200x100'), ('Fone Bluetooth', false, 'Eletrônico', 4.7, '5x5x2'),
('Chocolate Barra', false, 'Alimentos', 4.9, null);

-- 6. FORNECEDORES
INSERT INTO fornecedores (razao_social, cnpj, contato) VALUES 
('Samsung Brasil', '11122233000100', '1199998888'), ('Hering S.A.', '22233344000111', '1188887777'),
('Mattel Brinquedos', '33344455000122', '1177776666'), ('Camil Alimentos', '44455566000133', '1166665555'),
('Tok&Stok', '55566677000144', '1155554444'), ('Sony Inc', '66677788000155', '1144443333'),
('Nestlé', '77788899000166', '1133332222');

-- Inserir a Samsung como Fornecedor (caso já não exista com este CNPJ)
INSERT INTO fornecedores (razao_social, cnpj, contato) 
VALUES ('Samsung Service', '11122233000100', '1199998888')
ON DUPLICATE KEY UPDATE razao_social='Samsung Service';


-- 7. ESTOQUE
INSERT INTO estoque (local_estoque, quantidade) VALUES 
('CD São Paulo', 1000), ('CD Rio de Janeiro', 500), ('Loja Campinas', 200),
('CD Curitiba', 800), ('Loja BH', 150), ('CD Recife', 400), ('Loja Porto Alegre', 100);

-- 8. VENDEDORES (Terceiros)
INSERT INTO vendedores (razao_social, nome_fantasia, cnpj, cpf, localizacao, contato) VALUES 
('João da Silva ME', 'João Eletrônicos', '99888777000100', null, 'SP', '11911112222'),
('Maria Moda', 'Boutique Maria', null, '99988877711', 'RJ', '21922223333'),
('Kids Store LTDA', 'Mundo Infantil', '88777666000100', null, 'MG', '31933334444'),
('Casa & Conforto', 'Decor Casa', '77666555000100', null, 'SC', '48944445555'),
('Gula Express', 'Doces & Cia', null, '88877766622', 'PR', '41955556666'),
('Tech Import', 'Gadgets Inc', '66555444000100', null, 'GO', '62966667777'),
('Móveis Rusticos', 'Madeira Viva', '55444333000100', null, 'ES', '27977778888');

-- Inserir a mesma Samsung como Vendedor (Marketplace)
INSERT INTO vendedores (razao_social, nome_fantasia, cnpj, cpf, localizacao, contato)
VALUES ('Samsung Service', 'Loja Oficial Samsung', '11122233000100', null, 'SP', '1199998888');


-- 9. PRODUTOS_VENDEDORES
INSERT INTO produtos_vendedores (id_vendedor, id_produto, quantidade) VALUES 
(1, 1, 50), (1, 6, 100), (2, 2, 200), (3, 3, 80), (4, 5, 10), (5, 7, 300), (6, 1, 20);

-- 10. PRODUTOS_ESTOQUE
INSERT INTO produtos_estoque (id_pe_produto, id_pe_estoque, localizacao) VALUES 
(1, 1, 'Corredor A'), (2, 1, 'Corredor B'), (3, 2, 'Setor Kids'), (4, 4, 'Prateleira 5'),
(5, 4, 'Área Grande'), (6, 1, 'Corredor A'), (7, 6, 'Gôndola 2');


-- 11. PEDIDOS
INSERT INTO pedidos (id_pedido_cliente, id_pedido_pagamento, descricao, frete) VALUES 
(1, 1, 'Pedido urgente via PIX', 15.0), (2, 3, 'Compra faturada PJ', 50.0),
(3, 4, 'Presente de aniversário', 10.0), (4, 5, 'Abastecimento estoque', 0.0),
(5, 6, 'Móveis novos', 120.0), (6, 7, 'Compra mensal', 25.0), (7, 4, 'Gadget novo', 12.0);

-- Pedidos do João (ID 8) - 3 pedidos
INSERT INTO pedidos (id_pedido_cliente, id_pedido_pagamento, descricao, frete) VALUES 
(8, 8, 'Compra 1 João', 10), (8, 8, 'Compra 2 João', 12), (8, 8, 'Compra 3 João', 15);

-- Pedidos do Paulo (ID 9) - 5 pedidos
INSERT INTO pedidos (id_pedido_cliente, id_pedido_pagamento, descricao, frete) VALUES 
(9, 9, 'Ped 1 Paulo', 5), (9, 9, 'Ped 2 Paulo', 5), (9, 9, 'Ped 3 Paulo', 5), (9, 9, 'Ped 4 Paulo', 5), (9, 9, 'Ped 5 Paulo', 5);

-- Pedidos da Pizzaria (ID 10) - 4 pedidos
INSERT INTO pedidos (id_pedido_cliente, id_pedido_pagamento, descricao, frete) VALUES 
(10, 10, 'Insumos A', 20), (10, 10, 'Insumos B', 20), (10, 10, 'Insumos C', 20), (10, 10, 'Insumos D', 20);

-- Pedidos da Sorveteria (ID 11) - 3 pedidos
INSERT INTO pedidos (id_pedido_cliente, id_pedido_pagamento, descricao, frete) VALUES 
(11, 11, 'Leite Condensado', 30), (11, 11, 'Frutas', 30), (11, 11, 'Embalagens', 30);



-- 12. ITENS_PEDIDOS
INSERT INTO itens_pedidos (id_ip_produto, id_ip_pedido, quantidade, status_item) VALUES 
(1, 1, 1, 'Disponível'), (6, 1, 1, 'Disponível'), (4, 2, 10, 'Disponível'),
(3, 3, 1, 'Disponível'), (5, 5, 1, 'Disponível'), (7, 6, 5, 'Disponível'), (1, 7, 1, 'Disponível');



-- 13. ENTREGAS
INSERT INTO entregas (id_entrega_pedido, status_entrega, codigo_rastreio) VALUES 
(1, 'Entregue', 'BR123456789SS'), (2, 'Em trânsito', 'BR987654321XX'),
(3, 'Postado', 'BR456123789YY'), (4, 'Entregue', 'BR000111222ZZ'),
(5, 'Em trânsito', 'BR333444555AA'), (6, 'Postado', 'BR666777888BB'),
(7, 'Extraviado', 'BR999000111CC');


-- 14. CONECTA fornecedores aos produtos
INSERT INTO produtos_fornecedores (id_fornecedor, id_produto, quantidade_remessa) VALUES 
(1, 1, 500), -- Samsung fornece Smartphone
(2, 2, 1000), -- Hering fornece Camiseta
(3, 3, 200), -- Mattel fornece Boneca
(4, 4, 1500), -- Camil fornece Arroz
(5, 5, 50),   -- Tok&Stok fornece Sofá
(6, 6, 300),  -- Sony fornece Fone
(7, 7, 2000); -- Nestlé fornece Chocolate



-- ============ Queries SQL com as cláusulas do Desafio ============

--  Relatório de Clientes PF e seus Gastos (Requisitos:  1, 2, 3 e 6) Recuperação Simples, Junção, Filtro e Atributo Derivado
-- Quem são nossos clientes físicos, quanto eles pagaram de frete total e qual seria o valor do frete com um acréscimo de 10% para seguro?
SELECT 
    CONCAT(pf.nome, ' ', pf.sobrenome) AS Nome_Completo,
    pf.cpf AS Documento,
    p.frete AS Frete_Original,
    ROUND(p.frete * 1.10, 2) AS Frete_Com_Seguro 
FROM clientes_pf pf
INNER JOIN pedidos p ON pf.id_cliente = p.id_pedido_cliente
WHERE p.status_pedido <> 'Cancelado' 
ORDER BY Frete_Com_Seguro DESC; 


-- Análise de Compras por Tipo de Cliente (Requisitos 4, 5 e 6) Junção, Agrupamento e Filtro de Grupo (HAVING)
-- Qual a média de frete paga por tipo de cliente (PF ou PJ), mas mostre apenas os tipos que gastaram mais de R$ 20,00 em média?
SELECT 
    c.tipo_cliente AS Categoria,
    COUNT(p.id_pedido) AS Total_Pedidos,
    ROUND(AVG(p.frete), 2) AS Media_Frete
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_pedido_cliente
GROUP BY c.tipo_cliente
HAVING Media_Frete > 20.00
ORDER BY Media_Frete DESC;


-- Rastreamento Logístico Detalhado (Requisitos 1, 2 e 6) Junção Múltipla (Complexa) e Filtros Específicos
-- Quais produtos estão em pedidos que foram 'Extraviados' ou estão 'Em trânsito'?
SELECT 
    prod.nome_produto,
    e.status_entrega,
    e.codigo_rastreio,
    ped.descricao AS Info_Pedido
FROM produtos prod
INNER JOIN itens_pedidos ip ON prod.id_produto = ip.id_ip_produto
INNER JOIN pedidos ped ON ip.id_ip_pedido = ped.id_pedido
INNER JOIN entregas e ON ped.id_pedido = e.id_entrega_pedido
WHERE e.status_entrega IN ('Extraviado', 'Em trânsito');


-- Gestão de Inventário e Fornecedores (Perspectiva Complexa) Junção entre 4 tabelas para visão 360º
-- Quais produtos estão no estoque de São Paulo e quem é o seu fornecedor original?
SELECT 
    pr.nome_produto,
    est.local_estoque,
    est.quantidade AS Qtd_Estoque,
    forn.razao_social AS Nome_Fornecedor
FROM produtos pr
INNER JOIN produtos_estoque pe ON pr.id_produto = pe.id_pe_produto
INNER JOIN estoque est ON pe.id_pe_estoque = est.id_estoque
INNER JOIN fornecedores forn ON forn.id_fornecedor = pr.id_produto
WHERE est.local_estoque LIKE '%São Paulo%'
ORDER BY pr.nome_produto ASC;


-- ============ Queries de Perspectiva Complexa (Requisitos 1 a 6 - Queries Adicionais) ============

-- (Usa: Join, Group By, Having e Atributo Derivado para status)
-- 1- Quais clientes (Nome/Razão Social) fizeram mais de 1 pedido?
SELECT 
    c.id_cliente,
    CASE 
        WHEN c.tipo_cliente = 'PF' THEN pf.nome 
        WHEN c.tipo_cliente = 'PJ' THEN pj.razao_social 
    END AS Identificacao_Cliente,
    COUNT(p.id_pedido) AS Total_Pedidos,
    IF(COUNT(p.id_pedido) > 5, 'Cliente VIP', 'Cliente Comum') AS Categoria_Fidelidade
FROM clientes c
LEFT JOIN clientes_pf pf ON c.id_cliente = pf.id_cliente
LEFT JOIN clientes_pj pj ON c.id_cliente = pj.id_cliente
INNER JOIN pedidos p ON c.id_cliente = p.id_pedido_cliente
GROUP BY 
    c.id_cliente, 
    pf.nome, 
    pj.razao_social, 
    c.tipo_cliente 
HAVING Total_Pedidos >= 1
ORDER BY Total_Pedidos DESC;


-- (Usa: Recuperação simples com filtro de categoria)
-- 2- Quais fornecedores atendem a categoria 'Eletrônico'?
SELECT 
    f.razao_social AS Fornecedor,
    p.nome_produto,
    p.categoria
FROM fornecedores f
INNER JOIN produtos p ON f.id_fornecedor = p.id_produto
WHERE p.categoria = 'Eletrônico'
ORDER BY f.razao_social;


-- (Usa: Join entre 3 tabelas, Atributo Derivado de Localização, Group By e Having)
-- 3- Quais estados estão sofrendo com extravios e qual a média de frete que estamos cobrando nessas regiões críticas?
SELECT 
    SUBSTRING(c.endereco, -2) AS Estado,
    COUNT(e.id_entrega) AS Total_Entregas,
    e.status_entrega AS Situacao,
    ROUND(AVG(p.frete), 2) AS Frete_Medio
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_pedido_cliente
INNER JOIN entregas e ON p.id_pedido = e.id_entrega_pedido
WHERE e.status_entrega IN ('Extraviado', 'Falha')
GROUP BY Estado, e.status_entrega
HAVING Total_Entregas >= 1
ORDER BY Total_Entregas DESC;


-- (Usa: Join, Group By, Order By e Atributo Derivado de Ticket Médio)
-- 4- Qual o valor médio (Ticket Médio) de venda para cada tipo de pagamento (PIX, Cartão, etc.) e qual gera o maior faturamento total?
SELECT 
    pag.tipo_pagamento AS Metodo,
    COUNT(ped.id_pedido) AS Qtd_Vendas,
    SUM(ped.frete) AS Faturamento_Frete_Total,
    ROUND(AVG(ped.frete), 2) AS Ticket_Medio_Frete
FROM pagamentos pag
INNER JOIN pedidos ped ON pag.id_pagamento = ped.id_pedido_pagamento
GROUP BY pag.tipo_pagamento
HAVING Qtd_Vendas > 0
ORDER BY Faturamento_Frete_Total DESC;



-- (Usa: INNER JOIN, GROUP BY, HAVING e Atributo Derivado)
-- 5- Quais vendedores (sellers) têm mais variedade de produtos cadastrados e qual a média de estoque que eles mantêm?
SELECT 
    v.nome_fantasia AS Loja,
    v.localizacao AS Estado,
    COUNT(pv.id_produto) AS Variedade_Produtos,
    ROUND(AVG(pv.quantidade), 0) AS Media_Estoque_Por_Item,
    CASE 
        WHEN COUNT(pv.id_produto) >= 3 THEN 'Parceiro Grande'
        WHEN COUNT(pv.id_produto) >= 2 THEN 'Parceiro Médio'
        ELSE 'Parceiro Iniciante'
    END AS Perfil_Vendedor
FROM vendedores v
INNER JOIN produtos_vendedores pv ON v.id_vendedor = pv.id_vendedor
GROUP BY v.id_vendedor, v.nome_fantasia, v.localizacao
HAVING Variedade_Produtos >= 1
ORDER BY Variedade_Produtos DESC;



-- (Usa: INNER JOIN entre 4 tabelas, Atributo Derivado (CASE WHEN), SELECT Statement e ORDER BY)
-- 6- Qual o risco de falta de produto por fornecedor e onde eles estão estocados?
SELECT 
    f.razao_social AS Fornecedor,
    p.nome_produto AS Produto,
    p.categoria AS Categoria,
    e.quantidade AS Qtd_em_Estoque,
    e.local_estoque AS Localizacao,
    CASE 
        WHEN e.quantidade < 100 THEN 'RISCO CRÍTICO: Estoque Baixo'
        WHEN e.quantidade BETWEEN 100 AND 500 THEN 'RISCO MÉDIO: Alerta de Compra'
        ELSE 'RISCO BAIXO: Estoque Seguro'
    END AS Status_Abastecimento
FROM fornecedores f
INNER JOIN produtos_fornecedores pf ON f.id_fornecedor = pf.id_fornecedor
INNER JOIN produtos p ON pf.id_produto = p.id_produto
INNER JOIN produtos_estoque pe ON p.id_produto = pe.id_pe_produto
INNER JOIN estoque e ON pe.id_pe_estoque = e.id_estoque
WHERE e.quantidade >= 0 
ORDER BY e.quantidade ASC;


-- ============ Queries Básicas Sugeridas Pelo Objetivo do Desafio ============

-- 1- Quantos pedidos foram feitos por cada cliente?
-- (Usa: inner join, left join, case when, count,group by e order by)
SELECT 
    c.id_cliente,
    CASE 
        WHEN c.tipo_cliente = 'PF' THEN pf.nome 
        WHEN c.tipo_cliente = 'PJ' THEN pj.razao_social 
    END AS Cliente,
    COUNT(p.id_pedido) AS Total_Pedidos,
    CASE 
        WHEN COUNT(p.id_pedido) >= 5 THEN 'Diamante'
        WHEN COUNT(p.id_pedido) >= 3 THEN 'Ouro'
        ELSE 'Prata'
    END AS Status_Fidelidade
FROM clientes AS c
INNER JOIN pedidos AS p ON c.id_cliente = p.id_pedido_cliente
LEFT JOIN clientes_pf AS pf ON c.id_cliente = pf.id_cliente
LEFT JOIN clientes_pj AS pj ON c.id_cliente = pj.id_cliente
GROUP BY 
    c.id_cliente, 
    pf.nome, 
    pj.razao_social, 
    c.tipo_cliente
ORDER BY Total_Pedidos DESC;


-- 2- Algum vendedor também é fornecedor?
-- (Usa: Join entre tabelas de papéis diferentes e Select Simples)
SELECT 
    v.razao_social AS Nome_Vendedor,
    v.cnpj AS Documento,
    'Sim, também é fornecedor' AS Status_Duplicidade
FROM vendedores v
INNER JOIN fornecedores f ON v.cnpj = f.cnpj;


-- 3- Relação de produtos, fornecedores e estoques
-- (Usa: Multi-Join, Atributo Derivado de Valor de Inventário e Order By)
SELECT 
    f.razao_social AS Fornecedor,
    p.nome_produto,
    e.local_estoque,
    e.quantidade AS Qtd,
    (e.quantidade * 100) AS Valor_Estimado_Estoque
FROM fornecedores f
INNER JOIN produtos p ON f.id_fornecedor = p.id_produto 
INNER JOIN produtos_estoque pe ON p.id_produto = pe.id_pe_produto
INNER JOIN estoque e ON pe.id_pe_estoque = e.id_estoque
WHERE e.quantidade > 0
ORDER BY f.razao_social, e.quantidade DESC;


-- 4- Relação de nomes dos fornecedores e nomes dos produtos
-- (Usa: INNER JOIN entre 3 tabelas, ORDER BY e Atributo Derivado para Categoria)
SELECT 
    f.razao_social AS Nome_Fornecedor,
    p.nome_produto AS Nome_Produto,
    p.categoria AS Categoria_Produto,
    CASE 
        WHEN p.avaliacao >= 4.5 THEN 'Produto Premium'
        WHEN p.avaliacao >= 4.0 THEN 'Produto Bem Avaliado'
        ELSE 'Produto Standard'
    END AS Classificacao_Mercado
FROM fornecedores f
INNER JOIN produtos p ON f.id_fornecedor = p.id_produto
ORDER BY f.razao_social ASC, p.nome_produto ASC;






