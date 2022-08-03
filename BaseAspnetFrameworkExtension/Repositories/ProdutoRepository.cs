using BaseAspnetFrameworkExtension.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;

namespace BaseAspnetFrameworkExtension.Repositories
{
    public static class ProdutoRepository
    {

        public async static Task<List<Produto>> GetProdutos(SqlConnection conexao,bool buscarInativos)
        {
            StringBuilder sql = new StringBuilder();
            sql.AppendLine("SELECT");
            sql.AppendLine("    PRO.codigo");
            sql.AppendLine("    ,PRO.nome");
            sql.AppendLine("    ,PRO.valor");
            sql.AppendLine("    ,PRO.situacao");
            sql.AppendLine("FROM MvtCadProduto PRO");
            if (!buscarInativos)
            {
            sql.AppendLine("WHERE PRO.situacao='A'");
            }
            return (await conexao.QueryAsync<Produto>(sql.ToString())).ToList();
        }

        public async static Task SaveProduto(SqlConnection conexao, Produto produto)
        {
            if (produto.Codigo > 0)
            {
                await UpdateProduto(conexao, produto);
            }
            else{
                await AddProduto(conexao, produto);
            }
        }

        private async static Task AddProduto(SqlConnection conexao,Produto produto)
        {
            StringBuilder sql = new StringBuilder();
            sql.AppendLine("INSERT INTO MvtCadProduto(nome,valor,situacao)");
            sql.AppendLine("VALUES (@nome,@valor,'A')");
            await conexao.ExecuteAsync(sql.ToString(),produto);
        }

        private async static Task UpdateProduto(SqlConnection conexao, Produto produto)
        {
            StringBuilder sql = new StringBuilder();
            sql.AppendLine("UPDATE MvtCadProduto");
            sql.AppendLine("SET nome=@Nome");
            sql.AppendLine(",valor=@Valor");
            sql.AppendLine(",situacao=@Situacao");
            sql.AppendLine("WHERE codigo=@codigo");
            await conexao.ExecuteAsync(sql.ToString(), produto);
        }

        public async static Task DeleteProduto(SqlConnection conexao, Produto produto)
        {
            StringBuilder sql = new StringBuilder();
            sql.AppendLine("DELETE FROM MvtCadProduto");
            sql.AppendLine("WHERE codigo=@codigo");
            await conexao.ExecuteAsync(sql.ToString(), produto);
        }
    }
}
