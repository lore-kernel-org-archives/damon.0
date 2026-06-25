Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E4305660;
	Thu, 25 Jun 2026 05:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364088; cv=none; b=I/f1ZGdPuKa3TidRvt5o97L8tKqsV1VEfBVg8f4ua6PnLQIHrtShx2w7nB+XnhiaVrm6qHiHrchEmjwO5vQUUmLPl2AQDaJT0ooYwHvuW9kNMYIivLPXCPVB3MsIqFqiS53bzi0Nmqyut9q/oc35oDNLW+YJKX1AYzbfhxs6lG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364088; c=relaxed/simple;
	bh=C2YYKPDq8AqsNOzt/9AI9lNxqD1ivhgfxItPR+yK08Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJgpcTEUueYW6z/x1Z0u++km5Y1eJOE5Wkv5wm8Q/S2yB+15WijQaeeGrKe3cVj6hSUO1JMS3iKCmLK1vX+xOBZwxtZn7ulsRmsxzcGgqsLLL+lpxoqLNd2gXcKNMOzVCqd1aXWxmmbdPG7FvGblTmXYWa50E2uf+8019GY9HpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWFqIUUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWFqIUUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143491F00A3A;
	Thu, 25 Jun 2026 05:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364087;
	bh=6LvJ+WZBdNE8CHC50l21Bmx+mbLbHYnZH4awOTWd1p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JWFqIUUwrG2MVgV/BwcJOhJScly5CnEo8zWWGiNiNwyNQriyzq7Jmvsi9+7hTFyVH
	 MFm+5GQCGBJFHU48PDxJaOIwJl5GE1hZt+2gK+PsHtZTcr/yhMxSjYkU3Vt6ct7Qj/
	 I5Z2hDn8RbFGBGxspyrd3l5mApcogYQsWPxlmZY+cCxC1jRClPi0dpu6sitB9xA20M
	 tsPsO18Jt3E8W7mT9imtF06GfS9re9meCLNJevv2cEXhA5XCSUtPOqmVXOjo8qkldq
	 +7HtqR4Mr5LczvIUT4CSRheEG5RDEWAr03YbH84WuBy2EK0faPFXxQN8f/kheWV5Ue
	 QrssoAiUMdm/w==
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
Subject: [RFC PATCH v1.1 01/11] Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
Date: Wed, 24 Jun 2026 22:07:44 -0700
Message-ID: <20260625050756.91115-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625050756.91115-1-sj@kernel.org>
References: <20260625050756.91115-1-sj@kernel.org>
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
index 2da7ca0d3d17a..1ed02f2280790 100644
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
