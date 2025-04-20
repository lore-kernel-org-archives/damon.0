Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7F1D7E35;
	Sun, 20 Apr 2025 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745178042; cv=none; b=ewtqTkh7bL50loaXR1BcLMwsNkwD+YYpbJjWoptJRekFS+XUAXbbrURmRfyT7xZcCEuUGGz4dlK5DwbS+OOkzlC5Q5tPIIhcYyOXjQ7UetXWQhn3Sl5Nua8mz+UiutdZcKldyMcMmD9wqx0R62friOZnnMvUFlNlQIpNRPfv/IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745178042; c=relaxed/simple;
	bh=twOnYczGHwHXpz8e7UmyZwF+rnltKS4AmY2MSDBAKIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRV8MpAFHNgqs4InVEnsWHUJsSTCqnEBP0Mk2pcwz3xfugo4cv67VYm/dOF4DdodJejtFiHbvt1tyPdtJavBBlwtv//gKOJBIi5v4k7CowhAls6SZPm/fy4PYIhcdfuFBaM2OLpwXkeml+SLXiJL8BTtxVMbTke/wyBYVROoQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbG9g6fy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbG9g6fy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7163C4CEE2;
	Sun, 20 Apr 2025 19:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745178042;
	bh=twOnYczGHwHXpz8e7UmyZwF+rnltKS4AmY2MSDBAKIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JbG9g6fyfGlOu1n0zH18CPGPRRJxOc98hqCc2XeHvk/rMF49pRonYRVhwOntauLjD
	 cTQSL/GH3WrXOe5iMvd88dd4L5E/4/h55njdLfDSYyy42XdzY57Y8qNE+WOtht6Owa
	 Gjht85rtsueCy4P1z6Mw3cU2BMGdr0pUI2Lq7TmlWdcBkTtpcWXbpz9ktB6qwXXZg2
	 XMBHV2yM4SA1qhG4bba+7RmH1dKLcomVaOrphYv2gvgh/TPgSZdzrpvzmmCxljvhfb
	 Z5fhIcYqSTmGQZVsBmN/rWy9M7Xf8dSo6Ie8YXT4KsM1H8n0JyReDxlawwjJWBpVT7
	 5gGzM+O7/7EKA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/7] Docs/admin-guide/mm/damon/usage: document 'nid' file
Date: Sun, 20 Apr 2025 12:40:28 -0700
Message-Id: <20250420194030.75838-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250420194030.75838-1-sj@kernel.org>
References: <20250420194030.75838-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add description of 'nid' file, which is optionally used for specific
DAMOS quota goal metrics such as node_mem_{used,free}_bp on DAMON usage
document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index ced2013db3df..d960aba72b82 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -81,7 +81,7 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas>`/ms,bytes,reset_interval_ms,effective_bytes
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
     │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
-    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value
+    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
@@ -390,11 +390,11 @@ number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each goal and current achievement.
 Among the multiple feedback, the best one is used.
 
-Each goal directory contains three files, namely ``target_metric``,
-``target_value`` and ``current_value``.  Users can set and get the three
-parameters for the quota auto-tuning goals that specified on the :ref:`design
-doc <damon_design_damos_quotas_auto_tuning>` by writing to and reading from each
-of the files.  Note that users should further write
+Each goal directory contains four files, namely ``target_metric``,
+``target_value``, ``current_value`` and ``nid``.  Users can set and get the
+four parameters for the quota auto-tuning goals that specified on the
+:ref:`design doc <damon_design_damos_quotas_auto_tuning>` by writing to and
+reading from each of the files.  Note that users should further write
 ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
 directory <sysfs_kdamond>` to pass the feedback to DAMON.
 
-- 
2.39.5
