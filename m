Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB9B2C0260;
	Fri, 10 Jul 2026 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691228; cv=none; b=kXohwaGO8M4Iml+MsXaI0/yocPDFLx+VPVL3kSI3q91V8Z5+0D7yM3U1MldYk2bcZmOaVnyvarpbfX47N8IZMbzdO9ZwSVb0eE0HJlj+CRhNRmLsCtKvGzolZ/AjO0/1sDiuLgWvzHVgVnhrx3lGNBKJtEudK6lXDn1ZHzYActM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691228; c=relaxed/simple;
	bh=TLs1sYIl6XDuSQdKZPBscGAxeps+1GHv3mJ2ZEZb9QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBX12UUgJSnpLozLlWTh93PEnCvPmmXxJxn9xzE3hwxLLXlHMuZ5TiB9JW81qNYFVzxZ5+DdMSWRZDy49uyhZQ0pa3IjwLbmhdTIwWkB2KOfB0z1pe7B6hBMrqMloLe88a9vIuNii7VmeQoD40B2wCQAQb1D/aLD4DPsXCzTrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cflqCq94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cflqCq94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0531F00A3F;
	Fri, 10 Jul 2026 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691226;
	bh=CCjb58wtAAk5F9PdDMQvKlFN0DE7q9fXquVywqvC5OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cflqCq94qaeo+eBNls5BN6m/yVTI/o80F8xOUkfExOo+m8uis54QwrR2grtiXeEwd
	 bQkMxHjPyxu2LQlfoX639W285vYWS7JV+KtDryEpY4KKApRxLOP7d6S5Ugxo205hbK
	 rvWJ/KS6EAYeHUwJUdGB2HwFM4g5hxvP2oYyFtR/Z/tb+8HKy3kDzIzzKnD0wtMAv0
	 nfV7rOzvl77CXlrY5PGlRUFsRytVFe9OfIxMUXsnbuFxDXBokVZUhcmmP63U/UW6sj
	 L+e40vhh4RA3XghTUMPIa33nK079yzqxgm7W01igZngZQV6tJ2RC0HQyoOG+nLTVIk
	 uKgpiEaFLg51g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH 18/19] Docs/admin-guide/mm/damon/usage: document weight sysfs file
Date: Fri, 10 Jul 2026 06:46:47 -0700
Message-ID: <20260710134651.18084-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for newly added probe weight file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 11 ++++++++---
 Documentation/mm/damon/design.rst            |  5 +++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index b2649ea011f93..da5f9afd08aef 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -73,9 +73,10 @@ comma (",").
     │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ │ :ref:`probes <damon_usage_sysfs_probes>`/nr_probes
-    │ │ │ │ │ │ │ 0/filters/nr_filters
-    │ │ │ │ │ │ │ │ 0/type,matching,allow,path
-    │ │ │ │ │ │ │ │ ...
+    │ │ │ │ │ │ │ 0/weight
+    │ │ │ │ │ │ │ │ filters/nr_filters
+    │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path
+    │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ ...
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
     │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target,obsolete_target
@@ -286,6 +287,10 @@ In each probe directory, one directory, ``filters`` exists.  The directory
 contains files for installing filters for the probe, that is used to determine
 the data attribute for the probe.
 
+Each probe directory also contains ``weight`` file.  Reading from and writing
+to the file gets and sets the :ref:`attributes-only monitoring
+<damon_design_attrs_only_monitoring>` weight for the attribute of the probe.
+
 In the beginning, ``filters`` directory has only one file, ``nr_filters``.
 Writing a number (``N``) to the file creates the number of child directories
 named ``0`` to ``N-1``.  Each directory represents each filter and works in a
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 6d79e7d69be84..aed6cb1cf4831 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -316,6 +316,8 @@ Another way to do this for higher accuracy is using :ref:`DAMOS filter
 information in page level.  But, because it is operated in page level, the
 overhead is proportional to the size of the memory.
 
+.. _damon_design_attrs_only_monitoring:
+
 Data Attributes-only Monitoring
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -336,6 +338,9 @@ automatically turned off.  The access counter (``nr_accesses``) will always be
 zero and not updated.  Hence the mode is called Data Attributes "only"
 monitoring.
 
+Refer to the :ref:`admin guide <damon_usage_sysfs_probes>` to know how users
+can use the mode.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3
