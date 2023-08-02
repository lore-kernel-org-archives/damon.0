Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653C12B84
	for <damon@lists.linux.dev>; Wed,  2 Aug 2023 21:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9802AC433C9;
	Wed,  2 Aug 2023 21:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691011951;
	bh=yEbF4+MD2fwxwTT+Hga32t2Dr/eR/mptRKFvKfgNyUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZqyP22dRe9txftfj0mTUSKJdBVIfJS1fQ0q1DN993ssD71Y/JqUWnM0H60utm4t2J
	 uMCZdbNjNYBEz2HiAbC4KO9ZTcRMCAlxOo93soa5DH1MH2yNhVq6MNYcRbGNhY0ZOB
	 oHCr8oMfDxScd3CpAtFHklMIqLUyywRvNsuJmsL1Z3afAKXlBqtzQuw9liSjCXiwsG
	 ZnWPOJPpSLsqkpRJCTHsn7DIS0hIFSOz0BR+yYwpUTZ8B//Vm6Re/QFwCS9iW9aQKO
	 rVZEF0cDLe1gJGf6HsNUEyr/1p45zPFuEOX8VrD/DD6sBCE7YZRLXHgcaXt/NP7SrL
	 sQHPQ24C4gGgg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] Docs/admin-guide/mm/damon/usage: update for tried_regions/total_bytes
Date: Wed,  2 Aug 2023 21:32:21 +0000
Message-Id: <20230802213222.109841-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802213222.109841-1-sj@kernel.org>
References: <20230802213222.109841-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the DAMON usage document for newly added
schemes/.../tried_regions/total_bytes file and the
update_schemes_tried_bytes command.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 42 +++++++++++++-------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 2d495fa85a0e..1859dd6c3834 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -87,7 +87,7 @@ comma (","). ::
     │ │ │ │ │ │ │ filters/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
     │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
-    │ │ │ │ │ │ │ tried_regions/
+    │ │ │ │ │ │ │ tried_regions/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
@@ -127,14 +127,18 @@ in the state.  Writing ``commit`` to the ``state`` file makes kdamond reads the
 user inputs in the sysfs files except ``state`` file again.  Writing
 ``update_schemes_stats`` to ``state`` file updates the contents of stats files
 for each DAMON-based operation scheme of the kdamond.  For details of the
-stats, please refer to :ref:`stats section <sysfs_schemes_stats>`.  Writing
-``update_schemes_tried_regions`` to ``state`` file updates the DAMON-based
-operation scheme action tried regions directory for each DAMON-based operation
-scheme of the kdamond.  Writing ``clear_schemes_tried_regions`` to ``state``
-file clears the DAMON-based operating scheme action tried regions directory for
-each DAMON-based operation scheme of the kdamond.  For details of the
-DAMON-based operation scheme action tried regions directory, please refer to
-:ref:`tried_regions section <sysfs_schemes_tried_regions>`.
+stats, please refer to :ref:`stats section <sysfs_schemes_stats>`.
+
+Writing ``update_schemes_tried_regions`` to ``state`` file updates the
+DAMON-based operation scheme action tried regions directory for each
+DAMON-based operation scheme of the kdamond.  Writing
+``update_schemes_tried_bytes`` to ``state`` file updates only
+``.../tried_regions/total_bytes`` files.  Writing
+``clear_schemes_tried_regions`` to ``state`` file clears the DAMON-based
+operating scheme action tried regions directory for each DAMON-based operation
+scheme of the kdamond.  For details of the DAMON-based operation scheme action
+tried regions directory, please refer to :ref:`tried_regions section
+<sysfs_schemes_tried_regions>`.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
@@ -406,13 +410,21 @@ stats by writing a special keyword, ``update_schemes_stats`` to the relevant
 schemes/<N>/tried_regions/
 --------------------------
 
+This directory initially has one file, ``total_bytes``.
+
 When a special keyword, ``update_schemes_tried_regions``, is written to the
-relevant ``kdamonds/<N>/state`` file, DAMON creates directories named integer
-starting from ``0`` under this directory.  Each directory contains files
-exposing detailed information about each of the memory region that the
-corresponding scheme's ``action`` has tried to be applied under this directory,
-during next :ref:`aggregation interval <sysfs_monitoring_attrs>`.  The
-information includes address range, ``nr_accesses``, and ``age`` of the region.
+relevant ``kdamonds/<N>/state`` file, DAMON updates the ``total_bytes`` file so
+that reading it returns the total size of the scheme tried regions, and creates
+directories named integer starting from ``0`` under this directory.  Each
+directory contains files exposing detailed information about each of the memory
+region that the corresponding scheme's ``action`` has tried to be applied under
+this directory, during next :ref:`aggregation interval
+<sysfs_monitoring_attrs>`.  The information includes address range,
+``nr_accesses``, and ``age`` of the region.
+
+Writing ``update_schemes_tried_bytes`` to the relevant ``kdamonds/<N>/state``
+file will only update the ``total_bytes`` file, and will not create the
+subdirectories.
 
 The directories will be removed when another special keyword,
 ``clear_schemes_tried_regions``, is written to the relevant
-- 
2.25.1

