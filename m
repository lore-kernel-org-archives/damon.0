Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1002D592C;
	Fri, 10 Jul 2026 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691228; cv=none; b=Yjs71BqG6Qv7yMCLHAMh1VRT6StkCtQbcDOJYielgPFcUZoKwRX7FPZEjT4kmgegEWBv6v3ehZb/cTfYvh9Zhkcrkw/HRemeoG3GNkD0gUNdD+LVePdlMyWnwx1erHLBaT59GmIOGX6Q+b1hqYGFj3VMvNDlagzNf2t7VFTiF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691228; c=relaxed/simple;
	bh=76Ms7lr2E1n8a9s5BVP9BtK3Clv9+dktfC0KcnJw1zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N21NFj8y5eeYn4vVL88SnQVaWaDjGnb2yKRtDWZluuL9+wyYj5WRqOrfqHqOJ6Wc3xbvT71FhRwe2MBrtCG5/HM7wmz7ciK25y6Dmqa8sd17SZeDRP6Ygp8Huk+7RpRrCquxrS54A0UtP96S2GV2JwypOFUhu//EzHIqDlsg9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgV4ydHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgV4ydHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B5B1F000E9;
	Fri, 10 Jul 2026 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783691227;
	bh=KtGhb2uuQghnzvwRekFMe5vHCrkMdKOrMY5ghfXYhj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HgV4ydHtaLl713bFf0XEoTAhOBbrOFDt3zX71GIXZAjf4O7Vrc2IFz7HmMQBTbg8R
	 iO6mgiRfKyjgJixUjoOc7l1+hozdmwdXZlaENLpShYpHfnm03PHjkEXDyLjWewiphP
	 y/G3GhsoTp0lhmpf2yLutE22UUbLbDvSG23AyUl6ksr8v5Nn37sViJL8gRyGkLKK7o
	 Phv7O99XxfPsHujP1gZ2zTVACxi9oefJk5NvvYMCTUv+W0JnSXE5tVRd99HyQwb2zx
	 gD0mx2wK0idjc10rycP3IWkAUOdnPTfcSSFWAsS/9sDLF1LN+O699PGVTQjlZDdREW
	 F2E38iwPf9VFg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 19/19] Docs/ABI/damon: document probe weight file
Date: Fri, 10 Jul 2026 06:46:48 -0700
Message-ID: <20260710134651.18084-20-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710134651.18084-1-sj@kernel.org>
References: <20260710134651.18084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added probe weight sysfs file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index dd6b5bd76e119..907a504fb64c5 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -164,6 +164,12 @@ Description:	Writing a number 'N' to this file creates the number of
 		directories for each DAMON probe named '0' to 'N-1' under the
 		probes/ directory.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/weight
+Date:		Jul 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		per-probe attribute weight.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/nr_filters
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
