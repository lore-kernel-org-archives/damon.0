Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF82C028B;
	Sun, 15 Mar 2026 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773592195; cv=none; b=XdoVrnClvC6bnhBXzww4jjS3TZVYKLzRKfIOGkbZ4zRnagJ0xrEEuXPg/AVPbsuVGGSq5uqCUddLzKWBalnGo5hUkwdkGnu3F2ESDxSjYVvM5FAWEW/ynmM/DM3EIK+xtvelT2zHXaDftkZ231jXqm5GIb8iSRgYibtUkYLs9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773592195; c=relaxed/simple;
	bh=He08VfqZZvy0NJ509H07nj7EMEVUJY5kq1pTp0TKxWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZWdcDWE+f0I1zaqPJJMJQkgQq77EwuHgo/RoMVnIcmpPzBbyDkFqV6WUM7n5RVrMLCy0nmfPo1/WNDTwT8cDWyaao1UgYX8e9g93qC/cqfBhvqGXsYOFwjXohwQoqnpMUsMdEKzWNt+bpC+K/45q2lkrXQV8LY6egNtMzHBGnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKnWgzUV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKnWgzUV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E74C4CEF7;
	Sun, 15 Mar 2026 16:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773592195;
	bh=He08VfqZZvy0NJ509H07nj7EMEVUJY5kq1pTp0TKxWA=;
	h=From:To:Cc:Subject:Date:From;
	b=aKnWgzUV17mDG+vFpiOFZ65eycBdJF5NNE+shq3yAFhbHt8ZEjn7kjA0Px4mpBDtg
	 0qjfRv6u93OiWE3Zoi/TF6/q4VrccEp/6sWNKFqx4+mXvSp9K4h6OuOWgXm2iEmhCr
	 G2s17qR0f40sP0541owodaqkDPxKVVXKjziWwTM1KKaPQ2Y+gYb9jlfT5/Z1y4ot7m
	 ZsgBv6SKSQhAkTjgvgdH+atfi59phLmudaP+1nFuXGI8W9g6nfv6pUVMkeGUpBsR4w
	 AlqGwhiFrQEFrZio1LKNvkaWeLtTKIzr3NLJbsDkK1YLg/12/6IkWWIutuN6eNKgF6
	 EKRAmXmDhgmZg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] Docs/mm/damon: document exclusivity of special-purpose modules
Date: Sun, 15 Mar 2026 09:29:44 -0700
Message-ID: <20260315162945.80994-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

Add a section in design.rst to explain that DAMON special-purpose kernel
modules (LRU_SORT, RECLAIM, STAT) run in an exclusive manner and return
-EBUSY if another is already running.

Update lru_sort.rst, reclaim.rst and stat.rst by adding cross-references
to this exclusivity rule at the end of their respective Example
sections.

This change is motivated from another discussion [1].

[1] https://lore.kernel.org/damon/20260314002119.79742-1-sj@kernel.org/T/#t


Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Change from v1
(https://lore.kernel.org/20260314092145.7496-1-aethernet65535@gmail.com)
- Drop contents directive fix
- Reword description

 Documentation/admin-guide/mm/damon/lru_sort.rst | 5 +++++
 Documentation/admin-guide/mm/damon/reclaim.rst  | 5 +++++
 Documentation/admin-guide/mm/damon/stat.rst     | 5 +++++
 Documentation/mm/damon/design.rst               | 4 ++++
 4 files changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 73980bacc3a02..56690646cf398 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -351,3 +351,8 @@ the LRU-list based page granularity reclamation. ::
     # echo 400 > wmarks_mid
     # echo 200 > wmarks_low
     # echo Y > enabled
+
+Note that this module (damon_lru_sort) cannot run simultaneously with other
+DAMON-based special-purpose modules.  Refer to :ref:`DAMON design special
+purpose modules exclusivity <damon_design_special_purpose_modules_exclusivity>`
+for more details.
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 552a7786b0829..6f580f637134a 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -318,6 +318,11 @@ granularity reclamation. ::
     # echo 200 > wmarks_low
     # echo Y > enabled
 
+Note that this module (damon_reclaim) cannot run simultaneously with other
+DAMON-based special-purpose modules.  Refer to :ref:`DAMON design special
+purpose modules exclusivity <damon_design_special_purpose_modules_exclusivity>`
+for more details.
+
 .. [1] https://research.google/pubs/pub48551/
 .. [2] https://lwn.net/Articles/787611/
 .. [3] Documentation/mm/free_page_reporting.rst
diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
index e5a5a2c4f803a..c4b14daeb2dd6 100644
--- a/Documentation/admin-guide/mm/damon/stat.rst
+++ b/Documentation/admin-guide/mm/damon/stat.rst
@@ -45,6 +45,11 @@ You can enable DAMON_STAT by setting the value of this parameter as ``Y``.
 Setting it as ``N`` disables DAMON_STAT.  The default value is set by
 ``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` build config option.
 
+Note that this module (damon_stat) cannot run simultaneously with other
+DAMON-based special-purpose modules.  Refer to :ref:`DAMON design special
+purpose modules exclusivity <damon_design_special_purpose_modules_exclusivity>`
+for more details.
+
 .. _damon_stat_aggr_interval_us:
 
 aggr_interval_us
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 29fff20b3c2a9..dc37402c0fee9 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -853,6 +853,10 @@ more detail, please read the usage documents for those
 (:doc:`/admin-guide/mm/damon/stat`, :doc:`/admin-guide/mm/damon/reclaim` and
 :doc:`/admin-guide/mm/damon/lru_sort`).
 
+.. _damon_design_special_purpose_modules_exclusivity:
+
+Note that these modules currently run in an exclusive manner.  If one of those
+is already running, others will return ``-EBUSY`` upon start requests.
 
 Sample DAMON Modules
 --------------------

base-commit: 1e6fb24fdfceeb8dfa1a97a0270e4aeffa0a6d6d
-- 
2.47.3
