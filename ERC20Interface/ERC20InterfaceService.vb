Imports System
Imports System.Threading.Tasks
Imports System.Collections.Generic
Imports System.Numerics
Imports Nethereum.Hex.HexTypes
Imports Nethereum.ABI.FunctionEncoding.Attributes
Imports Nethereum.Web3
Imports Nethereum.RPC.Eth.DTOs
Imports Nethereum.Contracts.CQS
Imports Nethereum.Contracts.ContractHandlers
Imports Nethereum.Contracts
Imports System.Threading
Imports ICO.Contracts.ERC20Interface.ContractDefinition
Namespace ICO.Contracts.ERC20Interface


    Public Partial Class ERC20InterfaceService
    
    
        Public Shared Function DeployContractAndWaitForReceiptAsync(ByVal web3 As Nethereum.Web3.Web3, ByVal eRC20InterfaceDeployment As ERC20InterfaceDeployment, ByVal Optional cancellationTokenSource As CancellationTokenSource = Nothing) As Task(Of TransactionReceipt)
        
            Return web3.Eth.GetContractDeploymentHandler(Of ERC20InterfaceDeployment)().SendRequestAndWaitForReceiptAsync(eRC20InterfaceDeployment, cancellationTokenSource)
        
        End Function
         Public Shared Function DeployContractAsync(ByVal web3 As Nethereum.Web3.Web3, ByVal eRC20InterfaceDeployment As ERC20InterfaceDeployment) As Task(Of String)
        
            Return web3.Eth.GetContractDeploymentHandler(Of ERC20InterfaceDeployment)().SendRequestAsync(eRC20InterfaceDeployment)
        
        End Function
        Public Shared Async Function DeployContractAndGetServiceAsync(ByVal web3 As Nethereum.Web3.Web3, ByVal eRC20InterfaceDeployment As ERC20InterfaceDeployment, ByVal Optional cancellationTokenSource As CancellationTokenSource = Nothing) As Task(Of ERC20InterfaceService)
        
            Dim receipt = Await DeployContractAndWaitForReceiptAsync(web3, eRC20InterfaceDeployment, cancellationTokenSource)
            Return New ERC20InterfaceService(web3, receipt.ContractAddress)
        
        End Function
    
        Protected Property Web3 As Nethereum.Web3.Web3
        
        Public Property ContractHandler As ContractHandler
        
        Public Sub New(ByVal web3 As Nethereum.Web3.Web3, ByVal contractAddress As String)
            Web3 = web3
            ContractHandler = web3.Eth.GetContractHandler(contractAddress)
        End Sub
    
        Public Function AllowanceRequestAsync(ByVal allowanceFunction As AllowanceFunction) As Task(Of String)
                    
            Return ContractHandler.SendRequestAsync(Of AllowanceFunction)(allowanceFunction)
        
        End Function

        Public Function AllowanceRequestAndWaitForReceiptAsync(ByVal allowanceFunction As AllowanceFunction, ByVal Optional cancellationToken As CancellationTokenSource = Nothing) As Task(Of TransactionReceipt)
        
            Return ContractHandler.SendRequestAndWaitForReceiptAsync(Of AllowanceFunction)(allowanceFunction, cancellationToken)
        
        End Function

        
        Public Function AllowanceRequestAsync(ByVal [owner] As String, ByVal [spender] As String) As Task(Of String)
        
            Dim allowanceFunction = New AllowanceFunction()
                allowanceFunction.Owner = [owner]
                allowanceFunction.Spender = [spender]
            
            Return ContractHandler.SendRequestAsync(Of AllowanceFunction)(allowanceFunction)
        
        End Function

        
        Public Function AllowanceRequestAndWaitForReceiptAsync(ByVal [owner] As String, ByVal [spender] As String, ByVal Optional cancellationToken As CancellationTokenSource = Nothing) As Task(Of TransactionReceipt)
        
            Dim allowanceFunction = New AllowanceFunction()
                allowanceFunction.Owner = [owner]
                allowanceFunction.Spender = [spender]
            
            Return ContractHandler.SendRequestAndWaitForReceiptAsync(Of AllowanceFunction)(allowanceFunction, cancellationToken)
        
        End Function
        Public Function ApproveRequestAsync(ByVal approveFunction As ApproveFunction) As Task(Of String)
                    
            Return ContractHandler.SendRequestAsync(Of ApproveFunction)(approveFunction)
        
        End Function

        Public Function ApproveRequestAndWaitForReceiptAsync(ByVal approveFunction As ApproveFunction, ByVal Optional cancellationToken As CancellationTokenSource = Nothing) As Task(Of TransactionReceipt)
        
            Return ContractHandler.SendRequestAndWaitForReceiptAsync(Of ApproveFunction)(approveFunction, cancellationToken)
        
        End Function

        
        Public Function ApproveRequestAsync(ByVal [spender] As String, ByVal [value] As BigInteger) As Task(Of String)
        
            Dim approveFunction = New ApproveFunction()
                approveFunction.Spender = [spender]
                approveFunction.Value = [value]
            
            Return ContractHandler.SendRequestAsync(Of ApproveFunction)(approveFunction)
        
        End Function

        
        Public Function ApproveRequestAndWaitForReceiptAsync(ByVal [spender] As String, ByVal [value] As BigInteger, ByVal Optional cancellationToken As CancellationTokenSource = Nothing) As Task(Of TransactionReceipt)
        
            Dim approveFunction = New ApproveFunction()
                approveFunction.Spender = [spender]
                approveFunction.Value = [value]
            
            Return ContractHandler.SendRequestAndWaitForReceiptAsync(Of ApproveFunction)(approveFunction, cancellationToken)
        
        End Function
        Public Function BalanceOfQueryAsync(ByVal balanceOfFunction As BalanceOfFunction, ByVal Optional blockParameter As BlockParameter = Nothing) As Task(Of BigInteger)
        
            Return ContractHandler.QueryAsync(Of BalanceOfFunction, BigInteger)(balanceOfFunction, blockParameter)
        
        End Function

        
        Public Function BalanceOfQueryAsync(ByVal [owner] As String, ByVal Optional blockParameter As BlockParameter = Nothing) As Task(Of BigInteger)
        
            Dim balanceOfFunction = New BalanceOfFunction()
                balanceOfFunction.Owner = [owner]
            
            Return ContractHandler.QueryAsync(Of BalanceOfFunction, BigInteger)(balanceOfFunction, blockParameter)
        
        End Function


        Public Function TotalSupplyQueryAsync(ByVal totalSupplyFunction As TotalSupplyFunction, ByVal Optional blockParameter As BlockParameter = Nothing) As Task(Of BigInteger)
        
            Return ContractHandler.QueryAsync(Of TotalSupplyFunction, BigInteger)(totalSupplyFunction, blockParameter)
        
        End Function

        
        Public Function TotalSupplyQueryAsync(ByVal Optional blockParameter As BlockParameter = Nothing) As Task(Of BigInteger)
        
            return ContractHandler.QueryAsync(Of TotalSupplyFunction, BigInteger)(Nothing, blockParameter)
        
        End Function



        Public Function TransferRequestAsync(ByVal transferFunction As TransferFunction) As Task(Of String)
                    
            Return ContractHandler.SendRequestAsync(Of TransferFunction)(transferFunction)
        
        End Function

        Public Function TransferRequestAndWaitForReceiptAsync(ByVal transferFunction As TransferFunction, ByVal Optional cancellationToken As CancellationTokenSource = Nothing) As Task(Of TransactionReceipt)
        
            Return ContractHandler.SendRequestAndWaitForReceiptAsync(Of TransferFunction)(transferFunction, cancellationToken)
        
        End Function

        
        Public Function TransferRequestAsync(ByVal [to] As String, ByVal [value] As BigInteger) As Task(Of String)
        
            Dim transferFunction = New TransferFunction()
                transferFunction.To = [to]
                transferFunction.Value = [value]
            
            Return ContractHandler.SendRequestAsync(Of TransferFunction)(transferFunction)
        
        End Function

        
        Public Function TransferRequestAndWaitForReceiptAsync(ByVal [to] As String, ByVal [value] As BigInteger, ByVal Optional cancellationToken As CancellationTokenSource = Nothing) As Task(Of TransactionReceipt)
        
            Dim transferFunction = New TransferFunction()
                transferFunction.To = [to]
                transferFunction.Value = [value]
            
            Return ContractHandler.SendRequestAndWaitForReceiptAsync(Of TransferFunction)(transferFunction, cancellationToken)
        
        End Function
        Public Function TransferFromRequestAsync(ByVal transferFromFunction As TransferFromFunction) As Task(Of String)
                    
            Return ContractHandler.SendRequestAsync(Of TransferFromFunction)(transferFromFunction)
        
        End Function

        Public Function TransferFromRequestAndWaitForReceiptAsync(ByVal transferFromFunction As TransferFromFunction, ByVal Optional cancellationToken As CancellationTokenSource = Nothing) As Task(Of TransactionReceipt)
        
            Return ContractHandler.SendRequestAndWaitForReceiptAsync(Of TransferFromFunction)(transferFromFunction, cancellationToken)
        
        End Function

        
        Public Function TransferFromRequestAsync(ByVal [from] As String, ByVal [to] As String, ByVal [value] As BigInteger) As Task(Of String)
        
            Dim transferFromFunction = New TransferFromFunction()
                transferFromFunction.From = [from]
                transferFromFunction.To = [to]
                transferFromFunction.Value = [value]
            
            Return ContractHandler.SendRequestAsync(Of TransferFromFunction)(transferFromFunction)
        
        End Function

        
        Public Function TransferFromRequestAndWaitForReceiptAsync(ByVal [from] As String, ByVal [to] As String, ByVal [value] As BigInteger, ByVal Optional cancellationToken As CancellationTokenSource = Nothing) As Task(Of TransactionReceipt)
        
            Dim transferFromFunction = New TransferFromFunction()
                transferFromFunction.From = [from]
                transferFromFunction.To = [to]
                transferFromFunction.Value = [value]
            
            Return ContractHandler.SendRequestAndWaitForReceiptAsync(Of TransferFromFunction)(transferFromFunction, cancellationToken)
        
        End Function
    
    End Class

End Namespace
