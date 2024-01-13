<%-- 
    Document   : index
    Created on : 10 de jan de 2024, 17:50:40
    Author     : joaopedro
/*https://youtu.be/krfm6kcgvt0?t=4309*/
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Tarefas</title>
        <!-- Bootstrap via cdn -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

        <!<!-- Bootstrap icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        
        <style>
            .done{
                text-decoration: line-through;
            }
        </style>
        
    </head>
    <body class="container mt-2">
        <h1>Lista de Tarefas</h1>

        <button type="button" class="btn btn-primary mb-2" data-bs-toggle="modal" data-bs-target="#createModal">
            <i class="bi bi-plus-circle"></i> Adicionar Tarefa
        </button>

        <table class="table">
            <thead>
                <tr>
                    <th scope="col"> Tarefa </th>
                    <th></th>
                </tr>

            </thead>
            <tbody>
                <c:forEach items="${notDone}" var="t">
                    <!-- <tr  class="${t.done == true ? 'table-secondary' : ''}" > -->
                    <tr>
                        <!-- <td class="${t.done == true ? 'done' : ''}"></td> -->
                        <td> <c:out value="${t.title}" /></td>
                        <td>
                            <div class="row g-0">
                                <div class="col-2">
                                    <form action="/ListaDeTarefas/">
                                        <input type="hidden" name="id" value="${t.id}">
                                        <input type="hidden" name="action" value="done">
                                        <button type="submit" class="btn btn-info"><i class="bi bi-check-circle"></i> Concluir</button>
                                    </form>
                                </div>                                
                                <div class="col-2">
                                    <button class="btn btn-primary" onclick="onUpdate(${t.id}, '${t.title}')" data-bs-toggle="modal" data-bs-target="#updateModal">
                                    <i class="bi bi-pencil"></i> Editar</button>
                                </div>  
                                <div class="col-2">
                                    <button class="btn btn-danger" onclick="onDelete(${t.id}, '${t.title}')" data-bs-toggle="modal" data-bs-target="#deleteModal">
                                    <i class="bi bi-trash"></i> Remover</button> 
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:forEach items="${done}" var="d">
                    <tr  class="table-secondary">
                        <td class="done"> <c:out value="${d.title}" /></td>
                        <td>
                            <div class="row g-0">
                                <div class="col-2">
                                    <form action="/ListaDeTarefas/">
                                        <input type="hidden" name="id" value="${d.id}">
                                        <input type="hidden" name="action" value="notDone">
                                        <button type="submit" class="btn btn-secondary"><i class="bi bi-arrow-counterclockwise"></i> Desfazer</button>
                                    </form>
                                </div>                                 
                                <div class="col-2">
                                    <button class="btn btn-danger" onclick="onDelete(${d.id}, '${d.title}')" data-bs-toggle="modal" data-bs-target="#deleteModal">
                                    <i class="bi bi-trash"></i> Remover</button> 
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Modal: create -->
        <div class="modal fade" id="createModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5">Adicionar Tarefa</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/ListaDeTarefas/" method="get">
                            <div class="mb-3">
                                <label for="title" class="form-label">Título da Tarefa</label>
                                <input type="text" class="form-control" name="title" id="title">
                            </div>
                            <input type="hidden" name="action" value="create">
                            <button type="submit" class="btn btn-success">Adicionar Tarefa</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal: update -->
        <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5">Editar Tarefa</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/ListaDeTarefas/" method="get">
                            <div class="mb-3">
                                <label for="title" class="form-label">Título da Tarefa</label>
                                <input type="text" class="form-control" name="title" id="title" value="">
                            </div>
                            <input type="hidden" name="id" value="">
                            <input type="hidden" name="action" value="update">
                            <button type="submit" class="btn btn-success">Atualizarar Tarefa</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal: delete -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5">Deseja remover a tarefa?</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="/ListaDeTarefas/" method="get">
                            <div class="mb-3">
                                <label for="title" class="form-label">Título da Tarefa</label>
                                <input type="text" class="form-control" name="title" id="title" value="" readonly>
                            </div>
                            <input type="hidden" name="id" value="">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="btn btn-danger">Remover Tarefa</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script>
                                    function onUpdate(id, title) {
                                        //console.log("id " + id);
                                        //console.log("titulo " + title);

                                        const id_el = document.querySelector("#updateModal input[name=id]");
                                        const title_el = document.querySelector("#updateModal input[name=title]");

                                        id_el.value = id;
                                        title_el.value = title;
                                    }

                                    function onDelete(id, title) {

                                        const id_el = document.querySelector("#deleteModal input[name=id]");
                                        const title_el = document.querySelector("#deleteModal input[name=title]");

                                        id_el.value = id;
                                        title_el.value = title;
                                    }
        </script>
    </body>
</html>
