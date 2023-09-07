Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F7A47
	for <damon@lists.linux.dev>; Thu,  7 Sep 2023 02:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756FAC433CA;
	Thu,  7 Sep 2023 02:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694053779;
	bh=ddAwo+PJ4HbDbLRCVex0LmwHXE3nv9K1631hg64QSQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P13xdxS4wlGAVIBUe5kpWPR/UNmFyYTU4FLLLMcCHrKh3uUJ1xUCoyNRngufVl8B/
	 VvJ+If3uwJfzB71IHKAUD238aAFRPRvh8Uc+23igy+x6rguGNyGfpt4cIiqz/Rwyvo
	 cdqrwQY0g6DFBeJuVmSoMlAdEBwMPPBXGOpAGZSZW9CAoGUbfGNuZuucH6JmAOaim5
	 xFvqb7c55zEtR86oxNiJVzFYZMGAV/FfX8LJYvMggb+uNfja4GUtBfiHvpAUH9XBdL
	 2bsLXJNCa0vHIZ7Ef6iRQ0I/ijEwT0vn62cEXBrYQpc4PQITTO9myhuqgpaT2/1QB8
	 suwu4x18IKU/A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] Docs/admin-guide/mm/damon/usage: place debugfs usage at the bottom
Date: Thu,  7 Sep 2023 02:29:20 +0000
Message-Id: <20230907022929.91361-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907022929.91361-1-sj@kernel.org>
References: <20230907022929.91361-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debugfs interface is deprecated.  Put it at the bottom of the document
so that readers have less chances to read it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 39 ++++++++++----------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 834eefe39650..bffe9dd9b0d6 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -495,6 +495,25 @@ Please note that it's highly recommended to use user space tools like `damo
 <https://github.com/awslabs/damo>`_ rather than manually reading and writing
 the files as above.  Above is only for an example.
 
+.. _tracepoint:
+
+Tracepoint for Monitoring Results
+=================================
+
+Users can get the monitoring results via the :ref:`tried_regions
+<sysfs_schemes_tried_regions>` or a tracepoint, ``damon:damon_aggregated``.
+While the tried regions directory is useful for getting a snapshot, the
+tracepoint is useful for getting a full record of the results.  While the
+monitoring is turned on, you could record the tracepoint events and show
+results using tracepoint supporting tools like ``perf``.  For example::
+
+    # echo on > monitor_on
+    # perf record -e damon:damon_aggregated &
+    # sleep 5
+    # kill 9 $(pidof perf)
+    # echo off > monitor_on
+    # perf script
+
 .. _debugfs_interface:
 
 debugfs Interface (DEPRECATED!)
@@ -790,23 +809,3 @@ directory by putting the name of the context to the ``rm_contexts`` file. ::
 
 Note that ``mk_contexts``, ``rm_contexts``, and ``monitor_on`` files are in the
 root directory only.
-
-
-.. _tracepoint:
-
-Tracepoint for Monitoring Results
-=================================
-
-Users can get the monitoring results via the :ref:`tried_regions
-<sysfs_schemes_tried_regions>` or a tracepoint, ``damon:damon_aggregated``.
-While the tried regions directory is useful for getting a snapshot, the
-tracepoint is useful for getting a full record of the results.  While the
-monitoring is turned on, you could record the tracepoint events and show
-results using tracepoint supporting tools like ``perf``.  For example::
-
-    # echo on > monitor_on
-    # perf record -e damon:damon_aggregated &
-    # sleep 5
-    # kill 9 $(pidof perf)
-    # echo off > monitor_on
-    # perf script
-- 
2.25.1

