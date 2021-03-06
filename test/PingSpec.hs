{-# LANGUAGE OverloadedStrings #-}

module PingSpec (spec) where

import           Test.Hspec
import           Web.Stellar.Request

spec :: Spec
spec = do
  describe "Pinging Stellar" $ do
    it "returns Right PingSuccess when everything is ok" $ do
      res <- pingStellar (Endpoint "http://localhost:5005")
      res `shouldBe` (Right PingSuccess)
    it "returns Left PingFailure when everything is not ok" $ do
      res <- pingStellar (Endpoint "https://google.com")
      res `shouldBe` (Left PingFailure)
