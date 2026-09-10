Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F649DB96;
	Thu, 10 Sep 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050166; cv=none; b=BNH6we9MyKvQNF/akMaQlIJ0s2IZZ6HwaC2ezsDvh7I2wYf8eGiROLRySIJYpriKvvgmmW3D8yt9KgjLbZAcdA0cxiF6TMs6LmWR4wdX92GUeIJiEY9e2yuxy0+TDFesxxOhXvvBZNSxXIiplbx0tVPAcKlI+JUU2ARZP4yZVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050166; c=relaxed/simple;
	bh=KCZ0Yk5WQx6KDsQSc5ywq2cca89SEG4MnZVTSMJg/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlWzzb4d8pPHwVjU3PyDgJrbE25ZFwVlsbMZ/8+CPEkUAX482LV20fxF0n0OnzsEDp7IREVxTROBNwN6cZFgoz1xFIiVHeaOI9eSKVTzJc1UoAqwuAqeqJGyD9cOQqZMmmDgg7yEYDqWoFMlPTKozWp+HkZRFpwExE1M0OHyGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHd53DEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHd53DEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7331F00899;
	Thu, 10 Sep 2026 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050163;
	bh=YGHkp73SOXJ8OAqpC14uJPbey8Nk7EBIVu4GrdElavM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHd53DENUTYY7vRprpcZNyTffPeiy3FX1l+LpLOaJ55At22n08OvMdQCJlAXl8F+8
	 LALmvYW7gCkPjpkRQtX2T3Mcw5W0WpjIvwQA8LRu3yys4AbCX1J4ynA71Up27O4MA0
	 6Xw22Nyq8cuPVGOBdaePl/56vY0RLZcutZTcebwJvt7tpQUnUmhjIJ3JOixbHVP5aH
	 Nhghcv3il2U11FMStdmxyP+q2rDqXcAaeiK7Dv7ghzuCS+hEdUboEgtMUvzhoji3/m
	 9OU/JJe4K8worscSK8pkDxyxuV4LQZYh9+qtGmqHrJgASDlrAQhY2AY3Wf5aTfAViI
	 +e+co2v/riEmA==
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
Subject: [PATCH 5/5] Docs/mm/damon/design: update for pgidle_set probe filter
Date: Thu, 10 Sep 2026 07:22:32 -0700
Message-ID: <20260910142234.171562-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910142234.171562-1-sj@kernel.org>
References: <20260910142234.171562-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added pgidle_set probe filter
type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8e980dde362de..cb116a82ff20b 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -299,6 +299,7 @@ filter types.  Currently below filter types are supported.
 - ``memcg``: Same to that for DAMOS filters.
 - ``pgidle_unset``: Matches if the page for the memory is marked as not
   access-idle.
+- ``pgidle_set``: Matches if the page for the memory is marked as access-idle.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
@@ -314,7 +315,7 @@ actions are registered, DAMON applies the actions to each region's sampling
 memory before starting the next sampling interval.  Currently only one action,
 ``set_pgidle`` is supported.  The action marks the page for the probing target
 memory as access-idle.  This can be useful to be used together with
-``pgidle_unset`` probe filter.
+``pgidle_unset`` or ``pgidle_set`` probe filter.
 
 This is a sampling based mechanism.  Hence, it is lightweight but the output
 may include some measurement errors.  The output should be used with good
-- 
2.47.3
