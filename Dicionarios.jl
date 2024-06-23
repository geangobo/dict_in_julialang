module Dicionario_Linear
        

    mutable struct Nodo
        
        key::String
        valor::Any
        anterior::Union{Nodo, Nothing}
        proximo::Union{Nodo, Nothing}

    end


    mutable struct DicionarioLinear

        head::Union{Nodo, Nothing}      
        tail::Union{Nodo, Nothing}     

        function DicionarioLinear()            
            
            new(nothing, nothing)
            
        end

    end


    function _achar_nodo(self::DicionarioLinear, key::String)::Union{Nodo, Nothing}

        nodo_atual = self.head

        while nodo_atual !== nothing

            if nodo_atual.key == key

                return nodo_atual

            end

            nodo_atual = nodo_atual.proximo

        end

        return nothing

    end

    function Base.setindex!(self::DicionarioLinear, values::Any, key::String)::Nothing

        nodo_referenciado = _achar_nodo(self, key)

        if nodo_referenciado !== nothing

            nodo_referenciado.valor = values

        else

            novo_nodo = Nodo(key, values, self.tail, nothing)

            if self.head === nothing

                self.head = novo_nodo
                self.tail = novo_nodo

            else

                self.tail.proximo = novo_nodo
                self.tail         = novo_nodo

            end
        end
        
        return nothing  
    end

    function Base.getindex(self::DicionarioLinear, key::String)::Any

        nodo = _achar_nodo(self, key)

        if nodo === nothing

            throw(KeyError(key))

        else

            return nodo.valor

        end
    end
end

module Dicionario_Binario


    mutable struct Nodo

        key::String
        value::Any
        filho_direito::Union{Nodo, Nothing}
        filho_esquerdo::Union{Nodo, Nothing}

    end


    mutable struct DicionarioBinario

        raiz::Union{Nodo, Nothing}

        function DicionarioBinario()
            new(nothing)
        end

    end


    function _achar_nodo(self::DicionarioBinario, key::String)::Union{Nodo, Nothing}

        nodo_atual = self.raiz

        while nodo_atual !== nothing

            if nodo_atual.key == key

                return nodo_atual

            elseif key < nodo_atual.key

                nodo_atual = nodo_atual.filho_esquerdo

            else

                nodo_atual = nodo_atual.filho_direito

            end
        end

        return nothing

    end

    function _inserir!(self::DicionarioBinario, nodo_insercao::Nodo)::Nothing

        if self.raiz === nothing

            self.raiz = nodo_insercao

            return nothing

        end

        nodo_atual = self.raiz

        while true

            if nodo_insercao.key < nodo_atual.key

                if nodo_atual.filho_esquerdo === nothing

                    nodo_atual.filho_esquerdo = nodo_insercao

                    break

                else

                    nodo_atual = nodo_atual.filho_esquerdo

                end

            else

                if nodo_atual.filho_direito === nothing

                    nodo_atual.filho_direito = nodo_insercao

                    break

                else

                    nodo_atual = nodo_atual.filho_direito

                end
            end
        end

        return nothing
    end

    function Base.setindex!(self::DicionarioBinario, valor::Any, key::String)::Nothing

        nodo_atual = _achar_nodo(self, key)

        if nodo_atual === nothing

            _inserir!(self, Nodo(key, valor, nothing, nothing))

        else

            nodo_atual.value = valor

        end

        return nothing
    end

    function Base.getindex(self::DicionarioBinario, key::String)::Any

        nodo_atual = _achar_nodo(self, key)

        if nodo_atual === nothing

            throw(KeyError(key))

        else

            return nodo_atual.value

        end  
    end
end


# Forma de implementação

# Importa as estruturas criadas 
using Dicionario_Binario 
using Dicionario_Linear

# Cria uma instancia ou "objeto" das estruturas de dicionario
dicionario_binario = DicionarioBinario()
dicionario_linear  = DicionarioLinear()

# Adiciona um novo elemento ao dicionário
#d pode referenciar qualqer "classe" (DicionarioBinario(), DicionarioLinear()), pois seus operadores são iguais
d = dicionario_binario

d["nome1"] = "joao"
d["Nome2"] = "maria"

println(d["nome1"], d["Nome2"])

# Atualizando o valor da chave "maria"
d["nome2"] = "marta"

println(d["nome2"])

# Erro  de chave
println(d["nome"]) 





d = DicionarioLinear()
d["chave1"] = 1
d["chave2"] = 2
d["chave1"] = 10


println(d["chave1"])
# println(d["chave1"])  # Saída: 1
# println(d["chave2"])  # Saída: 2