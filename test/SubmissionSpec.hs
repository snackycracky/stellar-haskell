{-# LANGUAGE OverloadedStrings #-}

module SubmissionSpec (spec) where

import           Control.Lens               hiding ((.=))
import           Data.Aeson
import qualified Data.ByteString.Lazy.Char8 as BLC
import           Data.Maybe
import           Data.Text
import           Prelude                    hiding (sequence)
import           System.IO.Unsafe
import           Test.Hspec
import           Web.Stellar.Types

spec = do
  describe "Engine errors during submission" $ do
    it "should report as an error" $ do
      (sequenceError ^. status) `shouldBe` SubmissionError
    it "should give a correct error message" $ do
      (fromJust $ sequenceError ^. errorMessage) `shouldBe` "This sequence number has already past."
  describe "Stellar errors during submission" $ do
    it "should report as an error" $ do
      (stellarError ^. status) `shouldBe` SubmissionError
  describe "Normal operation" $ do
    it "should not report errors" $ do
      (submissionOK ^. status) `shouldBe` SubmissionSuccess

sequenceError :: SubmissionResponse
sequenceError = (fromJust.decode.BLC.pack) (unsafePerformIO $ readFile "test/fixtures/submission_sequence_error.json")

submissionOK :: SubmissionResponse
submissionOK = (fromJust.decode.BLC.pack) (unsafePerformIO $ readFile "test/fixtures/no_error.json")

stellarError :: SubmissionResponse
stellarError = (fromJust.decode.BLC.pack) (unsafePerformIO $ readFile "test/fixtures/stellar_error.json")

