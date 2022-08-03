using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BaseAspnetFrameworkExtension.Models
{
    [JsonObject()]
    public class Produto
    {
        [JsonProperty()]
        public int Codigo { get; set; }
        [JsonProperty()]
        public string Nome { get; set; }
        [JsonProperty()]
        public string Situacao { get; set; }
        [JsonProperty()]
        public double Valor { get; set; }

        private Produto() { }

        [JsonConstructor()]
        public Produto(int codigo, string nome, double valor,string situacao)
        {
            Codigo = codigo;
            Nome = nome;
            Situacao = situacao;
            Valor = valor;
        }
    }
}
