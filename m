Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03049DB96;
	Thu, 10 Sep 2026 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049944; cv=none; b=q3VMIQaFyjYnSD2D21X0rg3AuhD7xwgx2wcxiQ1VLzxaw2TJiCM86EzgMmA2/+XQSiWyJLckg7/oxSp5w8GhQi8W8+AElmd10ruhrszjUcjet3Aa0PQ3ALUqTioXsLTfnMbGHth3McKUCTCImKG/8o1HA24hgbJBjwKDNwlemNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049944; c=relaxed/simple;
	bh=+pwt7ytLNv7N/tXD0TT/aWOG89chC7GSwPZ5TDexaSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG7mNu9E0U+FdLkskzl3aEBFnkwce30ByS8FnFkbVkmi1D3pp3MCJTd0SXuk0MGGSma3hVQsOU/DR4/G41l21ByYT3v3o7Ei6FpM4YGx+4SdvElNXhpqdz7ygKDsM8fB/pPreLzq2QOPWX9OkVxnFy6t5ep+eC8HXJQ1G+I9Kkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZmiaqOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZmiaqOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140371F0089A;
	Thu, 10 Sep 2026 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049942;
	bh=3QelAmhdJ8KPxvwLkmNC9X/53BNSeYX//IkIfked+Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AZmiaqOQe7vl+dkkvbuyp608Qzdl3zoDwvGY1X2mnJB3HTVCyCGTCrDzd2qTe3kvf
	 SMhkcgGwduDzhWzChaEjfklYbYJJXkYNbi3r4Ytl5BF1BXGwK1B2iof1ckrtIJNqTa
	 9d5NMpaTpWKcc/rXe+u+Z8WHiQnZf2zamWfokYB0TcIqDIPgltmtz4y+X7X1sUkLOb
	 rsRtJ0XXoaCZLm4WllYOyzDSEA6AQIytQX1dRaUAH52eP4WUamdoBGkqLMgLBDhxeX
	 LSVK9rmu/4DHWlshA6mT/kQOdmmsuN3yJy+/MbyBYf8LlB9BQZF3btYiqm+lyTdACx
	 KMyyqL+mgsQUA==
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
Subject: [PATCH 6/7] Docs/mm/damon/design: update for probe_hits_wsum DAMOS core filter
Date: Thu, 10 Sep 2026 07:18:46 -0700
Message-ID: <20260910141849.170896-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910141849.170896-1-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added probe hits weighted sum
based DAMOS core filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aac84de261aa8..8e980dde362de 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -822,6 +822,9 @@ Below ``type`` of filters are currently supported.
         - Applied to pages that belonging to a given address range.
     - target
         - Applied to pages that belonging to a given DAMON monitoring target.
+    - probe_hits_wsum
+        - Matches to monitoring regions having a given range of :ref:`probe
+          hits weighted sum <damon_design_attrs_only_monitoring>` value.
 - Operations layer handled, supported by only ``paddr`` operations set.
     - anon
         - Applied to pages that containing data that not stored in files.
-- 
2.47.3
