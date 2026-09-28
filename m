Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B904915B2;
	Mon, 28 Sep 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588047; cv=none; b=vEzWEU96f93WUIUKVtpQ8wc4lhlMDFmSIrBoi1Ck+S/XprzS2HA2nbjBDuzYWATKhy4ojT/JbiHAIw8fzRJ5iaznpXiNe8td7UCoK2DbMy16Wa0zvkbL24CtmvojzKhvYpeOQrsUPka0grT3njnJ1qk8cl54asZrSoJsdwSVsz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588047; c=relaxed/simple;
	bh=vuSmGx+d+J/LvI88LPH30k0DyNekzcAX8xyBFZF+tx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6LDURYH3FSzjvztw1DZMlgppCO4MZDytuF7w4g9CQGGq6wgJ848RwWjDqwRkf4u2nJRbvOFTj8rqI2B2Zl5Ckt5XSAtA6sdvySqZFVfGfRXX+zDIoCe2JDQxJWqP40heFyhuCmeL7qlSq96AjSUm8r8xO67Ow3uJrUr6sDfeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Injtth2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Injtth2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1751F00893;
	Mon, 28 Sep 2026 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588045;
	bh=s7JRcQFcD/nLSCcRzyB24nV92nZBWi01kt7jJ+1f3Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Injtth2ze0z9yQyo0jMYhTnxbbBYaoHhP7ruFI3z+AthM2hh5XaeP0j5e/1UBurzz
	 gRQW5fB1AGbdoTYsj1hPu2mgo3mn4gDPdMeDd1RvDeqByz3y4K44D9/RllwnkEYOrR
	 qpB6KT1d+TsM5qocQ1UFSb5+9ppyPZ4s26oy/hkq6dPJICyMcxNiAQjfDoW8S0/7Pw
	 d5mFsW0WTv2VwmQkRtHKibEZterqlp0jZZmS4DvIw0dFqXtyR2XRVFk2GHGVQC6nbR
	 wHF4wKG7dNyTBLDPfRJXY0Q5PkqDF0N4DuQJXMxq01vST+0WR3o9HJzoZye79b6q/3
	 Ser6yPY5Euaqg==
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
Subject: [RFC PATCH v5 6/8] Docs/mm/damon/design: document damos quota goal complement flag
Date: Mon, 28 Sep 2026 02:33:38 -0700
Message-ID: <20260928093342.16584-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928093342.16584-1-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
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
 Documentation/mm/damon/design.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index e82390e77a70..5cd651b1b7aa 100644
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
@@ -733,6 +733,13 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
 - ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
   (1/10,000).
 
+``complement`` is a boolean parameter that determines whether to use
+complemented value of the target metric.  For example, if ``complement`` is set
+and target metric is ``active_mem_bp``, it is effectively same to
+``inactive_mem_bp``.  ``complement`` is no-op when the target metric type is
+``user_input``.  For the metric type, the user should be able to emit
+complemented metric values on their own.
+
 ``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
 ``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
 point the specific NUMA node.
-- 
2.47.3
