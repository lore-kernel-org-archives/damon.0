Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311A28EA5A;
	Thu, 19 Jun 2025 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370437; cv=none; b=r0s1Fw7yj2s2j3qYvQhEZZBYK52s/Bm8o1kIqNOfPzgUMO+OAH1UA/f4K5uIKhS31Os85Q0M54nEQktDli6xCqEuC1dja5zyKH1lGlt56VH0Abk1e0joEV+5KokFjNy2Gc0+fPwbL0oDJ76kk8uU+JlQpxsYoctxJL09mBD9ADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370437; c=relaxed/simple;
	bh=wqH48E+LGip6Lq2rL7wSlJRXxht7rFrTFl8NcghwPtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ap/WHoj5wI5h1wXziYr/V+G3JXaq4pOTMoAKD5ZTer+P58ruf/8RQ2pp9v8GtzAJZGpXD9PgyD9skID8924MG4/4t2FSBrQEQHG8pZsvIjMRK+cFs6sXqw/kOdLkXiXaEPzZqQcTKz57fQSrLAyKpyuG0hLOih3UDo/5dj5A2uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBBRVztj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBBRVztj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A4EC4CEEE;
	Thu, 19 Jun 2025 22:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370436;
	bh=wqH48E+LGip6Lq2rL7wSlJRXxht7rFrTFl8NcghwPtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LBBRVztjNgZs3K22XZVoEGcLZ2UzS917Lt8kDKWDbhb3qm5W9h2U7YcckfF5stkoV
	 3SqNvdfqWGIStxzvMslk5141R/d6pPDMplZxHVHcwkmw0eUJi9jCaJAYeTssMSbOxI
	 lM06ohGtS2ojM9ANfmoftpSI/REBWavjEH0dSH2mznX8XKMyWx1NRPu8PAzD1TWBKn
	 5b4MwFIfnS1mPZpnTiji+2xkQNYamkx4Uubw9sHvXtJ6r8q25zGuW1qxQroYc6FKy+
	 qsuXp6OaopSqpgEyBdWapHRkrnf1hkVRJV3D9FpZ9lqI1Nh1REau9K3UikMO4akpQY
	 b2OVMP+TIBL8g==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/11] Docs/admin-guide/mm/damon/usage: document DAMOS quota goal path file
Date: Thu, 19 Jun 2025 15:00:19 -0700
Message-Id: <20250619220023.24023-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619220023.24023-1-sj@kernel.org>
References: <20250619220023.24023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d960aba72b82..2f603977fa88 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -81,7 +81,7 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas>`/ms,bytes,reset_interval_ms,effective_bytes
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
     │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
-    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid
+    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid,path
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
@@ -390,9 +390,9 @@ number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each goal and current achievement.
 Among the multiple feedback, the best one is used.
 
-Each goal directory contains four files, namely ``target_metric``,
-``target_value``, ``current_value`` and ``nid``.  Users can set and get the
-four parameters for the quota auto-tuning goals that specified on the
+Each goal directory contains five files, namely ``target_metric``,
+``target_value``, ``current_value`` ``nid`` and ``path``.  Users can set and
+get the five parameters for the quota auto-tuning goals that specified on the
 :ref:`design doc <damon_design_damos_quotas_auto_tuning>` by writing to and
 reading from each of the files.  Note that users should further write
 ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
-- 
2.39.5
