Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787BC3C1092;
	Wed, 24 Jun 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310823; cv=none; b=psKgjTwwxebqQov6mALqaML1mHyoRBfnAJtMKXYtUs6R5H2WQ7cA8vfI14sU90m6MjL+6oTFHaJfJizLFcHeprDGGDemFB94X35GtaACLKwzXBUHBG3ngmxZTUaDRTOxpRGtpwpkacsYouEeimd67elzCvA7o/qfY7aSy7Zokk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310823; c=relaxed/simple;
	bh=c8miyNRKV0QMgNau4Lra2W3XSNWpJlcPuhL5KfblTLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8oOLx5OMPgklfT0cU0EQ8+OdUfTPjkHjgL+Npf6OHNJsXYZYPgkbURqN2xSFEA2n6L08Sxw6AWREA12CJcWis8rve047t0uDXweEwWziZ+Kk3g4CdLPpuFwtGyjuuMc7Ai8/hyYlGxTllsfMuaq0iiHgnUN8AXAqLxx3//tuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh6CQIWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh6CQIWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65B01F00A3F;
	Wed, 24 Jun 2026 14:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310822;
	bh=bVCNJtOfFO7pgjJRgMMYuUjN3efzSxhou1ebWwN/K3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kh6CQIWsn5SlNK8IOKr/guTrM5zSpZkmFsTQ0V/Cw6eKAQ7kVT68FgVB/juYYOtoe
	 F4amM0Rk2JJlKnXnLsEXfeT6mP7JaZH8zm5cB8bDAy3tJXCb3SQME/bNmxb5hasx/L
	 /xIyXqihYrcXhQri41ghvb8fipoLnHevOMWW4FCAYQ89sUqA/foZ1BbwftEGntDQH3
	 N0aUIY5OYeDa/seXBcd6EjPaADedH/YHaiSe1QHZnHH/Vm046VwHhnXQ2TxNdXBV+7
	 ueV7y3Loajnn9yjMwWByz3eh6GgS6BS2AQywLMuOtTtNFiH4W3uUI+pJySjcPgprGF
	 IZ+eENDWK8zzg==
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
Subject: [RFC PATCH 01/11] Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
Date: Wed, 24 Jun 2026 07:19:57 -0700
Message-ID: <20260624142008.87180-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624142008.87180-1-sj@kernel.org>
References: <20260624142008.87180-1-sj@kernel.org>
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
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index c16a3bb288d07..06a8894eb06f9 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -686,6 +686,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
   (1/10,000).
 - ``inactive_mem_bp``: Inactive to active + inactive (LRU) memory size ratio in
   bp (1/10,000).
+- ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory ratio
+  of a node in bp (1/10,000).
 
 ``nid`` is optionally required for only ``node_mem_used_bp``,
 ``node_mem_free_bp``, ``node_memcg_used_bp`` and ``node_memcg_free_bp`` to
-- 
2.47.3
