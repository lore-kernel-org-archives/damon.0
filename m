Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B344A3FE;
	Fri, 18 Sep 2026 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741719; cv=none; b=uJL9J4bSz4yEh3xWbISKvBGDpbhdPLgqTw+7SBp4HRHBIWJ+bCN7PyispSx+mv0F/1DRxd/X/PVn9zI61DAy0VyYjG1qGc38kgfSyIrtruEkAz/XUlNnJtANhB7WU76KerZ5pjYCKgYzLOhuVEYoHMexdrZOKFPJAi98tn84bVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741719; c=relaxed/simple;
	bh=plGbdbehTitQph8PfjL4EU6xReU3ILvw6sBrO0FSP4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq9+Gpvg3YAgzp6AlKVEta2c3FNuQ6f0mDy/kA6NOOfKj+Vw2/r459nfEPp0j0kAbHvXckeqKlSvZQhAv6qoDrZasK7c8KsQBO8gThyZwUhMsHiNJJJrfwXHOJoZdaxTM4soNjcRiwelhtKpKGftC8OCajz3wqRyhT8ZgJiHScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuycTjiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuycTjiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264691F0089C;
	Fri, 18 Sep 2026 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741717;
	bh=tnIaLQ3JqTQKlYGtXSLMaRVuIin07S/F5Nx3QIjWklQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TuycTjiVoeVMzOYC+QdjBjiq2BtWAOT6mVWKFFYP1Q43SZJ2ylFR9x/qtM3GZAT+h
	 zjOFGtdgHcHNpp+9JwBfJTsNLBbFG2CZqKSUTHTEf7E6RrX08oaAiqv0tqrhCTraDE
	 6J2OVhxJYCIL4mIpl1F8U9fscvpS5y04kEKEGEe1ebq8On3ygxfxwPw787L5pZN7I5
	 j/RofLP4S0KKXUwUaOXn/3kOObyFeb2QH4164d5Qv7xMPS+LoKHc498YgRdZyGtP7y
	 1Igmc9WPRZ60staPoaoDWecFA5qWlwLfiqX5l4/7ep0D4/UnudyPmXl3LxV21brM83
	 bvpdf1PGF+ceA==
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
Subject: [RFC PATCH 5/7] Docs/mm/damon/design: document damos quota goal complement flag
Date: Fri, 18 Sep 2026 07:28:24 -0700
Message-ID: <20260918142827.85303-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142827.85303-1-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added damos quota goal metric
value complement flag.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index e82390e77a70a..c82be80738c45 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -702,10 +702,10 @@ There are two such tuning algorithms that users can select as they need.
   that the zero quota is a valid quota, and therefore ``qt_exceeds`` :ref:`stat
   <damon_design_damos_stat>` will keep increasing in this case.
 
-The goal can be specified with five parameters, namely ``target_metric``,
-``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
-mechanism tries to make ``current_value`` of ``target_metric`` be same to
-``target_value``.
+The goal can be specified with six parameters, namely ``target_metric``,
+``complement``, ``target_value``, ``current_value``, ``nid`` and ``path``.  The
+auto-tuning mechanism tries to make ``current_value`` of ``complement``-ed
+``target_metric`` be same to ``target_value``.
 
 - ``user_input``: User-provided value.  Users could use any metric that they
   has interest in for the value.  Use space main workload's latency or
@@ -733,6 +733,11 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
 - ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
   (1/10,000).
 
+``complement`` is a boolean parameter that determines whether to use
+complemented value of the target metric.  For example, if ``complement`` is set
+and target metric is ``active_mem_bp``, it is effectively same to
+``inactive_mem_bp``.
+
 ``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
 ``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
 point the specific NUMA node.
-- 
2.47.3
