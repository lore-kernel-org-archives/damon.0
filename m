Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510525921F9;
	Thu, 17 Sep 2026 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654945; cv=none; b=SX6uigBJL6R6S3MS/9LYEKbqe6L9uHp1Pc1M9oD/A51TO29HZBXYyFnb+6otEAD2bkdAD+qs5flgRsjh4Netu8Kp24dVjwahMLogoIAHcwa8FX+m0EuohaY6/MT5nySL28BJygEgGfka51gim8+3UKW6vO1FNFUpfHZnYPUyjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654945; c=relaxed/simple;
	bh=Eqre9EVQ7YlVbIBp2jqspJzGDFxFiz5ITzxRB7dmjSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOb9ZcXhiylDSypHBiPyl5sF9qRJ5lBOQOfeFhN4jHwF7K/VxaitmKKK6sxKUiB2YZgFYwSX1GDwrcabNVKR5K/n5uY6bvArE7vbdy7HhjrSfRcADg/winRN4DvFG8DTUnpxD7oXwG/gbMgQZcBoNgYi/4NIdD7J1c41xdqOmp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbxk3B1k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbxk3B1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CD41F0089F;
	Thu, 17 Sep 2026 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654942;
	bh=Mozf9eR83klndQFJraTt18kHcl1hxd6yOHCmDoYKrX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fbxk3B1kVQa/Rmy2plmyyuHyctTxT8yCGXvhut/j2pz7uiz+QbAlLv8/6UztAXe41
	 tLJg8cKGIynm6fLnBghsnGt6GCd+jYC7M+RYUhe1vzhfTqX3dOZ4C1BId14gforUo+
	 Mpqj4T/S6kQMSBWZ180eQEfmNUJFLRFNss0AzQc3oQrGPO3n5O+L7sZsfgrNHslSA5
	 aGPofrVcWeRQSeyLDDMfGqp36KBQBcc2Kpb/M1Zuol0PY0FqPB/wrkDwU9zD5C7/EA
	 xT3EQzQInjk9Cx/S/7zF+BBGo6a7I5x/aPeqb6BVAs+d4FNyYRhwezk/i5o+sFkLYR
	 EPfhO8Oy0rVtA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH 10/10] Docs/mm/damon/design: clarify bp is basis point
Date: Thu, 17 Sep 2026 07:22:08 -0700
Message-ID: <20260917142210.90829-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917142210.90829-1-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
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
