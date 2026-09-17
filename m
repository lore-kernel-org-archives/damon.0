Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5843C3F51;
	Thu, 17 Sep 2026 04:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617951; cv=none; b=GpkOdYrPf22CmXaS6w5CELecXFhsu5QzU0+NOwfcleCiojv4ffVkXjeakkK595w7J37R3EeIKGosL8E3bsZglygQnVv2Vw5SKiClmQFmnDGJWJDk5ND62v2KruLPlZZFpg65S1NJvVzl1a1ee+6uehFYDzEunG+cUjf7bZZwQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617951; c=relaxed/simple;
	bh=Eqre9EVQ7YlVbIBp2jqspJzGDFxFiz5ITzxRB7dmjSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVj8NQXAvbgqrqFY8AvTz4Q8vE8t+vmLGS9T0hEzKEQPoohiQ8rD4MGyOOF98HmGx+yzFNzhZiXA2HHA7VofsDfo7SqZxWxaFbnQDvLLcLgV5gHOLLgum7tlQZ8y6KNsRq9/osl7waLMA6GUE88uUYsoZ4th9IJ9N1Ar9I/dFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhN2puzE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhN2puzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48691F0089B;
	Thu, 17 Sep 2026 04:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789617949;
	bh=Mozf9eR83klndQFJraTt18kHcl1hxd6yOHCmDoYKrX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GhN2puzEsWiLv7s8wcGaPWWWFYfc1kACptDmFKSTdaoePt3/+GPX8BMMgRD3+GIKC
	 S4nfxqpdKNvJqtKASnnu/vk47kNDkTULgZCFUH0L7TowQXoA0A7UiFeWHBloVXRa5n
	 FrNaeF9cNUq3qq1RyAX1viVPh6HwjgiYC3VR/Ap4tkMhLfZ+3ufUSti61FyoU4JRDe
	 DX9CC8elLVbULwp0z+5LPeilDddi0plmtHLv+XK+GIVpP7jxItIuMB+t2UHOCRqDec
	 7raemiTAjfgKfRywm7kLR5JKOGzLnt1U9hDheawk4CluP8C5YojvSHQ9cnMtR/URik
	 V8rYQJKHyUPkg==
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
Subject: [RFC PATCH v2 10/10] Docs/mm/damon/design: clarify bp is basis point
Date: Wed, 16 Sep 2026 21:05:36 -0700
Message-ID: <20260917040537.107341-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917040537.107341-1-sj@kernel.org>
References: <20260917040537.107341-1-sj@kernel.org>
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
Acked-by: Randy Dunlap <rdunlap@infradead.org>
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
