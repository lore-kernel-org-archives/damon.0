Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E0341ABF;
	Thu, 28 Aug 2025 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401176; cv=none; b=GwTkT3hMOFkfn1N3Q7vF2eQtWl6qyKVwhsQlf9APcBKfM9f9JhRWL0yapEDY/IFRsovYRmc3WSEQ7Vn2k/dpZFLllGF3a5B9l43uZIxM8dJk5nzZC52Hice93ZXR4MNeNQdz2N6Kn2Me1vBoMDvTJ5oSQE8HqFr18/TDSD2L4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401176; c=relaxed/simple;
	bh=XEEup2P+YfS2nWpANDMTFLVSwSxLXRRHKWWJnlZZn9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QwmSGzOsSIBUw/GkFBuPmouAEj0aSIKyN+4kPxc9EgUF5YfzXJuWDOdSeF3AC3HdbvnyLqypzEzwPsgtbn2DbunFcYlM7dCFKoPthq6blSbOpXjvvnZ/V71XUsLsItOfK6SR6B+bKZ8fAAlPSVQPfFvVE8opCTm5yZhfp0W5a58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0sDW0mt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0sDW0mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EACC4CEEB;
	Thu, 28 Aug 2025 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401175;
	bh=XEEup2P+YfS2nWpANDMTFLVSwSxLXRRHKWWJnlZZn9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0sDW0mtUEfC7+wyIitulsjr21PnQg6oUa4z9o7wFesIFqL9G9II6sjiS4dNfLInx
	 9RPqGCPrVFzGnAwGliAwcCi3WCC+uNvvSSvtHZoF3fd19n1FFO3pDXeBSrLLKRrsEK
	 ZGjQJQp9LqPIgrXjGUKQh2CnMuzOwr3vxz2Xu0Xtm8e2VcAaozGeoaMvsf+or86ZL+
	 WKs2PKSPPJl9hYSm/YvATa9LiTKDekB9dA5yuYhVOSRKTb3q9LkB8troiKxwNvdczN
	 eqJxV+0gMcPsXoKkrJIRqBpqPEzbFU0ZjRKJLREFfCBEjNeijfmZB2w4FpGmDQwmrV
	 9pqxHdEQ/bxeA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: [PATCH v3 08/11] Docs/mm/damon/design: document 'address unit' parameter
Date: Thu, 28 Aug 2025 10:12:39 -0700
Message-Id: <20250828171242.59810-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250828171242.59810-1-sj@kernel.org>
References: <20250828171242.59810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'addr_unit' parameter description on DAMON design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 2f6ba5c7f4c7..d9d5baa1ec87 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -67,7 +67,7 @@ processes, NUMA nodes, files, and backing memory devices would be supportable.
 Also, if some architectures or devices support special optimized access check
 features, those will be easily configurable.
 
-DAMON currently provides below three operation sets.  Below two subsections
+DAMON currently provides below three operation sets.  Below three subsections
 describe how those work.
 
  - vaddr: Monitor virtual address spaces of specific processes
@@ -135,6 +135,18 @@ the interference is the responsibility of sysadmins.  However, it solves the
 conflict with the reclaim logic using ``PG_idle`` and ``PG_young`` page flags,
 as Idle page tracking does.
 
+Address Unit
+------------
+
+DAMON core layer uses ``unsinged long`` type for monitoring target address
+ranges.  In some cases, the address space for a given operations set could be
+too large to be handled with the type.  ARM (32-bit) with large physical
+address extension is an example.  For such cases, a per-operations set
+parameter called ``address unit`` is provided.  It represents the scale factor
+that need to be multiplied to the core layer's address for calculating real
+address on the given address space.  Support of ``address unit`` parameter is
+up to each operations set implementation.  ``paddr`` is the only operations set
+implementation that supports the parameter.
 
 .. _damon_core_logic:
 
-- 
2.39.5
