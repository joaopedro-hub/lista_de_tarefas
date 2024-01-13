/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Tarefa;
import Repository.TarefaRepository;
import Service.TarefaService;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author joaopedro
 */
//caminho raiz -> urlPatterns = {"/"}
@WebServlet(name = "TarefaServlet", urlPatterns = {"/"})
public class TarefaServlet extends HttpServlet {

    private TarefaRepository tarefa_rep = new TarefaRepository();
    private TarefaService tafService = new TarefaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //resp.getWriter().write("Testando");
        String action = req.getParameter("action");
        String title = req.getParameter("title");
        String idString = req.getParameter("id");
        Integer id = null;
        
        

        if (action == null) {
            action = "read";
        }
        if(idString != null){
            id = Integer.parseInt(idString);
        }
        
        
        Tarefa tarefa = new Tarefa();
        
        tarefa.setId(id);
        tarefa.setTitle(title);
        tarefa.setDone(false);
        
        
        switch (action) {
            case "create":
                tarefa_rep.create(tarefa);
                resp.sendRedirect("/ListaDeTarefas/");
                break;
            case "read":
                List<Tarefa> tarefas = tarefa_rep.read();
                
                //Filtrando todas as tarefas da lista,que o done == true
                List<Tarefa> done = tarefas.stream().filter(t -> t.isDone()).collect(Collectors.toList());
                //Filtrando todas as tarefas da lista,que o done != true
                List<Tarefa> notDone = tarefas.stream().filter(t -> !t.isDone()).collect(Collectors.toList());
                
                //Criando um atributo na requisição que chegou
                //req.setAttribute("tarefas", tarefas);
                req.setAttribute("done", done);
                req.setAttribute("notDone", notDone);
                
                //Encaminhando a requisição para a index.jsp
                RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/index.jsp");
                rd.forward(req, resp);
                break;
            case "update":
                tarefa_rep.update(tarefa);
                resp.sendRedirect("/ListaDeTarefas/");
                break;
            case "delete":
                tarefa_rep.delete(tarefa);
                resp.sendRedirect("/ListaDeTarefas/");
                break;
            case "done":
                tafService.markAsDone(tarefa);
                resp.sendRedirect("/ListaDeTarefas/");
                break;
            case "notDone":
                tafService.markAsNotDone(tarefa);
                resp.sendRedirect("/ListaDeTarefas/");
                break;
            default:
                break;
        }

    }

}
