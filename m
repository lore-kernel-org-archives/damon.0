Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00D51FCA0;
	Mon,  7 Sep 2026 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801149; cv=none; b=iqoMZQnTj6kh4XpgWOxQEOSlctYhGCCnb4iVD2N2WIK2Y0vk3MsaR3ybI65iqeIGn/2meRODf5S38uCjl5hYOHA5IMi/Y+OuK8IjQa1yygVgLC2VsINi8ms2a+Ql/P937nfwfoCPpGPfntZYHV5rnsJO2R/z4Lw0hrCQXIIMxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801149; c=relaxed/simple;
	bh=+pwt7ytLNv7N/tXD0TT/aWOG89chC7GSwPZ5TDexaSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeAYNZArl/Bmzws60qcXnL2rugg52ah+YRqA8nwwXRI2USYHiazmjkKJ1Jre5Gvgeya3IO/GNBBL9tMUwMrFYX7kkSe5ffbXs8YhgmIh3YXrAyvAbS3aI7tIYwGiwbpHcBzeLd9kp5D3tp2ZsH0zWQFfCg0EQYiIy7N9MFmvkGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULOcj1+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULOcj1+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547671F00ACF;
	Mon,  7 Sep 2026 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801147;
	bh=3QelAmhdJ8KPxvwLkmNC9X/53BNSeYX//IkIfked+Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ULOcj1+AJUjnPLd17XkSPhcPcHUidVKWGqekiLNjlvxtZ3f+/XbjQoNwssXBu8OzU
	 G3zcFDrA1JQRHS4fK21J8STziU+/+9C+Vqn/1qmxpGe8cM8YtTwrKVz9ayrRyRHkjl
	 W5bCGu2n05qfFsaGOdhPfDz8v7BclHFLLwgr6zoyUPX7W1jedNkN7rgGGpp2FrgwcZ
	 6YgBtAvzZlEEM1BqM8e2trpVuPTOJQbYGvsy0eCm7LoUmMzk+s4iR2LarRMAi/g2mY
	 AYtqHxN6V8Wey793BFm5f+uhDMEEYTm5KIxG4KfdeP3UWnwssw4h6NxG+uBX+WiE05
	 OYGzpEk1N4GhA==
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
Subject: [RFC PATCH v2 6/7] Docs/mm/damon/design: update for probe_hits_wsum DAMOS core filter
Date: Mon,  7 Sep 2026 10:12:15 -0700
Message-ID: <20260907171218.101430-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907171218.101430-1-sj@kernel.org>
References: <20260907171218.101430-1-sj@kernel.org>
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
