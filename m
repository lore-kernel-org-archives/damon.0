Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F61EA65;
	Thu, 25 Jun 2026 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397477; cv=none; b=LTEJntTG+VAuIgZgGty1HeUT/lCAGt+wAoiaFNzuU+6ieE5s1sAejfjWlnvomJS+xOq85ZOPWQJKLGGoqFpWb87bY8E+YkzL9nM7MB+SD8YLTCe56YwW3wPcofxusIKd6tqU927/jR8Ao8RS4QBFcI0q1JcAKqaOGYhjB4kwXdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397477; c=relaxed/simple;
	bh=upBNHjtZBSZwGHMGsIHPIg7r/nAnJXwvQ1AgeZ83JLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chWP5fnou/UeY7CRpz4ouadyfIk4/L9Dd7bsl2yCRNOHma9qLYXhRihid8nVCzx8OCAU3Ya3Uk09rhZxHflLnoMIj3c4Mfem9Zb3JSGQDliHJkOXeMUak5WRvfTaJ7u2WTRLFLMuGXQOu4oynLo5CwqR1zJZgxfRbwGJyzmKjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJNNTNUN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJNNTNUN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578451F00A3D;
	Thu, 25 Jun 2026 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397476;
	bh=0ZqcZeO9nNSHPkQcuZ0tph2LYz0rFmJSVYYnP0TkDSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GJNNTNUN2WnwnpZnBi0cCWrZ4IQnySWFA5U5S/yWC7ytYgQcC7fu9tgp0zY8/Pvld
	 3cbTwf1w1v+gaM7bc10spVuvhUl3fiyVzRskIpqcFDaaZ2PHX6ox1R5xmMeX2xZA5Q
	 QmzoPhN/e1HsOWXqdaRItKXqJC7uehez8nQPa9nU3mt0IzZzmVgOGe/nuWF1gT8Xl5
	 xcsbrnV9psTyQVOXDyIJwSPmOePfl6167h8mgqG9HpDpLQxllOrXVE5kvkdH9tB3BV
	 yKyibOthItlltAh06EHTnSUG3rVByaB/6/W5bXm7x/ji2Ewvz2HMGi0CIYsn660q+K
	 LPGqA+Lp0qAEw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [RFC PATCH v1.2 01/11] Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
Date: Thu, 25 Jun 2026 07:23:46 -0700
Message-ID: <20260625142357.103500-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625142357.103500-1-sj@kernel.org>
References: <20260625142357.103500-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9138e27a3bc3 ("mm/damon: add node_eligible_mem_bp goal metric")
introduced DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP but forgot updating the
DAMON design document for that.  Update.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 2da7ca0d3d17a..9dbace087a329 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -686,9 +686,11 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
   (1/10,000).
 - ``inactive_mem_bp``: Inactive to active + inactive (LRU) memory size ratio in
   bp (1/10,000).
+- ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory ratio
+  of a node in bp (1/10,000).
 
-``nid`` is optionally required for only ``node_mem_used_bp``,
-``node_mem_free_bp``, ``node_memcg_used_bp`` and ``node_memcg_free_bp`` to
+``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
+``node_memcg_used_bp`,` ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
 point the specific NUMA node.
 
 ``path`` is optionally required for only ``node_memcg_used_bp`` and
-- 
2.47.3
