Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028D2D12EC;
	Sun, 26 Oct 2025 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761502944; cv=none; b=fkKu6E7IHDdcyTfqVmvx5qlefDuwlO4ZhAk7wVbZMAG6uOc5JsmnUOfwbt4Z7i/Z+yBYBnOfnlhksXZ4xLpA3M2j65XgZGihRULZJ18f06ZohG7jpzHM63IsMSZ8Edh0c3ERkNllzDUGMwQk6OQ666YG2kSA6DQT+DQj5NDkPCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761502944; c=relaxed/simple;
	bh=2OxNFKvhCT36RDHavLAyK2OGp+6UAUMynMMToyr3JtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pr9aMe/INDBs0oBFscempugH6+WjC0FGuRrK87ZKowSq8D+OjOaZbV/4kvaNA6pALUgsQw9P5VJmSccpS4cHJMCrswzegpXBbkFNqk7BikFTky0optVOAB1apbVnlWfsUuq7vlHPGcj+Ip7fvuZ+5Aef1kQHLO1s9eQIsBsdJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huyxrle8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huyxrle8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99EFC116C6;
	Sun, 26 Oct 2025 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761502944;
	bh=2OxNFKvhCT36RDHavLAyK2OGp+6UAUMynMMToyr3JtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huyxrle8m2VS/tPkSLY/a3secq5QD21olmVFnk+tEm911u4eZdB6SU7qaYj2eF0gK
	 gpWzMJYOt8vybSCS4Y9miij0pJiU5UalTlQqfGAMVtlAcvma8QfvcjkWr/CpoT1pJL
	 6Xm9qn/NvEhe80WGuKeg5NbqtDgkEyNnvWAQZZaXkWVpuDOjEK5lTOnWQ0uTp23eXX
	 JsYVdqymwjAyDGNJ18VbUseyhj/hR3ISscQ4nLD3WzVku3o6kRSfGTOrBJFl7y0tqM
	 6c/7uEB1MuqZyTgEm+H3vvedJgo39A9T8kMgVtllJ2+sBtpuV/N+8FH6lxT7DJwNM2
	 JfgJ5Skle1M3A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
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
Subject: [PATCH 3/8] Docs/admin-guide/mm/damon/stat: fix a typo: s/sampling events/sampling interval/
Date: Sun, 26 Oct 2025 11:22:08 -0700
Message-ID: <20251026182216.118200-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026182216.118200-1-sj@kernel.org>
References: <20251026182216.118200-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is a contextual typo.  Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/stat.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
index 4c517c2c219a..20f540a9d3d2 100644
--- a/Documentation/admin-guide/mm/damon/stat.rst
+++ b/Documentation/admin-guide/mm/damon/stat.rst
@@ -17,7 +17,7 @@ DAMON_STAT uses monitoring intervals :ref:`auto-tuning
 <damon_design_monitoring_intervals_autotuning>` to make its accuracy high and
 overhead minimum.  It auto-tunes the intervals aiming 4 % of observable access
 events to be captured in each snapshot, while limiting the resulting sampling
-events to be 5 milliseconds in minimum and 10 seconds in maximum.  On a few
+interval to be 5 milliseconds in minimum and 10 seconds in maximum.  On a few
 production server systems, it resulted in consuming only 0.x % single CPU time,
 while capturing reasonable quality of access patterns.
 
-- 
2.47.3
