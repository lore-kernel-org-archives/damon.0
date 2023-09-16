Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B259539D
	for <damon@lists.linux.dev>; Sat, 16 Sep 2023 02:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E569C433C7;
	Sat, 16 Sep 2023 02:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694830209;
	bh=mFM51HzoacyqEH6SUQlgy6Seux4I2scRhn39ZTi26N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RR9FrdagkAthQDZzU/MqLOXvaeDFzI76AyKnmNaANhjKl5qK562b8z09HGpclirta
	 jYc6LhrAJdUrtF6/8jEUYFxkzhz4DQs0wM8OIqyrP6MuYh5q8fsrOCkAhZ8cDkRDL+
	 m68G1t0/aauOfr5qF8XtuEjYHQmFewU+Siz5iH7DwXksWnvKxs++VqIl9SDSLjoUoY
	 0QdXTO1VgnyGAGXCuhbJxMUqcWGdICS6t8Md21tTKIOimgBmf0pSxHXMHOvbu2Sjsc
	 As4vL2HJ+p/l6ENXnlhs5iHasOdBcHl2cwXlMbhtQReq+p8GnBNOXcxmZ4rOV/Zo9t
	 87jyj74Sod1Gg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] Docs/admin-guide/mm/damon/usage: update for DAMOS apply intervals
Date: Sat, 16 Sep 2023 02:09:44 +0000
Message-Id: <20230916020945.47296-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230916020945.47296-1-sj@kernel.org>
References: <20230916020945.47296-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document's DAMON sysfs interface section for the
newly added DAMOS apply intervals support (apply_interval_us file).

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 6272cd36590a..8507a6e45d86 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -76,7 +76,7 @@ comma (","). ::
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ │ schemes/nr_schemes
-    │ │ │ │ │ │ 0/action
+    │ │ │ │ │ │ 0/action,apply_interval_us
     │ │ │ │ │ │ │ access_pattern/
     │ │ │ │ │ │ │ │ sz/min,max
     │ │ │ │ │ │ │ │ nr_accesses/min,max
@@ -269,8 +269,8 @@ schemes/<N>/
 ------------
 
 In each scheme directory, five directories (``access_pattern``, ``quotas``,
-``watermarks``, ``filters``, ``stats``, and ``tried_regions``) and one file
-(``action``) exist.
+``watermarks``, ``filters``, ``stats``, and ``tried_regions``) and two files
+(``action`` and ``apply_interval``) exist.
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
@@ -296,6 +296,9 @@ Note that support of each action depends on the running DAMON operations set
  - ``stat``: Do nothing but count the statistics.
    Supported by all operations sets.
 
+The ``apply_interval_us`` file is for setting and getting the scheme's
+:ref:`apply_interval <damon_design_damos>` in microseconds.
+
 schemes/<N>/access_pattern/
 ---------------------------
 
-- 
2.25.1

