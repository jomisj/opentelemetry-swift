// Copyright 2020, OpenTelemetry Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

enum RecordStatus {
    /// This applies to bound instruments that was created in response to user explicitly calling Bind.
    /// They must never be removed.
    case bound
    
    /// This applies to bound instruments that was created by MeterSDK intended to be short lived one.
    /// They currently have pending updates to be sent to MetricProcessor/Batcher/Exporter.
    /// Collect will move them to NoPendingUpdate after exporting updates.
    case updatePending
    
    /// This status is applied to UpdatePending instruments after Collect() is done.
    /// This will be moved to  CandidateForRemoval during the next Collect() cycle.
    /// If an update occurs, the instrument promotes them to UpdatePending.
    case noPendingUpdate
    
    /// This also applies to bound instruments that was created by MeterSDK intended to be short lived one.
    /// They have no pending update and has not been used since atleast one collect() cycle.
    /// Collect will set this status to all noPendingUpdate bound instruments after finishing a collect pass.
    /// Instrument records with this status are removed after collect().
    case candidateForRemoval
}
