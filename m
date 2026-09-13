Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427E38239E;
	Sun, 13 Sep 2026 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319506; cv=none; b=ntiKIq9tMiH0j8V0pMbGfrTTNJGsbIDOHdofhbw87pB6AQw8C9W7g3smgJYGkToegxzcyxu3lacyhRDKErit57gHgigQXq+LEu4jMc+nDjzLAm6WDg9zBhRN1ZswOEse6wrW8g912KEsfvqtvg4EVGbVyGsXFgrJxyN+ae6e6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319506; c=relaxed/simple;
	bh=6622FqAoJyylnw82hdIzdoflo9b7IhzEAZqdmcHMO9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIgoTb/QyI5LoyOJFw7mcIxvgGYGnaPhQGzZ/6AxWuauBvwK2C2zktSxIh7HaVWsgK9Um5lJp7ATd3kF25ahE0UkqMoBumDEadPO3lp0E0H+orE443hodMcxpI1vakNmTZyvhoRov1SDn1rP2EivYtiAeT5QmalCcphTPbZidZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtc1pxec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dtc1pxec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F971F0089A;
	Sun, 13 Sep 2026 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319504;
	bh=KlTkThYMNDC2bLrO2MA1hCJuFVsV7BXLwZ+Px5RpEUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dtc1pxeclo0Lzcvm9Ju7ImpdlIkpMR4zxG8Q16pBT2V9rK9BFgtLMIVk+r0rEZVdu
	 qqyso3lFo9zmZi9YJZPOExTH4wxs/vwm9MrdyNv8OWVDpNrFZIIvlAD3GMU7K9VTio
	 Xq1c3CkLRHzkmLkfcHamvMWiEIudHAgcvmMvFiWmh2c3967ddN/9mK6zcfp5eHsVcq
	 CiJqWcQODsLk6ErNRibLkv/6vIkgq6PwDtPe100ETqHERavMVWA1albjSPn0L4iCuy
	 LpnATobtsRv46Z6mBZq6BT4vPjR/CplutCIFOnnkh/yL9HZkRlcYXV7qzoev/kT4Dl
	 oGN8J/Jwbu73Q==
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
Subject: [RFC PATCH 6/8] Docs/mm/damon/design: update for hugepage_size probe filter
Date: Sun, 13 Sep 2026 10:11:28 -0700
Message-ID: <20260913171133.102366-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171133.102366-1-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added hugepage_size data
attribute probe filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 707170bcd1b33..0a86792f90a18 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -300,6 +300,8 @@ filter types.  Currently below filter types are supported.
 - ``pgidle_unset``: Matches if the page for the memory is marked as not
   access-idle.
 - ``pgidle_set``: Matches if the page for the memory is marked as access-idle.
+- ``hugepage_size``: Matches if the page for the memory is a part of a hugepage
+  of a given size range.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
-- 
2.47.3
