Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F792FFDFA;
	Sun, 18 Jan 2026 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768759393; cv=none; b=ow3MwrA9yqXmVACO6rfM7HXUbKh8aE6zZ7u3RLRVLy+bofSujf2S1Ap3B3jEoNy1zAu3OFvIyuj+vTEBBwAuhTzlFeQ5AfUWkdmchGtxzji0ihyH+qQRvTWLWEwb9jLufFOzgo0Ek/88TUX155FQKg2Z6Lw60bypFio+502oN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768759393; c=relaxed/simple;
	bh=kKivkzBbiXhusYPA4CZvWuiT6LLGAcIHoC107wxKjT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijCAIYuvWacZDwx3R/EsXK35JMfQ4ayaeaAb5767ypxplUPGV5b8q+zjruKS10xhe/Lar3l8OhAVDagvgwGaUoNCoAoISWFnXunIPM3EUxB5RpB+viiGLxrlvi5Pe1XhlqlPu55mjurb3Jbq44Ugx6erNU4OwGUyCRQBfycoG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSD+bNz3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSD+bNz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABEBC2BC86;
	Sun, 18 Jan 2026 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768759393;
	bh=kKivkzBbiXhusYPA4CZvWuiT6LLGAcIHoC107wxKjT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSD+bNz3uMdp1Ai4DC9qcx7XGfCRHvF82aWlIkI8LkbzdKtGwhY8eZY8ddphTbF1I
	 rH24XGtcKrBvYKQi4hEkUxShF6e3jwwIGd4eAlXqknADMhGvvjw6JY4TJc5caMaQx1
	 k2HnWCWrqbVWc13mN4KaHojAi0dKqUJqvCqDKYhhDRQlgOVbxpO3bSnSAUQd01+3a7
	 9YgtVGy8LU+0GF3APRr0AelWTAPPASpqzm40cbA49FXhyVDYg1dVNlrJct9FGbY90g
	 /qPiMgm8xW8liWWCHJT/uLFQKj/1Dw/KRxo0B8edbcpQqSxWKV3PaJkfwtvTf+M3Hj
	 uOgKAkgG/Hq1Q==
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
Subject: [PATCH 4/8] Docs/mm/damon/design: add reference to DAMON_STAT usage
Date: Sun, 18 Jan 2026 10:02:55 -0800
Message-ID: <20260118180305.70023-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260118180305.70023-1-sj@kernel.org>
References: <20260118180305.70023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Design document's special-purpose DAMON modules section is providing the
list of links to the usage documents of existing DAMON modules.  It is
missing the link for DAMON_STAT, though.  Add the missed link.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index da0bc40c2261..c10a3dea3aa8 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -834,7 +834,7 @@ To support such cases, yet more DAMON API user kernel modules that provide more
 simple and optimized user space interfaces are available.  Currently, two
 modules for proactive reclamation and LRU lists manipulation are provided.  For
 more detail, please read the usage documents for those
-(:doc:`/admin-guide/mm/damon/reclaim` and
+(:doc:`/admin-guide/mm/damon/stat`, :doc:`/admin-guide/mm/damon/reclaim` and
 :doc:`/admin-guide/mm/damon/lru_sort`).
 
 
-- 
2.47.3
