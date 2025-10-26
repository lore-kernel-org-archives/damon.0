Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C792F12DE;
	Sun, 26 Oct 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761502946; cv=none; b=a5YcXVUrcglgKr+xV+Eavin1Q4Wi9fommoBdQ3Mcas++cT4f3sca0Yr03MYpnEP4BmXPCpL5PZLUFbvnUBcUslUtqx3A/5wzMRUdzVBYXPFVyVWJBvU7a6ZFGWmmn6NaRVVB2tZgwEroXpMqMiOCc+PJkIsQlkLQla7Fgm3iiqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761502946; c=relaxed/simple;
	bh=HTEUhayo10VIIHTrpNQMg1meUMUdoEd6UZy7MJUO3rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXAkk9aAQ2em2rJjYkGGgvqAb3a4zf5iVj/9rj8XBWq/zfOnNcXCXoTPmJTsSIOje3X/egz4tTWWXuweDCiOLwr1Y5W4ufoM/SEKYe6bcqUXeRVke/XZyGtPMd6q/WndtV3ZZMMNOvTwVV5Va1T6ILhBWgZbig0V+4vQPLOdY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8HhEKac; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8HhEKac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60492C4CEE7;
	Sun, 26 Oct 2025 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761502945;
	bh=HTEUhayo10VIIHTrpNQMg1meUMUdoEd6UZy7MJUO3rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a8HhEKacHBy4+fTLed4bI/HXIzp7f0fyoBsAaukKkycunU/gHfrRznT04l5Hpi6XS
	 QX+yv9feyV4/2phxDVXL10MnhFjxx3pKGIrkyHJQtabJihUZh/XefOqpuBm9A8qowW
	 xjJz2FeVtH1Wyvt9RcslPpeX8osSGVQ1HybXCNpwN3s1z4GcByZrb3Ls7lV+Pfj8C2
	 ccYDEjAXXn8c+6zchlv/j26VcUS2ul230UE/6ve4dm63r+KmxbFvgOirEuG4nzIVlY
	 +YRAHmcrGlWj7wl1ixuTisJQ4OPWlJKQWZB/EV9UJ0n+MZdKwHoJhdziAESyqM2Xiw
	 iisJsBClf9h5A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
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
Subject: [PATCH 7/8] Docs/admin-guide/mm/damon/stat: document aggr_interval_us parameter
Date: Sun, 26 Oct 2025 11:22:12 -0700
Message-ID: <20251026182216.118200-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026182216.118200-1-sj@kernel.org>
References: <20251026182216.118200-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cc7ceb1d14b0 ("mm/damon/stat: expose the current tuned
aggregation interval"), has introduced 'aggr_interval_us' parameter for
DAMON_STAT.  But the new parameter is not yet documented.  Document it
on the usage document for the module.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/stat.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
index 20f540a9d3d2..754f98d47617 100644
--- a/Documentation/admin-guide/mm/damon/stat.rst
+++ b/Documentation/admin-guide/mm/damon/stat.rst
@@ -10,6 +10,8 @@ on the system's entire physical memory using DAMON, and provides simplified
 access monitoring results statistics, namely idle time percentiles and
 estimated memory bandwidth.
 
+.. _damon_stat_monitoring_accuracy_overhead:
+
 Monitoring Accuracy and Overhead
 ================================
 
@@ -19,7 +21,9 @@ overhead minimum.  It auto-tunes the intervals aiming 4 % of observable access
 events to be captured in each snapshot, while limiting the resulting sampling
 interval to be 5 milliseconds in minimum and 10 seconds in maximum.  On a few
 production server systems, it resulted in consuming only 0.x % single CPU time,
-while capturing reasonable quality of access patterns.
+while capturing reasonable quality of access patterns.  The tuning-resulting
+intervals can be retrieved via ``aggr_interval_us`` :ref:`parameter
+<damon_stat_aggr_interval_us>`.
 
 Interface: Module Parameters
 ============================
@@ -41,6 +45,18 @@ You can enable DAMON_STAT by setting the value of this parameter as ``Y``.
 Setting it as ``N`` disables DAMON_STAT.  The default value is set by
 ``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` build config option.
 
+.. _damon_stat_aggr_interval_us:
+
+aggr_interval_us
+----------------
+
+Auto-tuned aggregation time interval in microseconds.
+
+Users can read the aggregation interval of DAMON that is being used by the
+DAMON instance for DAMON_STAT.  It is :ref:`auto-tuned
+<damon_stat_monitoring_accuracy_overhead>` and therefore the value is
+dynamically changed.
+
 estimated_memory_bandwidth
 --------------------------
 
-- 
2.47.3
