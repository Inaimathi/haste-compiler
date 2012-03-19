-- | Various functions generated as builtins
module CodeGen.Javascript.Builtins (toBuiltin) where
import GhcPlugins as P
import CodeGen.Javascript.AST as AST
import Control.Applicative

toBuiltin :: P.Var -> Maybe JSVar
toBuiltin v =
  case (modname, varname) of
    (Just "GHC.Prim", "realWorld#") ->
      Just $ JSVar {jsmod  = foreignModName,
                    jsname = Foreign "realWorld"}
    (Just "GHC.CString", "unpackCString#") ->
      Just $ JSVar {jsmod  = foreignModName,
                    jsname = Foreign "unCStr"}
    (Just "GHC.CString", "unpackCStringUtf8#") ->
      Just $ JSVar {jsmod  = foreignModName,
                    jsname = Foreign "unCStr"}
    (Just "GHC.CString", "unpackAppendCString#") ->
      Just $ JSVar {jsmod  = foreignModName,
                    jsname = Foreign "unAppCStr"}
    (Just "Haste.Prim", "toJSStr") ->
      Just $ JSVar {jsmod  = foreignModName,
                    jsname = Foreign "toJSStr"}
    (Just "Haste.Prim", "fromJSStr") ->
      Just $ JSVar {jsmod  = foreignModName,
                    jsname = Foreign "fromJSStr"}
    (Just "GHC.Err", "error") ->
      Just $ JSVar {jsmod  = foreignModName,
                    jsname = Foreign "err"}
    _ | otherwise ->
      Nothing
  where
    modname = moduleNameString . moduleName <$> nameModule_maybe (varName v)
    varname = occNameString $ nameOccName $ varName v
    foreignModName = moduleNameString $ name foreignModule