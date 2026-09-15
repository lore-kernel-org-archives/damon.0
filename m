Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408D3CF21C;
	Tue, 15 Sep 2026 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438184; cv=none; b=B89jAi03nmwBENnZNQJXoUW1k7xinKpTo90dNjoiHNNDOUj8CXZdQUKPPK8aXTGlMerVXBVsCdssEhJLYeyaZ9akzfZUsOa9vxIEn3rIOf7RQXjx9+D8SxoVvIn0wuoNTbGxDf03+nRDiql4FNZH2vcrXUQzUBn94sNqyENp4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438184; c=relaxed/simple;
	bh=6622FqAoJyylnw82hdIzdoflo9b7IhzEAZqdmcHMO9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxodWENq+hDxKTfVdbUF1rTmHKOGbURFFsoai7t35y8D4Fndm/wB7zuJCMZWkjKVkTsVS91assTagvr6reRbx6t8ryL34OYlKOEDJv7d+LUjD5Y/wUTzKSMmTPCPC0ssw3Wa3kUFRkaaFavdSbPhx54DOhxdVtBDP2uY8qWhobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZEaR+tj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZEaR+tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F16B1F0089B;
	Tue, 15 Sep 2026 02:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438180;
	bh=KlTkThYMNDC2bLrO2MA1hCJuFVsV7BXLwZ+Px5RpEUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mZEaR+tjQZp302g4QcqxsMTXQ0mr5kYSEZDzn4TUhQeprL0iJn/7uPGhc/hTk6EJ4
	 R68Mfa561JYWg/IURyV6qoMK6+TJu/BqoXpZWp4bN3JGvHLXcabEReW5VCbkwHSmG7
	 GK6JIEvQXM9YrjkWQreC7YLvBlfPcKcy4ZCi6bNSmwm5ZUQmz0uS+Z2d0tpPfZgEi3
	 o6rdQk+Srftd/VuCLmrUXsH0IFH76bmk5wEBEPd7PggzZJO/DC1Chs8hhjkNZpQDQo
	 PJz2i+0ypqcyir3TWLs2BA1kGQLunjUWZoiZfhFmznW1HdgwQWbGR93Js2km4GTGet
	 QCEXGuX6zEJpQ==
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
Subject: [RFC PATCH v3 6/8] Docs/mm/damon/design: update for hugepage_size probe filter
Date: Mon, 14 Sep 2026 19:09:25 -0700
Message-ID: <20260915020929.102953-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915020929.102953-1-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
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
