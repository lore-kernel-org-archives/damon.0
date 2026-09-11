Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F524DFF9;
	Fri, 11 Sep 2026 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089233; cv=none; b=AhVu81xhIVvEF/NFu4sXD1MI2LLUApdPPVIJEBdYtkG5hH7ggkSqS3K8M9KLGGCm9ly5OUSngSYorII++LW/UKppOiduBoD4dnIUh69coUt1zXLor3Y/W/GiIktoYWr1oa93BRAX5xWwZKRuN/Pr0ek/fOX9CsnXaNkUFnySFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089233; c=relaxed/simple;
	bh=mVf9wc6j2RBh8UGDkyG+fy24tCnZhupeyl66dUumXGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGNUmmiug2cChm6VVoEftOahdnA9hBUBqzfrgP630716W+NaahdseETD+e7k8yzizEWY3DCfB7WowO/Oj1U4f9zBItCsD7zsyo7hGcqzBUvSovqz371pRRTKW7UYOxwTSF4/VXoJsoxMloF9djSa/gvD5bO+3PCcj8ChuJyWuhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHNOCgDe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHNOCgDe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57FF1F0089D;
	Fri, 11 Sep 2026 01:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089221;
	bh=0/q3LnB7iB4S2lxLwjnJON3GEVnAZWX6/MrZWM0ze7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hHNOCgDeIocttiQy6albuf/07KbOo3GN/FoSGTxbAdorMZGgv2lPClYOrWcEyKM0M
	 KjTCo53iFApu2tsNRzWMOCE0tz0GoIeSwUmFbzZzQXOpCWe482lVyt/+00ZxSXbgD6
	 5FWNLdGx8DmV0Z5OXTQBmmII4ZdjZKlmXhta+nwPTN6E84YzpPZFl3Aa9Vnky1Copv
	 fL6oWcBWGX1atc5GU2b33X7kf3UhgW7T0MWBD7LZ4ltJ2TPVtfDhtzQgQn48h4FP0a
	 PZdm3d2iwGjYwQAknwn6H4CFsLAwOH96ETGMCshoLIBQfYjJx+esBtNU91tTXwBK4D
	 xU3Bhs6BWNQ7A==
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
Subject: [RFC PATCH v2.2 7/7] Docs/admin-guide/mm/damon/usage: update for probe_hits_wsum DAMOS filter
Date: Thu, 10 Sep 2026 18:13:28 -0700
Message-ID: <20260911011330.93678-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911011330.93678-1-sj@kernel.org>
References: <20260911011330.93678-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added probe hits weighted sum
based DAMOS core filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 023c6334024f8..d3e37400367bd 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -551,6 +551,10 @@ and ``damon_target_idx``.  To ``type`` file, you can write the type of the
 filter.  Refer to :ref:`the design doc <damon_design_damos_filters>` for
 available type names, their meaning and on what layer those are handled.
 
+For ``probe_hits_wsum`` type, you can specify the minimum and maximum probe
+hits weighted sum value for the filter to ``min`` and ``max`` files,
+respectively.
+
 For ``memcg`` type, you can specify the memory cgroup of the interest by
 writing the path of the memory cgroup from the cgroups mount point to
 ``memcg_path`` file.  For ``addr`` type, you can specify the start and end
-- 
2.47.3
