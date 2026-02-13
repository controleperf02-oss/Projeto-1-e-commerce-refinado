-- MySQL Workbench Synchronization
-- Generated: 2026-02-12 18:30
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: win10

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `ecommerce_refinado`.`clientes` 
COMMENT = 'Tabela central de cadastro. Armazena o endereço comum e define se o cliente é Pessoa Física (PF) ou Jurídica (PJ) para direcionamento dos dados.' ;

ALTER TABLE `ecommerce_refinado`.`clientes_pf` 
COMMENT = 'Especialização para Pessoa Física. Guarda dados obrigatórios e exclusivos para indivíduos, como Nome e CPF.' ;

ALTER TABLE `ecommerce_refinado`.`clientes_pj` 
COMMENT = 'Especialização para Pessoa Jurídica. Guarda dados obrigatórios para empresas, como Razão Social e CNPJ.' ;

ALTER TABLE `ecommerce_refinado`.`entregas` 
COMMENT = 'Gerencia a logística pós-venda. Armazena o código de rastreio e o status do transporte (Postado, Entregue, etc.).' ;

ALTER TABLE `ecommerce_refinado`.`estoque` 
COMMENT = 'Cadastro de Centros de Distribuição e Lojas. Controla a quantidade total de produtos disponíveis em cada local físico.' ;

ALTER TABLE `ecommerce_refinado`.`fornecedores` 
COMMENT = 'Cadastro das empresas que fabricam ou fornecem os produtos para o estoque próprio do e-commerce.' ;

ALTER TABLE `ecommerce_refinado`.`itens_pedidos` 
COMMENT = 'Detalha os produtos contidos em cada pedido, controlando a quantidade de cada item e sua disponibilidade no momento da compra.' ;

ALTER TABLE `ecommerce_refinado`.`pagamentos` 
COMMENT = 'Registra as carteiras de pagamento dos clientes (Cartão, PIX, Boleto). Um cliente pode ter vários métodos salvos.' ;

ALTER TABLE `ecommerce_refinado`.`pedidos` 
COMMENT = 'Registra as vendas realizadas. Conecta o cliente ao pagamento escolhido e controla o status atual da compra e valor do frete.' ;

ALTER TABLE `ecommerce_refinado`.`produtos` 
COMMENT = 'Catálogo Geral. Contém informações básicas, categoria e avaliação de todos os itens vendidos no e-commerce.' ;

ALTER TABLE `ecommerce_refinado`.`produtos_estoque` 
COMMENT = 'Indica a posição exata (corredor/prateleira) de cada produto dentro de um estoque específico.' ;

ALTER TABLE `ecommerce_refinado`.`produtos_fornecedores` 
COMMENT = 'Liga os fornecedores aos produtos que eles entregam, facilitando o controle de remessas e reposição de estoque.' ;

ALTER TABLE `ecommerce_refinado`.`produtos_vendedores` 
COMMENT = 'Cruza vendedores e produtos. Indica quais itens os parceiros de marketplace estão oferecendo e em qual quantidade.' ;

ALTER TABLE `ecommerce_refinado`.`vendedores` 
COMMENT = 'Cadastro de parceiros terceiros (Marketplace) que utilizam nossa plataforma para vender seus próprios produtos.' ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
