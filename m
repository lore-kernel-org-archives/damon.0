Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B031ED88;
	Mon,  8 Dec 2025 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175426; cv=none; b=sj3EJzxjFtDVrBRyc0pBpcYZ7cWn+vfnQo/EMBCCBxIE9pzRmuUJ1c/s+ggPmonQZp6kM3nAsHY3DC7Ihm0wFkQbbmOLtpiVL3e8IyCnGozLGAA6kYpmapAx1iOe0H3+hUahYp/p8gb7z4HAePltqZ+aMbFX00ZVZXNf4IiSMC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175426; c=relaxed/simple;
	bh=Z3BU9CS2/j7n/yC26uZia3+mZzwDzeK0PuZdStu70eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxhqeHV5Lqt0APETJVCaTCv3JSA8DIjggSrVV41qSyWyjXaYIWnipnZMojT/0PPWtCukdMR/yD226M7UbrQeV9ku57OEnsjFgYuFqNXlxR6Xbe6y4i344saxd/ps+sgZWh2WXGu28TbW9CeSL3jW4fyZV20UM/5N5jEWpvDkQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGROWyCH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGROWyCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6D0C113D0;
	Mon,  8 Dec 2025 06:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175425;
	bh=Z3BU9CS2/j7n/yC26uZia3+mZzwDzeK0PuZdStu70eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGROWyCHMiZMIYeqcr9kV7I8TYwKqYB9dRXryFVgu9qrdUCUTVwppf6+w9tTDAObP
	 eXbFXGQWcLfv6mSZ1Kk4gbN2jUTUBgrh4UsshTLQl0M+QNcp8Va6gBCWilhMd7FMaZ
	 4DUcJ9l49nwkMViyr0l9E75gM7sUyXIDQ523NrpDHVq09jSfynaZnvsyNP7tyDC7sp
	 OGof0rw1sVdJphQvqXV1bdF3WzW6jSzjaq5FeBZkl+tTFBq/iAzb4eTWgUtxvglXKU
	 3x/828CVdPgula6Cy67DeV3ihTijcTjCP1s2IJVmDO/LABJ+vgQ0meEHAxSsg1BHEY
	 iEoXYUw9mJvpg==
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
Subject: [RFC PATCH v3 24/37] Docs/mm/damon/design: document sample filters
Date: Sun,  7 Dec 2025 22:29:28 -0800
Message-ID: <20251208062943.68824-25-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the access sample results filtering.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 42 +++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a21973b33bc3..9a4679de437f 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -146,12 +146,17 @@ do the access check using monitoring-purpose page fault events in a way similar
 to NUMA balancing hinting faults.  When it is being used, ``paddr`` installs
 the page protection in a way similar to that of NUMA balancing hinting faults.
 Then the page fault handler reports the faults happend by the installed page
-protection to DAMON core layer.
+protection to DAMON core layer.  Compared to the accessed-bit based one, this
+approach gives more information to DAMON, such as the access-generated
+CPU.
 
 ``paddr`` uses :ref:`accessed-bit based check
 <damon_design_pte_accessed_bit_access_check>` by default, and users can change
 it to use this page faults based one, using :ref:`access sampling primitives
-selection <damon_design_sampling_primitives_selection>`.
+selection <damon_design_sampling_primitives_selection>`.  Also, the addtional
+information can be used for doing monitoring of only specific type accesses,
+using :ref:`access sampling results filters
+<damon_design_sampling_results_filters>`.
 
 .. _damon_design_addr_unit:
 
@@ -277,6 +282,39 @@ support from the operations set implementation for virtual address spaces
 
 At the moment, only exclusive use of the primitives is supported.
 
+.. _damon_design_sampling_results_filters:
+
+Access Sampling Results Filter
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Depending on the access sampling primitives that used, the sampling results
+could inform more than whether an access is made, such as the CPU or the thread
+the sampled access was made from, and whether the sampled access was for
+writing or reading.  By filtering the results based on the additional
+information, DAMON can perform for more detailed access monitoring, such as
+per-CPUs/threads or read/write-only monitoring.
+
+For such special types of monitoring, DAMON provides a feature called "sampling
+results filter".  The feature allows users to set an arbitrary number of
+filters for the sampling results.  Each of the filters specifies
+
+- a type of the additional information (``type``),
+- whether it is for the sampling results of the type or all except the type
+  (``matching``), and
+- whether it is to allow (include) or reject (exclude) consuming of the type of
+  sampling results.
+
+Each filter is applied in the order of the installation.  Only sampling results
+that allowed by previous filters are continue to be evaluated by the next
+filters.  If a sampling result is decided to be rejected by a filter, it is
+just discarded and no later filter is applied.
+
+Below ``type`` of access sampling results filter are currently supported.
+
+- cpumask
+    - Whether the sampled access was generated by a cpu that included in a
+      given cpumask.
+
 
 .. _damon_design_age_tracking:
 
-- 
2.47.3
