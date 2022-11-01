Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A5E1E9FA
	for <damon@lists.linux.dev>; Tue,  1 Nov 2022 22:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C393C433C1;
	Tue,  1 Nov 2022 22:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667340217;
	bh=XY/ulrYaYGf2HDwTIn5UM+YygVjoR1FVPIUX5UmsGLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAuVFi8XC9immb+OBoh45a69etCiIxST3cQ8zlUrBziijVny5gzKm1g6mJqPwryDE
	 gu2m/my5MjOsEff8QdTwpPM2gvreMqHywFlVaGUGE6HrZCS5jBn8HAUSAu7K0t+t8b
	 3+ATJxW4lPChNcbiIe/KTaGpulS+IsO62n4Zh6qaDCvakn40ifgWtX2ZMwmtuuMFis
	 W2Dd1zQSIB/iAhpN+GeC9JlZtMW1pwuE/lQU7II4S32fjxG6RY/WSqOEzOeQ1hb4c0
	 9C9pYgxdYobujW+mCapDZEkkGu5CLw0gQj/h94WcbzWiluppkFQGpJWraXyg90HgV/
	 mpibBeqhmoKNQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 7/8] Docs/admin-guide/mm/damon/usage: document schemes/<s>/tried_regions sysfs directory
Date: Tue,  1 Nov 2022 22:03:27 +0000
Message-Id: <20221101220328.95765-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101220328.95765-1-sj@kernel.org>
References: <20221101220328.95765-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document 'tried_regions' directory in DAMON sysfs interface usage in the
administrator guide.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 45 ++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index c17e02e1e426..1a5b6b71efa1 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -88,6 +88,9 @@ comma (","). ::
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
     │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
+    │ │ │ │ │ │ │ tried_regions/
+    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
+    │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ ...
     │ │ ...
@@ -125,7 +128,14 @@ in the state.  Writing ``commit`` to the ``state`` file makes kdamond reads the
 user inputs in the sysfs files except ``state`` file again.  Writing
 ``update_schemes_stats`` to ``state`` file updates the contents of stats files
 for each DAMON-based operation scheme of the kdamond.  For details of the
-stats, please refer to :ref:`stats section <sysfs_schemes_stats>`.
+stats, please refer to :ref:`stats section <sysfs_schemes_stats>`.  Writing
+``update_schemes_tried_regions`` to ``state`` file updates the DAMON-based
+operation scheme action tried regions directory for each DAMON-based operation
+scheme of the kdamond.  Writing ``clear_schemes_tried_regions`` to ``state``
+file clears the DAMON-based operating scheme action tried regions directory for
+each DAMON-based operation scheme of the kdamond.  For details of the
+DAMON-based operation scheme action tried regions directory, please refer to
+:ref:tried_regions section <sysfs_schemes_tried_regions>`.
 
 If the state is ``on``, reading ``pid`` shows the pid of the kdamond thread.
 
@@ -166,6 +176,8 @@ You can set and get what type of monitoring operations DAMON will use for the
 context by writing one of the keywords listed in ``avail_operations`` file and
 reading from the ``operations`` file.
 
+.. _sysfs_monitoring_attrs:
+
 contexts/<N>/monitoring_attrs/
 ------------------------------
 
@@ -255,8 +267,9 @@ to ``N-1``.  Each directory represents each DAMON-based operation scheme.
 schemes/<N>/
 ------------
 
-In each scheme directory, four directories (``access_pattern``, ``quotas``,
-``watermarks``, and ``stats``) and one file (``action``) exist.
+In each scheme directory, five directories (``access_pattern``, ``quotas``,
+``watermarks``, ``stats``, and ``tried_regions``) and one file (``action``)
+exist.
 
 The ``action`` file is for setting and getting what action you want to apply to
 memory regions having specific access pattern of the interest.  The keywords
@@ -351,6 +364,32 @@ should ask DAMON sysfs interface to updte the content of the files for the
 stats by writing a special keyword, ``update_schemes_stats`` to the relevant
 ``kdamonds/<N>/state`` file.
 
+.. _sysfs_schemes_tried_regions:
+
+schemes/<N>/tried_regions/
+--------------------------
+
+When a special keyword, ``update_schemes_tried_regions``, is written to the
+relevant ``kdamonds/<N>/state`` file, DAMON creates directories named integer
+starting from ``0`` under this directory.  Each directory contains files
+exposing detailed information about each of the memory region that the
+corresponding scheme's ``action`` has tried to be applied under this directory,
+during next :ref:`aggregation interval <sysfs_monitoring_attrs>`.  The
+information includes address range, ``nr_accesses``, , and ``age`` of the
+region.
+
+The directories will be removed when another special keyword,
+``clear_schemes_tried_regions``, is written to the relevant
+``kdamonds/<N>/state`` file.
+
+tried_regions/<N>/
+------------------
+
+In each region directory, you will find four files (``start``, ``end``,
+``nr_accesses``, and ``age``).  Reading the files will show the start and end
+addresses, ``nr_accesses``, and ``age`` of the region that corresponding
+DAMON-based operation scheme ``action`` has tried to be applied.
+
 Example
 ~~~~~~~
 
-- 
2.25.1

