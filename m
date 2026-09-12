Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4363C9EDD;
	Sat, 12 Sep 2026 20:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243707; cv=none; b=MWMkbhdyyiBdktIZJ3VBJ7BLFl71BEOQvXPs/m60nFOGa4wOZ3HgAi1hSGSzFGvu95sG1xCoyc272xbxMg9gmtVFiwP6h8WJamr7bGa/dbTnWBhe65Ci2a37nexI3uZVy03aj39XkSqcI0nvM7tLe3VO6q5sGrEU2I4/bYnyhfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243707; c=relaxed/simple;
	bh=igpDaY7ogL2MgVVbjENuSqoGZ/pGU0a0jlFbiEYZX+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz2OLe4l/924lv/smqrsq+2nqc2KhU9l9+HG9dT26y6gZ7cWUFHMZV5UvyJ5AfSrZat4t3N6AxxHOHcjsXRuqizEOz1NdXkUCzr1fknrEYpl0kWXuhiPOB7bemlVRCEgLeZmWD6E17ZGz57zp0U9CV5l1JhwN54t8PSoYyGgR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAzxcZNz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAzxcZNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D01E1F00899;
	Sat, 12 Sep 2026 20:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243705;
	bh=qMM9iy6IrAL3WXWLU7jycgpdPbxivoB9SIapWH0R9Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LAzxcZNzJcohmCNK4xFBtqQSjGg7ODGYWfX3bVmzoMoQOH9cpF8zoL5WaLrJuY8y8
	 2hi/QB6NaEPk5644YSxYUoRJyy36J7+m6ZQLlJqAo9opluc+/hphS8gHAnYUR79TF+
	 838IYEgaTYUFxXSHRPb5W+0f+kYnf4w5ddg4Ltuz/hqpIQCjn1YCvo2cYnXhLB5Xrb
	 lahBliozSjDX1ltQwc07yPC+hq3loR6CEKvFKlCHvacIP/ET8y2QLCgskroSof8bq+
	 JpeeATQkg99Pn08yG384ij2/tNqTVIAz4tsVP4eFx6bXOvxlR2PfN22sEQMm4gFvgG
	 VRy10MZJogqBA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 9/9] Docs/mm/damon/design: clarify bp is basis point
Date: Sat, 12 Sep 2026 13:08:10 -0700
Message-ID: <20260912200814.145612-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912200814.145612-1-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON design document uses "bp" for "basis point" in multiple places.
Because it is not clearly mentioned, it is difficult to understand what
"bp" stands for.  Add the clarification.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/107dc6ba-697e-4b25-ba3e-8ce2499cac9a@infradead.org
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 0a86792f90a18..e82390e77a70a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -445,7 +445,7 @@ users to set the aimed amount of access events to observe via DAMON within
 given time interval.  The target can be specified by the user as a ratio of
 DAMON-observed access events to the theoretical maximum amount of the events
 (``access_bp``) that measured within a given number of aggregations
-(``aggrs``).
+(``aggrs``).  The ratio is in basis point (bp or 1/10,000).
 
 The DAMON-observed access events are calculated in byte granularity based on
 DAMON :ref:`region assumption <damon_design_region_based_sampling>`.  For
@@ -717,7 +717,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
   in microseconds that measured from last quota reset to next quota reset.
   DAMOS does the measurement on its own, so only ``target_value`` need to be
   set by users at the initial time.  In other words, DAMOS does self-feedback.
-- ``node_mem_used_bp``: Specific NUMA node's used memory ratio in bp (1/10,000).
+- ``node_mem_used_bp``: Specific NUMA node's used memory ratio in basis point
+  (bp or 1/10,000).
 - ``node_mem_free_bp``: Specific NUMA node's free memory ratio in bp (1/10,000).
 - ``node_memcg_used_bp``: Specific cgroup's node used memory ratio for a
   specific NUMA node, in bp (1/10,000).
-- 
2.47.3
