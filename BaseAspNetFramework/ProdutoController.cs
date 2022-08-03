using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using BaseAspnetFrameworkExtension.Models;
using BaseAspnetFrameworkExtension.Repositories;

namespace BaseAspNetFramework
{
    public class ProdutoController : ApiController
    {
        [HttpGet]
        public async Task<IEnumerable<Produto>> Get()
        {
            using (SqlConnection conexao = new SqlConnection(CustomConnection.GetConnectionString()))
            {
                return await ProdutoRepository.GetProdutos(conexao, false);
            }
        }

        [HttpPost]
        public async Task Post([FromBody] Produto produto)
        {
            using (SqlConnection conexao = new SqlConnection(CustomConnection.GetConnectionString()))
            {
                await ProdutoRepository.SaveProduto(conexao, produto);
            }
        }

        [HttpDelete]
        [Route("produto/{id}")]
        public async Task Delete([FromUri] int id)
        {
            using (SqlConnection conexao = new SqlConnection(CustomConnection.GetConnectionString()))
            {
                await ProdutoRepository.DeleteProduto(conexao, new Produto(id, string.Empty, 0, string.Empty));
            }
        }
    }
}