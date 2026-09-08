Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E7549387;
	Tue,  8 Sep 2026 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875597; cv=none; b=omzGysAPY5tvFyZ12Um2xI1183gxx8vPaDZiET+USbjhpfiBS22J0A4A2b6MwRqbpAq6+6zWYH4pGnoqAZneaNw1a68B0ElgCv+RHYDv7oZjul0oGdjV/UO9TvleJ9zCwyfKC6qDxkRmUhDJNRJukCP/87zTpUvSp9kr8zilhxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875597; c=relaxed/simple;
	bh=bI1PpBI0cFvGVH5VMmLCiJDqLF3ehdwSKW2zmQUDQbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z2qK0e0tZDnsJoTrEjMw6EQEAtNXvslwt43CjH3qadY4eHPWSwWn2FBs7gyFXbdpNyFN+CsoCkfJJUVyC++i9oEXDbg1xh299xfznXoYDkd5m8QRmFwkd9YHSZ7bX9iBIpYc38kLnPj56USiql1+YLnXOXvsA9ZcsSIab782vhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645831F00A3A;
	Tue,  8 Sep 2026 13:53:05 +0000 (UTC)
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] Docs/mm/damon/design: fix broken :ref: usage and a typo
Date: Tue,  8 Sep 2026 06:52:55 -0700
Message-ID: <20260908135257.97523-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

The Statistics section refers readers to the DAMON sysfs interface
documentation for how to read the statistics, using a ':ref:' role.
However, the role name has a superfluous 's' appended (':ref:s' instead of
':ref:').  Moreover, its target label 'sysfs_stats' does not exist; the
correct label is 'sysfs_schemes_stats'.  Fix both.

Also fix a typo, 'frequenceis' -> 'frequencies', in the Adaptive Regions
Adjustment section.

Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260902124550.31175-1-zenghui.yu@linux.dev
- Collec R-b: from SJ.
- Rebase to latest mm-new.

 Documentation/mm/damon/design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index d036340dae8af..aac84de261aa8 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -249,7 +249,7 @@ For each ``aggregation interval``, it compares the access frequencies
 sum of the two regions' sizes is smaller than the size of total regions divided
 by the ``minimum number of regions``, DAMON merges the two regions.  If the
 resulting number of total regions is still higher than ``maximum number of
-regions``, it repeats the merging with increasing access frequenceis difference
+regions``, it repeats the merging with increasing access frequencies difference
 threshold until the upper-limit of the number of regions is met, or the
 threshold becomes higher than possible maximum value (``aggregation interval``
 divided by ``sampling interval``).   Then, after it reports and clears the
@@ -889,7 +889,7 @@ the scheme is deactivated.  Note that, unlike watermarks, even if a scheme's
 ``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.
 
 To know how user-space can read the stats via :ref:`DAMON sysfs interface
-<sysfs_interface>`, refer to :ref:s`stats <sysfs_stats>` part of the
+<sysfs_interface>`, refer to :ref:`stats <sysfs_schemes_stats>` part of the
 documentation.
 
 Regions Walking

base-commit: 6ec15610f2de4a64c8cada08cb3dda0b6388b3ed
-- 
2.47.3
