Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487233A873B;
	Sat,  4 Apr 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320796; cv=none; b=SATQd6wjs8w2eGphGNSdHElSbvvzYagco/eupM/W75U6ygaRGC58gMoz5oj3EoKOt4ht6YJWXqE+e9j5Z+DpdhgnoHDh0r14TeWFKLtwRVCJL+2THGan14VryFhwYYe1E/EMKZr0aD7Z3OuKAFQmKXmtbG/BisnAN3JfLT5h+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320796; c=relaxed/simple;
	bh=mzfOdcEC1x6C2aREi8i81jeKTNH0+1J8f/eMCT7uMu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cd8zLJxshOsSABknBnYh2w7gfg7XMj0SiNUjFt6j/Pdd7WeAl+J2eMs7/0SXyyluPcuVEIPnyg3Q5lg1CT/kSHJpngE6mkVPPWbjlXLNZFNOavgyG+lJxuMP4hTTfTXNiaqFUGyd8YloCqpqS1tgC2K3IctGfAcfOEqVXtekH/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTLsNDJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTLsNDJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643DCC2BCB2;
	Sat,  4 Apr 2026 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775320795;
	bh=mzfOdcEC1x6C2aREi8i81jeKTNH0+1J8f/eMCT7uMu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTLsNDJWR1+Z9PlJJAefLfu7eEwygzdlpvNGi9eVF50HYLYXBl/w462ko3Ogt/05f
	 hLufLGLFmZlyuddDwx4bi3SAI1zgW49vZiyAwlZgu0hfkMwC/GM1DSlc/Y7HqTlwuI
	 boUm5rjyP79IqfJRJJom62sInF4y5biBpfQUmjrsvYFblADelS9Yifg0VCCHpGK7Vj
	 G2OJ+Ryg7mrDF/9WTtqe1M9H9j/w6tBjbzVw02efdG86kqvVmJQ/24ROhMrKt7kXcB
	 ImUMd723CDpmnStlcyG8XEE6ruBaWGz2qbg1un7idTmPQbm0Ho7CQeoWQbzWh7Cb2Y
	 jJFiSaEUe+5tA==
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
Subject: [RFC PATCH 4/9] Docs/admin-guide/mm/damon/usage: document fail_charge_{num,denom} files
Date: Sat,  4 Apr 2026 09:39:34 -0700
Message-ID: <20260404163943.89278-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-1-sj@kernel.org>
References: <20260404163943.89278-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the DAMOS action failed regions quota
charge ratio control sysfs files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index bfdb717441f05..ffb32bdbe34ff 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -84,7 +84,9 @@ comma (",").
     │ │ │ │ │ │ │ │ sz/min,max
     │ │ │ │ │ │ │ │ nr_accesses/min,max
     │ │ │ │ │ │ │ │ age/min,max
-    │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas>`/ms,bytes,reset_interval_ms,effective_bytes,goal_tuner
+    │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas>`/ms,bytes,reset_interval_ms,
+    │ │ │ │ │ │ │     effective_bytes,goal_tuner,
+    │ │ │ │ │ │ │     fail_charge_num,fail_charge_denom
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
     │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
     │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid,path
@@ -381,9 +383,10 @@ schemes/<N>/quotas/
 The directory for the :ref:`quotas <damon_design_damos_quotas>` of the given
 DAMON-based operation scheme.
 
-Under ``quotas`` directory, five files (``ms``, ``bytes``,
-``reset_interval_ms``, ``effective_bytes`` and ``goal_tuner``) and two
-directories (``weights`` and ``goals``) exist.
+Under ``quotas`` directory, seven files (``ms``, ``bytes``,
+``reset_interval_ms``, ``effective_bytes``, ``goal_tuner``, ``fail_charge_num``
+and ``fail_charge_denom``) and two directories (``weights`` and ``goals``)
+exist.
 
 You can set the ``time quota`` in milliseconds, ``size quota`` in bytes, and
 ``reset interval`` in milliseconds by writing the values to the three files,
@@ -402,6 +405,13 @@ the background design of the feature and the name of the selectable algorithms.
 Refer to :ref:`goals directory <sysfs_schemes_quota_goals>` for the goals
 setup.
 
+You can set the action-failed memory quota charging ratio by writing the
+numerator and the denominator for the ratio to ``fail_charge_num`` and
+`fail_charge_denom`` files, respectively.  Reading those file will return the
+current set values.  Refer to :ref:`design
+<damon_design_damos_quotas_failed_memory_charging_ratio>` for more details of
+the ratio feature.
+
 The time quota is internally transformed to a size quota.  Between the
 transformed size quota and user-specified size quota, smaller one is applied.
 Based on the user-specified :ref:`goal <sysfs_schemes_quota_goals>`, the
-- 
2.47.3
