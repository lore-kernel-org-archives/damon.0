Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DFF37F8D4;
	Wed,  4 Mar 2026 04:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599289; cv=none; b=RkberIrtJzKISJK3arPCchBdby67UTDiq82t04iOYaKmRQPOXp1A+zG1gq/RxbcWVXc41uVUPCr5pyKBSzaUnn07r1fR62Y9Nvhes06TFdKJcXpclPC+5zrRVnxc/NuB+M4InkSgP9c+kdyi+42WKeLiMS4fN1NGNq0WIBr5OhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599289; c=relaxed/simple;
	bh=8g5RM84PzzTOH9XhkrAPhPyfvWGkJhpn6rsV5ukGTjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwq+4sTtf8vXC0UGPWtuO2pxOq05bCqCLkGTzcTAPSrnMpaBNUq1GXF7EPBBy0uiuZCKfrqlm0gYp3Wwfh0nAEIugPRQnId+9qnGrBED5Rt+lTdqOqwadtXESHqkSfbwtY2pjanltnoste82iyVsM5JSeRnpTidxgw2DfPGZI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mnx/ae8y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mnx/ae8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D87DC2BCB0;
	Wed,  4 Mar 2026 04:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772599289;
	bh=8g5RM84PzzTOH9XhkrAPhPyfvWGkJhpn6rsV5ukGTjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mnx/ae8y7orLmFJZHFXSsQfrn7bza4w09l7fsKmvHiaNUshtMFj6Os3q0otSdDFX+
	 U/bZQpkt7velykvuZOTLKV40p0S/b6/t99O/nfrcU72o2G6oWQpK09W1PIy0xjLULc
	 8SIQKD+x5zKXo3samKrGB0lb1e3mhx6ylYRL7kQnK9iezNXgtT2OKntGmdM1Dh7+cd
	 +n39fBAnoT+Q8Oe/htB5t+MF9o2dRomk6xNk01gQk4LcZ8JZ5ZfaQdZcIDz38dN/yH
	 Qzra+z04nJcXBz/yAfG6J8dFxGFK/YIolLjiDRyB7zhv7mDo7TijM1AQoROTuRLsP6
	 X5l3cYn7g+xPg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 06/10] Docs/admin-guide/mm/damon/usage: document goal_tuner sysfs file
Date: Tue,  3 Mar 2026 20:41:15 -0800
Message-ID: <20260304044122.79394-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-1-sj@kernel.org>
References: <20260304044122.79394-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the DAMON usage document for the new sysfs file for the goal
based quota auto-tuning algorithm selection.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index b0f3969b6b3b1..534e1199cf091 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -83,7 +83,7 @@ comma (",").
     │ │ │ │ │ │ │ │ sz/min,max
     │ │ │ │ │ │ │ │ nr_accesses/min,max
     │ │ │ │ │ │ │ │ age/min,max
-    │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas>`/ms,bytes,reset_interval_ms,effective_bytes
+    │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas>`/ms,bytes,reset_interval_ms,effective_bytes,goal_tuner
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
     │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
     │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid,path
@@ -377,9 +377,9 @@ schemes/<N>/quotas/
 The directory for the :ref:`quotas <damon_design_damos_quotas>` of the given
 DAMON-based operation scheme.
 
-Under ``quotas`` directory, four files (``ms``, ``bytes``,
-``reset_interval_ms``, ``effective_bytes``) and two directories (``weights`` and
-``goals``) exist.
+Under ``quotas`` directory, five files (``ms``, ``bytes``,
+``reset_interval_ms``, ``effective_bytes`` and ``goal_tuner``) and two
+directories (``weights`` and ``goals``) exist.
 
 You can set the ``time quota`` in milliseconds, ``size quota`` in bytes, and
 ``reset interval`` in milliseconds by writing the values to the three files,
@@ -390,6 +390,14 @@ apply the action to only up to ``bytes`` bytes of memory regions within the
 quota limits unless at least one :ref:`goal <sysfs_schemes_quota_goals>` is
 set.
 
+You can set the goal-based effective quota auto-tuning algorithm to use, by
+writing the algorithm name to ``goal_tuner`` file.  Reading the file returns
+the currently selected tuner algorithm.  Refer to the design documentation of
+:ref:`automatic quota tuning goals <damon_design_damos_quotas_auto_tuning>` for
+the background design of the feature and the name of the selectable algorithms.
+Refer to :ref:`goals directory <sysfs_schemes_quota_goals>` for the goals
+setup.
+
 The time quota is internally transformed to a size quota.  Between the
 transformed size quota and user-specified size quota, smaller one is applied.
 Based on the user-specified :ref:`goal <sysfs_schemes_quota_goals>`, the
-- 
2.47.3
