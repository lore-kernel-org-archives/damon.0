Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F53203A5;
	Mon,  8 Dec 2025 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175428; cv=none; b=d8k+1NeS6smCWlX5YQi6a/OpYyEvRgadixl0ljUIE84bR1WqFq1NI6dWzImItvvbr03O2lfG2uInOFRMn/W+LmK16v/F2ygtAhkppbJBSeCxoE6x3BYTYIlJ/GLnZ/cOajru/2hL9AxJHsA2WzfJkYAUi11ByDEhW3eNWYy7mpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175428; c=relaxed/simple;
	bh=MflKOa3kMKRZ5nzC/NEJe7cCxqAo99+D2pDObNtur7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMbquzFb/t6pN2CurQq5g00P2qgrxjnuMojbMWsexMZJystAu9Cwvi2+91U02cww19TTbqcP4y+iCASE2dm48/6WwmAWpySkrsNIhEIkC6llzLtfDO6PV96nQxhOamiIVQMefpOfrs6dghJki3urmgrPNuLdA81fZ7yfrGsobXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1Qe9zDT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1Qe9zDT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CA8C4CEF1;
	Mon,  8 Dec 2025 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175428;
	bh=MflKOa3kMKRZ5nzC/NEJe7cCxqAo99+D2pDObNtur7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q1Qe9zDTQODkH0a6LlN0LLWPF56eQxGRzEzYfMFdQWUh7byIaHBuE4XMnoV9G6fhB
	 +cME28lPAyXBwZhM6UAEy9chg2ADqQhP99ZJd8Sc6fRu+JXcwxMuTckTYvg5FLyWd+
	 TKnJDcfq9YyYXiHBWQLV8OldynKIBRUgSw9K3qS4gqksQKLkrLaB33oxuKcZ/GCpAs
	 NyAjkU5LejRDQlJvyIzJoIC/wp7yaH5ETycmwWyTKGm/z7W5BjBfyCg7kmNXxXEiqq
	 UQYeR029RoU2S9MXdtbV4X+g7EMdij9R0ZRE5ILqnE4hykX7RTMMIcOTPRSTn973ny
	 6UTvSMDPJgySQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
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
Subject: [RFC PATCH v3 25/37] Docs/admin-guide/mm/damon/usage: document sample filters dir
Date: Sun,  7 Dec 2025 22:29:29 -0800
Message-ID: <20251208062943.68824-26-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the added DAMON sysfs files for
installing and setting the access sample results filtering.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 25 +++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 897a89950351..365a4548a5ba 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -66,6 +66,8 @@ comma (",").
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
     │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
     │ │ │ │ │ │ sample/primitives/page_table,page_faults
+    │ │ │ │ │ │ sample/filters/nr_filters
+    │ │ │ │ │ │ │ 0/type,matching,allow,cpumask
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
     │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target,obsolete_target
@@ -233,7 +235,8 @@ writing to and rading from the files.
 For more details about the intervals and monitoring regions range, please refer
 to the Design document (:doc:`/mm/damon/design`).
 
-Under ``sample`` directory, a directory, ``primitives`` exists.
+Under ``sample`` directory, two directories, ``primitives`` and ``filters``
+exist.
 
 contexts/<N>/monitoring_attrs/sample/primitives/
 ------------------------------------------------
@@ -245,6 +248,26 @@ to these files, users can select whether to use the :ref:`page table accessed
 bit <damon_design_pte_accessed_bit_access_check>` and :ref:`page fault events
 <damon_design_page_fault_access_check>`, respectively.
 
+contexts/<N>/monitoring_attrs/sample/filters/
+---------------------------------------------
+
+This directory is for control of the :ref:`access sampling results filters
+<damon_design_sampling_results_filters>`.  At the beginning, this directory has
+only one file, ``nr_filters``.  Writing a positive integer ``<n>`` to the file
+generates directories of the number, named ``0`` to ``<n - 1>``.  The generated
+directories represent the sampling result filters to install to the DAMON
+context, in the order of the directory names.  Writing ``0`` to ``nr_filters``
+removes the directories.
+
+Under the individual filter directory, five files, ``type``, ``matching``,
+``allow``, and ``cpumask`` exist.  The first three files are same to the
+properties of the filter specified on the :ref:`design doc
+<damon_design_sampling_results_filters>`.
+
+Users can specify the cpumask of the filter by writing it to ``cpumask``.  The
+format for ``cpumask`` input is same to that for other cpumask inputs like that
+for cgroup cpusets.
+
 .. _damon_usage_sysfs_monitoring_intervals_goal:
 
 contexts/<N>/monitoring_attrs/intervals/intervals_goal/
-- 
2.47.3
