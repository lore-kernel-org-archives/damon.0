Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB54D298CC9;
	Thu, 12 Feb 2026 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877408; cv=none; b=JtOws2R5d1+Y+BDQNNyCzz8f9YaUm1XAWmsv/PGEwNBFAzYmvbtEsCO860cUgl2AR6bcO6sp5wNp1bwBTYTaxAnXQyy+yxJkHFzLscTuL5aggDVlRseDNFFCKgHJMAzMD738p2k6gzGhxknJsww0os7K8RA/HXO/vz591bWw2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877408; c=relaxed/simple;
	bh=GAZRnbykPH7suqW/p1IoZkedLjJYjMBqsndjLOFppz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwzDFPU4bU5UX2TuRvSximU6bjya2R5+ucqmgjklBB2BEA3J6z1vxqY9uCfck2L+IP6GqKflMGcPcWXM1a8zRyOMq5ZYc+e+njPtaFerR5vEHwPYihFMyltAWSSLwhHpedFc6MDSyViGSdviMLBYO9UkPmt1NuNtsucnQofxBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC+OHmvl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC+OHmvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B2FC19425;
	Thu, 12 Feb 2026 06:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770877408;
	bh=GAZRnbykPH7suqW/p1IoZkedLjJYjMBqsndjLOFppz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oC+OHmvlIsLuQBDFuJTf1WEQZ2+T73xoCBHqM9yBl1BWk9WkqzD31TEh36iQQaLlQ
	 xUT06+w7g/gPnavr+zzH9zg+ikJnLdw5AL7WL0XLv7tEi1q/jaZF4pS2Pb5P/0Ahg6
	 ieipUMaR/SLwWF/EKz6hZa4MzMb10vk8maBVAHbDFFTQlcseiPpRtJS76qbzRqFCeC
	 WkRWGw00OdOTgdnz3jxLYBzdt95rOX8C7CJ6MIo/OPdg6odHy7V5cJlCvRLPKuRjQJ
	 kux6HqxX95Mx8H7IBN8CHqUJFqh55ye9ZxF5reGdzy9ks+i8ReXhs7hNA+nmPB23Jw
	 X1NAkx8wk4uFw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/5] Docs/mm/damon/design: document the goal-based quota tuner selections
Date: Wed, 11 Feb 2026 22:23:11 -0800
Message-ID: <20260212062314.69961-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212062314.69961-1-sj@kernel.org>
References: <20260212062314.69961-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the newly added goal-based quota tuner selection feature.
Provide the list of the available tuner with descriptions of their
behaviors and when those can be used.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index dd64f5d7f3193..28d932ceaf7ed 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -564,6 +564,18 @@ aggressiveness (the quota) of the corresponding scheme.  For example, if DAMOS
 is under achieving the goal, DAMOS automatically increases the quota.  If DAMOS
 is over achieving the goal, it decreases the quota.
 
+There are two such tuning algorithms that users can select as they need.
+
+- ``consist``: A proportional feedback loop based algorithm.  Tries to find an
+  optimum quota that should be consistently kept, to keep achieving the goal.
+  Useful for kernel-only operation on dynamic and long-running environments.
+  This is the default selection.  If unsure, use this.
+- ``temporal``: More straightforward algorithm.  Tries to achieve the goal as
+  fast as possible, using maximum allowed quota, but only for a temporal short
+  time.  When the quota is under-achieved, this algorithm keeps tuning quota to
+  a maximum allowed one.  Once the quota is [over]-achieved, this sets the
+  quota zero.  Useful for deterministic control required environments.
+
 The goal can be specified with five parameters, namely ``target_metric``,
 ``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
 mechanism tries to make ``current_value`` of ``target_metric`` be same to
-- 
2.47.3
