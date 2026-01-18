Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5B22B8C5;
	Sun, 18 Jan 2026 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768759392; cv=none; b=Y5OpMnK3zS14mkMgeEBqoOi8JiaQamWU1g7plDEOyJzu5Ki/eU4OZm+JzQvDvXlVtVSb1vXL7Z5dByCHHJxbJTZgd8mGqDH/eodOz2b7oeACkXmImHX6tizH1QF9VccEvjpa889PvvTBzbl/pCx0melYhRGiwypEue/xfSF+/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768759392; c=relaxed/simple;
	bh=83IuoEFZc740QLG5aKQwcz8CHpKwZZ8E6QMpPE52AHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olw8KjORc1py73wRD46UzRSIXqlWyHxcd3Es3kaRgraLQqx0xWUdLDsvFOee+7mGBEySt8N/eTev2pUTFc5/EYqMplp2xlsORPdWmxZeIJPh9tG95jT8kHJmCqfvLt6vOfzfwuyM8SDeQ5HGsgGejQDln/gdndjakXXFctpOQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWz+F1u2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWz+F1u2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF20C19423;
	Sun, 18 Jan 2026 18:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768759391;
	bh=83IuoEFZc740QLG5aKQwcz8CHpKwZZ8E6QMpPE52AHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWz+F1u2EZ9yGEw3rOBKhxt5QQtmFKsc3wwyz5sy4hP1KAsBNR9Sm/3l+es57SZJ8
	 1YXKlPu02whCdxvVeJTqyJBLKNZYHS7jDfwCQIRCWItCKrbHn6XIp+rlfStnSGEhgv
	 kt0Jro1/f3e+3xdh05vBDp1tpLUF6/8b/AlM0rsSHrvUF/e5H708cVhSRiuwQmCPGt
	 ttEl49dq4FxIgNVXutmlwFMbukr3l6gpV5j906Ot9HyXixjYFXhNGzEwFMrCVZ5bHt
	 hduyjVpjCRY4qwWk7fvBWcXLYxiOXOS4wH4RWdwuBVswxPNlTfRyTxgob1rGJexsB2
	 JjEuCFXgguSvw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] Docs/mm/damon/index: simplify the intro
Date: Sun, 18 Jan 2026 10:02:52 -0800
Message-ID: <20260118180305.70023-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260118180305.70023-1-sj@kernel.org>
References: <20260118180305.70023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intro is a bit verbose and redundant.  Simplify it by replacing
details with more links to the design docs, and refining the design
points list.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/index.rst | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/Documentation/mm/damon/index.rst b/Documentation/mm/damon/index.rst
index 31c1fa955b3d..82f6c5eea49a 100644
--- a/Documentation/mm/damon/index.rst
+++ b/Documentation/mm/damon/index.rst
@@ -4,28 +4,15 @@
 DAMON: Data Access MONitoring and Access-aware System Operations
 ================================================================
 
-DAMON is a Linux kernel subsystem that provides a framework for data access
-monitoring and the monitoring results based system operations.  The core
-monitoring :ref:`mechanisms <damon_design_monitoring>` of DAMON make it
-
- - *accurate* (the monitoring output is useful enough for DRAM level memory
-   management; It might not appropriate for CPU Cache levels, though),
- - *light-weight* (the monitoring overhead is low enough to be applied online),
-   and
- - *scalable* (the upper-bound of the overhead is in constant range regardless
-   of the size of target workloads).
-
-Using this framework, therefore, the kernel can operate system in an
-access-aware fashion.  Because the features are also exposed to the :doc:`user
-space </admin-guide/mm/damon/index>`, users who have special information about
-their workloads can write personalized applications for better understanding
-and optimizations of their workloads and systems.
-
-For easier development of such systems, DAMON provides a feature called
-:ref:`DAMOS <damon_design_damos>` (DAMon-based Operation Schemes) in addition
-to the monitoring.  Using the feature, DAMON users in both kernel and :doc:`user
-spaces </admin-guide/mm/damon/index>` can do access-aware system operations
-with no code but simple configurations.
+DAMON is a Linux kernel subsystem for efficient :ref:`data access monitoring
+<damon_design_monitoring>` and :ref:`access-aware system operations
+<damon_design_damos>`.  It is designed for being
+
+ - *accurate* (for DRAM level memory management),
+ - *light-weight* (for production online usages),
+ - *scalable* (in terms of memory size),
+ - *tunable* (for flexible usages), and
+ - *autoamted* (for production operation without manual tunings).
 
 .. toctree::
    :maxdepth: 2
-- 
2.47.3
