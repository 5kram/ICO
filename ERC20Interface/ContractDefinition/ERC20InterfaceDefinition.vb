Imports System
Imports System.Threading.Tasks
Imports System.Collections.Generic
Imports System.Numerics
Imports Nethereum.Hex.HexTypes
Imports Nethereum.ABI.FunctionEncoding.Attributes
Imports Nethereum.Web3
Imports Nethereum.RPC.Eth.DTOs
Imports Nethereum.Contracts.CQS
Imports Nethereum.Contracts
Imports System.Threading
Namespace ICO.Contracts.ERC20Interface.ContractDefinition

    
    
    Public Partial Class ERC20InterfaceDeployment
     Inherits ERC20InterfaceDeploymentBase
    
        Public Sub New()
            MyBase.New(DEFAULT_BYTECODE)
        End Sub
        
        Public Sub New(ByVal byteCode As String)
            MyBase.New(byteCode)
        End Sub
    
    End Class

    Public Class ERC20InterfaceDeploymentBase 
            Inherits ContractDeploymentMessage
        
        Public Shared DEFAULT_BYTECODE As String = ""
        
        Public Sub New()
            MyBase.New(DEFAULT_BYTECODE)
        End Sub
        
        Public Sub New(ByVal byteCode As String)
            MyBase.New(byteCode)
        End Sub
        

    
    End Class    
    
    Public Partial Class AllowanceFunction
        Inherits AllowanceFunctionBase
    End Class

        <[Function]("allowance", "uint256")>
    Public Class AllowanceFunctionBase
        Inherits FunctionMessage
    
        <[Parameter]("address", "_owner", 1)>
        Public Overridable Property [Owner] As String
        <[Parameter]("address", "_spender", 2)>
        Public Overridable Property [Spender] As String
    
    End Class
    
    
    Public Partial Class ApproveFunction
        Inherits ApproveFunctionBase
    End Class

        <[Function]("approve", "bool")>
    Public Class ApproveFunctionBase
        Inherits FunctionMessage
    
        <[Parameter]("address", "_spender", 1)>
        Public Overridable Property [Spender] As String
        <[Parameter]("uint256", "_value", 2)>
        Public Overridable Property [Value] As BigInteger
    
    End Class
    
    
    Public Partial Class BalanceOfFunction
        Inherits BalanceOfFunctionBase
    End Class

        <[Function]("balanceOf", "uint256")>
    Public Class BalanceOfFunctionBase
        Inherits FunctionMessage
    
        <[Parameter]("address", "_owner", 1)>
        Public Overridable Property [Owner] As String
    
    End Class
    
    
    Public Partial Class TotalSupplyFunction
        Inherits TotalSupplyFunctionBase
    End Class

        <[Function]("totalSupply", "uint256")>
    Public Class TotalSupplyFunctionBase
        Inherits FunctionMessage
    

    
    End Class
    
    
    Public Partial Class TransferFunction
        Inherits TransferFunctionBase
    End Class

        <[Function]("transfer", "bool")>
    Public Class TransferFunctionBase
        Inherits FunctionMessage
    
        <[Parameter]("address", "_to", 1)>
        Public Overridable Property [To] As String
        <[Parameter]("uint256", "_value", 2)>
        Public Overridable Property [Value] As BigInteger
    
    End Class
    
    
    Public Partial Class TransferFromFunction
        Inherits TransferFromFunctionBase
    End Class

        <[Function]("transferFrom", "bool")>
    Public Class TransferFromFunctionBase
        Inherits FunctionMessage
    
        <[Parameter]("address", "_from", 1)>
        Public Overridable Property [From] As String
        <[Parameter]("address", "_to", 2)>
        Public Overridable Property [To] As String
        <[Parameter]("uint256", "_value", 3)>
        Public Overridable Property [Value] As BigInteger
    
    End Class
    
    
    Public Partial Class ApprovalEventDTO
        Inherits ApprovalEventDTOBase
    End Class

    <[Event]("Approval")>
    Public Class ApprovalEventDTOBase
        Implements IEventDTO
        
        <[Parameter]("address", "_owner", 1, true)>
        Public Overridable Property [Owner] As String
        <[Parameter]("address", "_spender", 2, true)>
        Public Overridable Property [Spender] As String
        <[Parameter]("uint256", "_value", 3, false)>
        Public Overridable Property [Value] As BigInteger
    
    End Class    
    
    Public Partial Class TransferEventDTO
        Inherits TransferEventDTOBase
    End Class

    <[Event]("Transfer")>
    Public Class TransferEventDTOBase
        Implements IEventDTO
        
        <[Parameter]("address", "_from", 1, true)>
        Public Overridable Property [From] As String
        <[Parameter]("address", "_to", 2, true)>
        Public Overridable Property [To] As String
        <[Parameter]("uint256", "_value", 3, false)>
        Public Overridable Property [Value] As BigInteger
    
    End Class    
    
    
    
    
    
    Public Partial Class BalanceOfOutputDTO
        Inherits BalanceOfOutputDTOBase
    End Class

    <[FunctionOutput]>
    Public Class BalanceOfOutputDTOBase
        Implements IFunctionOutputDTO
        
        <[Parameter]("uint256", "balance", 1)>
        Public Overridable Property [Balance] As BigInteger
    
    End Class    
    
    Public Partial Class TotalSupplyOutputDTO
        Inherits TotalSupplyOutputDTOBase
    End Class

    <[FunctionOutput]>
    Public Class TotalSupplyOutputDTOBase
        Implements IFunctionOutputDTO
        
        <[Parameter]("uint256", "", 1)>
        Public Overridable Property [ReturnValue1] As BigInteger
    
    End Class    
    
    
    

End Namespace
