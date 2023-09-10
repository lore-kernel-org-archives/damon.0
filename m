Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C83185C
	for <damon@lists.linux.dev>; Sun, 10 Sep 2023 03:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCC7C433CB;
	Sun, 10 Sep 2023 03:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694317256;
	bh=mFM51HzoacyqEH6SUQlgy6Seux4I2scRhn39ZTi26N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ggjMC2rmC/l0w3mnxmHmvMLHBY+eoIkIhaqUHgcKJkeLp9KdJd9TOBud13T113lyx
	 bK+9WVt2wR8tYBlSMiwDTbbJWBtR8c2uKMve4DoO47Ocw9i1LprtBLoEe8R1sVkRu6
	 QaVmD7Domx1Dhzr1xW9KHlMlM8CpgIkYhycXUCR1+xnrQy7lcckR7acPYU9lpf9ZKi
	 139vmPrd7zxFCh1zlOZ/eQoDhJMv/Ybu9j8+QqTtqcG/fUvso0W2tLBty1MDSUlTwy
	 yyTYrg/FNIF/NEfT3QCrRkNG+qDMx2BtxTu2DvezLkq674bfGaS9kb86X/wN6Q68v5
	 MehGv6Co7gdAA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 7/8] Docs/admin-guide/mm/damon/usage: update for DAMOS apply intervals
Date: Sun, 10 Sep 2023 03:40:47 +0000
Message-Id: <20230910034048.59191-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910034048.59191-1-sj@kernel.org>
References: <20230910034048.59191-1-sj@kernel.org>
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

