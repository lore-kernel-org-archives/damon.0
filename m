Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D6392B89;
	Tue, 13 Jan 2026 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318053; cv=none; b=JQH7mK5uyWBguYrrL08SuMZbllW2/Cxbo5x4hvS7qH4q8lVoWKCKWAWU164xNmLsJDeJVNBSxuAMAeszzyLnI/bN0/j+w5+kbQO8W+KFIKbEnwFCBiVJb0J0sXQMtoq8MO49YniUjBRK+3DKQvgLiErVvJAc7qdC307sguNHqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318053; c=relaxed/simple;
	bh=pT8rCC+C0SK1J6+L6zG1LeeNo37asvsmk7EOOOw2HLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTd+1R+taUVyoX/aB03XTR8aevpO5+LaAnol6+/ic6I2L3yag0hYijYkifnt6xhJboCbU+U/PNLgUu+G1beailEOfa+mqGeg7dRoJrp3s4i+oXJxj4RkwtxjZSX+9+yjMPC25YHK9T0IuJsVLSF0weDOIAxo9s4tDqTwVwnngDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgsY/EKw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgsY/EKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC40C2BCB0;
	Tue, 13 Jan 2026 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768318053;
	bh=pT8rCC+C0SK1J6+L6zG1LeeNo37asvsmk7EOOOw2HLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BgsY/EKwjt7qmaf3qUOIY0hmGSbVVt9OdvhnNXzeZBijHgaHf+WDh02E8rNvP8rIP
	 V3HOJo0D8Hs9EEIn7xVw0Y3TRmn4+kGO7tHhaAjSRb74C3aeTu4usHqNeJCwdOuF0z
	 Ky7/AWiVPrn39Y0jFkiavTeqCs5g4Np4bo+q4zonH1+f59pPCT6u1W9mzHleoMW6Pm
	 kPqKlx5hmYPopCVxstoGHsTxXOFg3eSSxWiodmJddCzbxBrtwsMcfphrBK8x/wRbCS
	 QeA6GmB6r7CYyRyfARgcqihrh6ZyprF7pZiN9g8l00FIjjlXgtRC/SY0WC/3yvQAU3
	 7VigYfNXpZqVg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH 09/11] Docs/admin-guide/mm/damon/lru_sort: document active_mem_bp parameter
Date: Tue, 13 Jan 2026 07:27:14 -0800
Message-ID: <20260113152717.70459-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113152717.70459-1-sj@kernel.org>
References: <20260113152717.70459-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document a newly added DAMON_LRU_SORT parameter for doing auto-tuning
aiming an active to inactive memory size ratio.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index bb222a32aefd..6af3ab5579a3 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -79,6 +79,18 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
+active_mem_bp
+-------------
+
+Desired active to [in]active memory ratio in bp (1/10,000).
+
+While keeping the caps that set by other quotas, DAMON_LRU_SORT automatically
+increases and decreases the effective level of the quota aiming the LRU
+[de]prioritizations of the hot and cold memory resulting in this active to
+[in]active memory ratio.  Value zero means disabling this auto-tuning feature.
+
+Disabled by default.
+
 filter_young_pages
 ------------------
 
-- 
2.47.3
