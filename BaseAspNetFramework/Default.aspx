<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BaseAspNetFramework._Default" %>


<asp:Content ID="pageStyles" ContentPlaceHolderID="mainSiteStyles" runat="Server">
    <style type="text/css">
        .fa:hover {
            cursor: pointer;
        }

        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
    </style>
</asp:Content>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="Scripts/jquery-3.4.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        listaProdutos = [];

        function getProducts() {
            $.getJSON("api/produto",
                function (data) {
                    listaProdutos = data;

                    ////limpa tabela de produtos
                    $('#products').empty();

                    // pra cada item da lista do data
                    $.each(data, function (key, val) {

                        //cria botoes delete e edit
                        var buttonDelete = `<td><i class='fa fa-trash' style='color:red' onclick='deleteProduct(${val.Codigo})'></i></td>`;
                        var buttonEdit = `<td><i class='fa fa-pencil' style='color:blue' onclick='editProduct(${val.Codigo})'></i></td>`;

                        var row = '<td>'+val.Codigo+'</td><td>' + val.Nome + '</td><td>' + val.Valor + '</td>';
                        row += buttonEdit;
                        row += buttonDelete;
                        $('<tr/>', { html: row })
                            .appendTo($('#products'));
                    });
                });
        }

        $(document).ready(getProducts);

        function addProduct() {
            var nome = $('#txtNome').val();
            var codigo = $('#txtCodigo').val();
            var valor = $('#txtValor').val();
            var situacao = $('#situacaoAtivo').prop('checked');
            if (situacao == true) {
                situacao = 'A';
            } else {
                situacao = 'I';
            }

            if (!codigo) {
                codigo = 0;
            }


            var obj = {
                Codigo: codigo,
                Nome: nome,
                Valor: valor,
                Situacao: situacao
            }

            console.log(JSON.stringify(obj));

            $.ajax({
                contentType: 'application/json',
                data: JSON.stringify(obj),
                dataType: 'json',
                success: function (data) {
                    limpar();
                    getProducts();
                    Swal.fire({
                        title: 'Sucesso!',
                        text: 'Produto salvo com sucesso',
                        icon: 'success',
                        timer: 4000,
                        confirmButtonText: 'Ok'
                    });
                },
                processData: false,
                type: 'POST',
                url: "api/produto"
            });

        }

        function deleteProduct(codProduto) {
            Swal.fire({
                title: 'Deletar Produto?',
                text: "Não será possível reverter isso!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sim, deletar!',
                cancelButtonText: 'Cancelar!',
            }).then((result) => {
                if (result.isConfirmed) {
                    var obj = JSON.stringify(codProduto);
                    $.ajax(
                        {
                            type: "DELETE",
                            url: "api/produto/"+codProduto,
                            contentType: "application/json",
                            data: obj,
                            dataType:"json",
                            success: function (result) {
                                $('#txtNome').val("");
                                $('#txtValor').empty("");
                                $('#txtCodigo').empty("");

                                Swal.fire({
                                    title: 'Sucesso!',
                                    text: 'Produto removido com sucesso',
                                    icon: 'success',
                                    timer: 4000,
                                    confirmButtonText: 'Ok'
                                });
                                getProducts();
                                limpar();
                            }
                        });
                }
            })
        }

        function editProduct(codigoProduto) {
            console.log(listaProdutos);
            var produto = listaProdutos.find(pro => pro.Codigo == codigoProduto);
            $('#txtNome').val(produto.Nome);
            $('#txtValor').val(parseFloat(produto.Valor));
            $('#txtCodigo').val(produto.Codigo);
            if (produto.Situacao == 'A') {
                $('#situacaoAtivo').prop('checked', true);
                $('#situacaoInativo').prop('checked', false);
            } else {
                $('#situacaoAtivo').prop('checked', false);
                $('#situacaoInativo').prop('checked', true);
            }

        }

        function limpar() {
            $('#txtCodigo').val("");
            $('#txtNome').val("");
            $('#txtValor').val("");
        }



    </script>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>Produtos</h2>
    <div>
        <label for="txtCodigo">Código:</label>
        <input type="number" style="width: 15%" readonly="true" id="txtCodigo" name="txtCodigo">
        &nbsp
        <label for="txtNome">Nome:</label>
        <input type="text" id="txtNome" name="txtNome">
        &nbsp
        <label for="txtValor">valor:</label>
        <input type="number" id="txtValor" name="txtValor">
        <input type="radio" id="situacaoAtivo" name="situacaoAtivo" value="A">
        <label for="situacaoAtivo">Ativo</label>
        <input type="radio" id="situacaoInativo" name="situacaoInativo" value="I">
        <label for="situacaoInativo">Inativo</label>
        &nbsp&nbsp
        <i class='fa fa-solid fa-save fa-2x' style='color: green;' onclick='addProduct()'></i>
        &nbsp&nbsp
        <i class='fa fa-solid fa-refresh fa-2x' style='color: deepskyblue;' onclick='limpar()'></i>
        <br>
        <br>
    </div>


    <table>
        <thead>
            <tr>
                <th>Código&nbsp;&nbsp;</th>
                <th>Name&nbsp;&nbsp;</th>
                <th>Price&nbsp;&nbsp;</th>
                <th>Editar&nbsp;&nbsp;</th>
                <th>Excluir</th>
            </tr>
        </thead>
        <tbody id="products">
        </tbody>
    </table>
</asp:Content>
