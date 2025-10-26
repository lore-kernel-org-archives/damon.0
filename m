Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62A2EFD86;
	Sun, 26 Oct 2025 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761502945; cv=none; b=tG3r44EDm3cB0inifAIyXTvh5OvPB5GGpg2f7kENoUtaIKAu++DshziBfD6sifxmD78xSI5bJw++mb6iW8nKJgdA56c8ks88o5o+i5Vs/Y7HyacyhzF4TE2tllYos27Sd5RGBOe+0a6kn2QQJ+PEWDJZBvpEZiB1mJc4drWhkqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761502945; c=relaxed/simple;
	bh=8D5yaBNoORZTjw6kCzlvjtMnwf2Nw6k/T84eceynYyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VX0FaQK2hrU8Qcxq4QQxArrkau18MUR61m+JANvPhIOBIu8SXzOab1ydi23zGZJ7ao0K/oWfEIH+DVOEDb7fz8Wgida3XODohj/i1UVnYWuk5UswA9L3Kqwa4eV8O9q0OIMRia067ATcnA3NlFGkVLweomRN30MzhehBEcSOPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrXQl9tf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrXQl9tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69EEC4CEFB;
	Sun, 26 Oct 2025 18:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761502944;
	bh=8D5yaBNoORZTjw6kCzlvjtMnwf2Nw6k/T84eceynYyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrXQl9tfSD27c7Z8V6xmI1K+BHriwIBFaEIky7BUctjW6S9ZqGYYE1bOhPPniqZVB
	 L3riMN8A5k0Z8xn5kQXXJXW3oRdTsvdNe5oK3eUp7jlH1bVO3kG/WIIiu1LkkceVGi
	 +i0dzpS3yDFNwvb0jLOxPZxn+jVBgteRM6dMdWjqGrrBZbLDMfGIQ2TL9q1L5ECWYa
	 +NOu0R10XMorUUU7W6UZeYKagpAPUFcMJ8/s+oGJuhwMcjJ2+6lU55Cg7nRdzbxwB3
	 Vx+vd6DQ8204ArCRkZANQXgLdU6kTb2BqzoJM1hY2L+XYWOMwIOzVvC6gGdVIhzSKk
	 Iw1IoQL2gaWgA==
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
Subject: [PATCH 5/8] Docs/admin-guide/mm/damon/reclaim: document addr_unit parameter
Date: Sun, 26 Oct 2025 11:22:10 -0700
Message-ID: <20251026182216.118200-6-sj@kernel.org>
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

Commit 7db551fcfb2a ("mm/damon/reclaim: support addr_unit for
DAMON_RECLAIM") introduced the 'addr_unit' parameter for DAMON_RECLAIM.
But the usage document is not updated for that.  Update the document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 .../admin-guide/mm/damon/reclaim.rst          | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 92bb7cf1b558..552a7786b082 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -232,6 +232,28 @@ The end physical address of memory region that DAMON_RECLAIM will do work
 against.  That is, DAMON_RECLAIM will find cold memory regions in this region
 and reclaims.  By default, biggest System RAM is used as the region.
 
+addr_unit
+---------
+
+A scale factor for memory addresses and bytes.
+
+This parameter is for setting and getting the :ref:`address unit
+<damon_design_addr_unit>` parameter of the DAMON instance for DAMON_RECLAIM.
+
+``monitor_region_start`` and ``monitor_region_end`` should be provided in this
+unit.  For example, let's suppose ``addr_unit``, ``monitor_region_start`` and
+``monitor_region_end`` are set as ``1024``, ``0`` and ``10``, respectively.
+Then DAMON_RECLAIM will work for 10 KiB length of physical address range that
+starts from address zero (``[0 * 1024, 10 * 1024)`` in bytes).
+
+``bytes_reclaim_tried_regions`` and ``bytes_reclaimed_regions`` are also in
+this unit.  For example, let's suppose values of ``addr_unit``,
+``bytes_reclaim_tried_regions`` and ``bytes_reclaimed_regions`` are ``1024``,
+``42``, and ``32``, respectively.  Then it means DAMON_RECLAIM tried to reclaim
+42 KiB memory and successfully reclaimed 32 KiB memory in total.
+
+If unsure, use only the default value (``1``) and forget about this.
+
 skip_anon
 ---------
 
-- 
2.47.3
