/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Repository;

import Model.Tarefa;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author joaopedro
 */

//simuluando banco de dados -> CRUD

public class TarefaRepository {
    
    private static  int Auto_INCREMENT = 0;
    private static List<Tarefa> tarefas_db = new ArrayList<>();
    
    public void create(Tarefa tarefa){
        Auto_INCREMENT++;
        tarefa.setId(Auto_INCREMENT);
        tarefas_db.add(tarefa);
    }
    
    public List<Tarefa> read(){
        return tarefas_db;
    }
    
    public void update(Tarefa tarefa){
        for(Tarefa t : tarefas_db){
            if(t.getId().intValue() == tarefa.getId().intValue()){
                t.setTitle(tarefa.getTitle());
                break;
            }
        }
    }
    
    public void delete(Tarefa tarefa){
        for(Tarefa t : tarefas_db){
            if(t.getId().intValue() == tarefa.getId().intValue()){
                tarefas_db.remove(t);
                break;
            }
        }
        //outra forma de fazer
        //tarefas_db = tarefas_db.stream().filter(t -> t.getId().intValue() != tarefa.getId().intValue()).collect(Collectors.toList());
    }
}
