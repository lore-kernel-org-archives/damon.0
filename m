Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F7343D91;
	Tue, 30 Jun 2026 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782829058; cv=none; b=sL61Yigu7By36gtQh1FV6bWkBODbGgRQZWoUO2CtrJVxdjMdXM5haiEW1ERoO05Ue9ryETdgUzoJWyCxM14BkdnvahQ1sXc/JyLFOv969yLyk4b4mxUjz/kMdlTFUWzf9vSvg4c0stzkNMTUCgZuZ0h0Ni/BAeD859XJIe6fp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782829058; c=relaxed/simple;
	bh=HSOaEWt6T4mGl80k/ap3kcsahhIZtlekl0TlBCaFiUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qyl+a44javtWMTjig9//baKciC46cEGK6eZEG9/qVT3/tg9hqq4EHbhLDGrG7UztWPlUBjK18qKEZ2y+mq6/akzcdn4HjBbamRXRkDIF14jygJV6avvIOt2LL0NPyHFDBM//rGfOEYO0NKsmwn82ktIcitNqNmu3YRY38ZZjIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1l/BLxf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1l/BLxf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8FC1F00A3A;
	Tue, 30 Jun 2026 14:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829057;
	bh=EaWgesU8aN91zn7rMZBQxRvubXirh78uhNh4ITz88u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N1l/BLxfWBSL1GHQHAM4VeBefwfWJ8DUwHFDZk9rISZ9EwN9zyi+6mdvH3mtclzb7
	 uLysxyP3jWwlFFvK5MkMp/MNfMcq9ugonQBYpHS8GwdnZZViPRbydI7GKWxSjHYEt1
	 bfj0u4RgNUCwGEiHG8LT7D4l/SrzSnWTT4gvIEruPG3OuIiER+VDzRlcwqWJzcd2tT
	 UKVP3IWV0MhrlBTHlYW6t1UwFC8iYBCvJJpY2VDmYPgIpbMk22yvvOlENQLYwYWxQh
	 4RHrVTrjejJsrrXfaib5LM4Ew9d+rOJzZHYzIzgkJEvpCezbn/mQd0plHMtRELpB6Q
	 Kuh0ykO8XKrxg==
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
Subject: [PATCH 01/11] Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
Date: Tue, 30 Jun 2026 07:17:15 -0700
Message-ID: <20260630141726.92246-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630141726.92246-1-sj@kernel.org>
References: <20260630141726.92246-1-sj@kernel.org>
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

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index c16a3bb288d07..457d6e8bc7878 100644
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
+``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
 point the specific NUMA node.
 
 ``path`` is optionally required for only ``node_memcg_used_bp`` and
-- 
2.47.3
