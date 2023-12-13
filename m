Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A98A818;
	Wed, 13 Dec 2023 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyr+2MY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFAEC433C9;
	Wed, 13 Dec 2023 19:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702494230;
	bh=DCzjM8ciFmSW1ZwCtCZzL7l/QtzSRPhWneY+wKj+vU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hyr+2MY6xPiuvWwHsyk6RV0Torov76tR6btlHqK49UggV0nEVIZ7ovqJ6MqiyQoBT
	 GJ6ggkCUIcocYQhX+C89P+Vh9n1X1PnrDZs1fw0/7mW6bDPCgI8S6xipNOcslhVGmf
	 OFrxcOB7yW+r6aoNVwiKd6TxmCRcFJdJN6sC2uhEVPUbFUSqM/8TKyhIA/VF2kSaJM
	 byTvwbOaaFViPxmxVRJISegjpfBKtMo0iUh7T10NR3wVO+1YRpxRMcSv3FINCQEFxC
	 w2Y77OA4sFv5hwpDOHF64Drm8gPpHk4VToAgobXt0zKgYIKbhnxYA9yC2GCMeSeSXg
	 sbt3PYCKBjPoA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] Docs/mm/damon/design: place execution model and data structures at the beginning
Date: Wed, 13 Dec 2023 19:03:35 +0000
Message-Id: <20231213190338.54146-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213190338.54146-1-sj@kernel.org>
References: <20231213190338.54146-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The execution model and data structures section at the end of the design
document is briefly explaining how DAMON works overall.  Knowing that
first may help better drawing the overall picture.  It may also help
better understanding following detailed sections.  Move it to the
beginning of the document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8b4a49ac057d..1bb69524a62e 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -5,6 +5,18 @@ Design
 ======
 
 
+.. _damon_design_execution_model_and_data_structures:
+
+Execution Model and Data Structures
+===================================
+
+The monitoring-related information including the monitoring request
+specification and DAMON-based operation schemes are stored in a data structure
+called DAMON ``context``.  DAMON executes each context with a kernel thread
+called ``kdamond``.  Multiple kdamonds could run in parallel, for different
+types of monitoring.
+
+
 Overall Architecture
 ====================
 
@@ -490,15 +502,3 @@ modules for proactive reclamation and LRU lists manipulation are provided.  For
 more detail, please read the usage documents for those
 (:doc:`/admin-guide/mm/damon/reclaim` and
 :doc:`/admin-guide/mm/damon/lru_sort`).
-
-
-.. _damon_design_execution_model_and_data_structures:
-
-Execution Model and Data Structures
-===================================
-
-The monitoring-related information including the monitoring request
-specification and DAMON-based operation schemes are stored in a data structure
-called DAMON ``context``.  DAMON executes each context with a kernel thread
-called ``kdamond``.  Multiple kdamonds could run in parallel, for different
-types of monitoring.
-- 
2.34.1

