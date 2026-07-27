Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811FD389107;
	Mon, 27 Jul 2026 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163116; cv=none; b=TWpVs5V3sl5Tr43QS9PTtgy8Z9LUEQq+YsW2XT1J4TYlaBwBwf4D58ZQBvXZmjCKpKc4SfJOrkAKCWg0Xwa4wY1Xq/aV5H9eyUcRqXAlh0LsvseCguovDiQXMzCCyWxuCrwKWmBbW8wM8W/wiX90gbsuQGHC+rqgHZ1PCbjMcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163116; c=relaxed/simple;
	bh=BoQmFAANRs5ejoJBSDr2ocPVWNj8V5kOrKo+q+5Og7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvkWT0yuY3zOHtU60nLYGpAu0NHt6bSKDJVMtx8UoByGf8sXU2Z0h8S2oEHgCJLU7bBcDyxKXR+1C9QMtqO1sRJ4NedFtzDLq034OgSWFIZ4IIEmHhL7UZ2mZlArodxf0Ou/Zme9oeDd3vDND9B6abWzjmlgLH7l855V+4sT/RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf+I80LA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf+I80LA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949831F00AC4;
	Mon, 27 Jul 2026 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163114;
	bh=Qlh6y9Au18vR1Ou/T5ICe3OGlXl5Nc84fCTR2Y+rZXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nf+I80LAkKRd7P1QuxdT0ahWW1m3/tjIC5d3Lyv5qO6h7JRFrfG+e25ObO3z/tJGE
	 qBeH5KnZXbBvcaLhWDcEw/gwbLljpG74anL+H3X2y5NglYg/6nw0oM7hCfy6DY/6ao
	 hycb9VgwkzBpGswgxUfwZgvueAPdHtpvZFURSbTRbjmwRq84S0A9zh8fkBwFpWu0AR
	 P2yuFiOqK6kQ8oeAyHc/7AyOIerKD7lt9iC9Ciwhr6tWSO+HrnTUun0ZuLF4BX9ops
	 aiCbPaftTeQWTZSiuxZ+riD//La38XY6PfpLveEPmBa6gI0tyvEuj3EnqDlgEv9f59
	 j70NqIWsQJWSw==
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
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 04/17] Docs/mm/damon/design: document pgidle_unset probe filter type
Date: Mon, 27 Jul 2026 07:38:13 -0700
Message-ID: <20260727143829.86236-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added pgidle_unset probe
filter type.  Also use a list for the types, as it becomes not very easy
to read the whole types in a simple sentence.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a8c163475ef2b..c4830bd09498d 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -293,8 +293,12 @@ registration is made by specifying a probe per attribute.  Each of the probe
 specifies a rule to determine if a given memory region has the related
 attribute.  The rule is constructed with multiple filters.  The filters work
 same to :ref:`DAMOS filters <damon_design_damos_filters>` except the supported
-filter types.  Currently only ``anon`` and ``memcg`` filter types are supported
-for data attributes monitoring.
+filter types.  Currently below filter types are supported.
+
+- ``anon``: Same to that for DAMOS filters.
+- ``memcg``: Same to that for DAMOS filters.
+- ``pgidle_unset``: Matches if the page for the memory is marked as not
+  access-idle.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
-- 
2.47.3
