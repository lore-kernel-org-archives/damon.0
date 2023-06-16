Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448CA1DDE4
	for <damon@lists.linux.dev>; Fri, 16 Jun 2023 19:17:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20C1C433C0;
	Fri, 16 Jun 2023 19:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686943073;
	bh=wbuN7e/qxUK5fsj+ITNoDIFCanTeV9WF0LmR4CSecxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fdKFp883AX88acKBHDx48kRiVvHf4vAnGts4dIlATFRaFiA+jw/b7JTmej8wv2nhF
	 HNbZZS3cQgg3JeifwfCRmjCkyLbNgHokw7l14YBc1W2QjC0dhcZgUIKcKWwfXFcLvH
	 69ycl4hpVUSjoQDMDElEryIHjZISCmTUvke0cJVNE+ywuLfC5iH++zJ47DoSvBw4VQ
	 16Ur5CKlNnFjr9iJrW5tItSl+nLXpCJORhNcfdX40xdf5Yl7dIHLMsJMm3pvtc7qQB
	 kMK9J6K5Q7hD8z9RqnEbNYU7Y5q7LdpgIuLtJrmQ5SZEHD+yumUVhge1LlUB9anGxN
	 GW22IDZWslXvQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] Docs/admin-guide/mm/damon/usage: update the ways for getting monitoring results
Date: Fri, 16 Jun 2023 19:17:42 +0000
Message-Id: <20230616191742.87531-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616191742.87531-1-sj@kernel.org>
References: <20230616191742.87531-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recommended ways for getting DAMON monitoring results are using
tried_regions sysfs directory for partial snapshot of the results, and
DAMON tracepoint for full record of the results.  However, the
tried_regions sysfs directory usage has not sufficiently updated on some
sections of the DAMON usage document.  Update those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 9d3ebd70772f..2d495fa85a0e 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -19,10 +19,7 @@ DAMON provides below interfaces for different users.
   features by reading from and writing to special sysfs files.  Therefore,
   you can write and use your personalized DAMON sysfs wrapper programs that
   reads/writes the sysfs files instead of you.  The `DAMON user space tool
-  <https://github.com/awslabs/damo>`_ is one example of such programs.  Note
-  that this interface provides only simple :ref:`statistics <damos_stats>` for
-  the monitoring results.  For detailed monitoring results, DAMON provides a
-  :ref:`tracepoint <tracepoint>`.
+  <https://github.com/awslabs/damo>`_ is one example of such programs.
 - *debugfs interface. (DEPRECATED!)*
   :ref:`This <debugfs_interface>` is almost identical to :ref:`sysfs interface
   <sysfs_interface>`.  This is deprecated, so users should move to the
@@ -421,6 +418,11 @@ The directories will be removed when another special keyword,
 ``clear_schemes_tried_regions``, is written to the relevant
 ``kdamonds/<N>/state`` file.
 
+The expected usage of this directory is investigations of schemes' behaviors,
+and query-like efficient data access monitoring results retrievals.  For the
+latter use case, in particular, users can set the ``action`` as ``stat`` and
+set the ``access pattern`` as their interested pattern that they want to query.
+
 tried_regions/<N>/
 ------------------
 
@@ -771,10 +773,12 @@ root directory only.
 Tracepoint for Monitoring Results
 =================================
 
-DAMON provides the monitoring results via a tracepoint,
-``damon:damon_aggregated``.  While the monitoring is turned on, you could
-record the tracepoint events and show results using tracepoint supporting tools
-like ``perf``.  For example::
+Users can get the monitoring results via the :ref:`tried_regions
+<sysfs_schemes_tried_regions>` or a tracepoint, ``damon:damon_aggregated``.
+While the tried regions directory is useful for getting a snapshot, the
+tracepoint is useful for getting a full record of the results.  While the
+monitoring is turned on, you could record the tracepoint events and show
+results using tracepoint supporting tools like ``perf``.  For example::
 
     # echo on > monitor_on
     # perf record -e damon:damon_aggregated &
-- 
2.25.1

