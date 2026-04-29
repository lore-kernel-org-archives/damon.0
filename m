Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C4838D005;
	Wed, 29 Apr 2026 04:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777435960; cv=none; b=Rmb4ox3AIMYDZfTuiyV1MqY2WXdMGb1CbwrMgkc2huIDWr3j+HkIMk8p1WoImHBbLoSHgd72vO0s37ZLiblDRaa+OSyonC+SSq15Ryebc/WAP6xXJbtIb9xbGlTfe0qSirlNLXP4qeiDo9hvW/HR4DqSLSsWMBA6aXCOaOQhc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777435960; c=relaxed/simple;
	bh=u93JPpTlUZa2B/ZunhEoNlylkbQxSRBwO+E/mC/FBAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VrTvFa4wBMPg5+b85+T47XwmT+o7MfsXhvKXajzFqvtNDnQuLBh26u/Xa4x3IZZfCrGtvFLXLgebozozMw/cAJPId1+h/bjVVYtJDXnAOWuDFBDx9rFThfIvf4kzXPfaFjBoxyxXrevV6/r9WHFDKg5re9B8mu/Ao9P0+OI/VNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C912i0Pe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C912i0Pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F58C2BCC4;
	Wed, 29 Apr 2026 04:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777435960;
	bh=u93JPpTlUZa2B/ZunhEoNlylkbQxSRBwO+E/mC/FBAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C912i0PemsFCYsHBoZ9dNu2aeuVuI85VpslMloSdbwD0vPIrHLRERO1zehLZEVUMb
	 6J0hVMz7P9ORo9NEJRPgQThbGUerYmFz6R7GB2ZO3dnlGNWZCuJGrsYmTmyUrqoajX
	 25eGlkYwvOsQa/9B5aFVFnqhTa3J9LvYbXBaPxXkZ9bBnl3Zi7VMysmhKTA+zxNBbi
	 V2lrRlorpW35jyTcltz5R7kDibkBRAp5LOg6S5GJ6C09XAQjg3TqyGxyF4b6mDScTr
	 vHgzKUvkdtCo/NmmjOj4Z5MkJGY1SeYD7IaiAxCj9kGRpAAsiFoXFwkZeTHE5phcSz
	 t/3uNSkvvfHPA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
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
Subject: [PATCH 7/7] Docs/admin-guide/mm/damon/lru_sort: update for entire memory monitoring
Date: Tue, 28 Apr 2026 21:12:29 -0700
Message-ID: <20260429041232.90257-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429041232.90257-1-sj@kernel.org>
References: <20260429041232.90257-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON_LRU_SORT usage document for the changed default monitoring
target region selection.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 25e2f042a383f..b93ca9b0853d2 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -246,7 +246,8 @@ monitor_region_start
 Start of target memory region in physical address.
 
 The start physical address of memory region that DAMON_LRU_SORT will do work
-against.  By default, biggest System RAM is used as the region.
+against.  By default, the system's entire physical memory is used as the
+region.
 
 monitor_region_end
 ------------------
@@ -254,7 +255,8 @@ monitor_region_end
 End of target memory region in physical address.
 
 The end physical address of memory region that DAMON_LRU_SORT will do work
-against.  By default, biggest System RAM is used as the region.
+against.  By default, the system's entire physical memory is used as the
+region.
 
 addr_unit
 ---------
-- 
2.47.3
