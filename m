Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73C403AFD;
	Mon, 14 Sep 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397104; cv=none; b=WGRILJISON/YvZnmW955eqS61pRIop9hhzCYZNXMUzvC52CKsO+HZWjMthS39H2PsHreVYjTugltFZsgrd02c/kNuA9xY0afewrCcLydZzYBnf0HJZZ0IB+vBsd0WxBSW0AfJLz+ZzI2In2M+XNJP02Pk/Ss+CC+F5e7UXLm29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397104; c=relaxed/simple;
	bh=6622FqAoJyylnw82hdIzdoflo9b7IhzEAZqdmcHMO9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2VKPFXA7JPm/Otg1Y9sPXrs94MRVN22Cbd8+gqbKRp6LeUh2BtlBMKKYo+z4LfXdNaUPebslVlJdVgYTve7BDnKpdNG6dfoEpxKvbrwjW/Yr2yamRwHcqk8o6PBU1Fosk+aXq5+Yw/SbjdAsGmlEu07dpwMPmDb1IyaSnjEq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ4BIdI5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ4BIdI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB6F1F0089A;
	Mon, 14 Sep 2026 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397098;
	bh=KlTkThYMNDC2bLrO2MA1hCJuFVsV7BXLwZ+Px5RpEUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AZ4BIdI5O3hJqwLDTzpdnlXAJJ8z5jmnuGpDAmnV9v9bxOPtFQHcFG9lgURso2RHk
	 BIg+MpMzQ/TAsnLTVbVxSL5Cmxt/NaebNIucLcvwN4X/3CufGd4o/mNCkCk9zpzReL
	 mTkDPQE32ASU1w/wPwv7mC9dEbsC7uY/l8Gabedtm4AnkBnWdCWYvWehOZl8ZmOzD0
	 Fz/jEc/joTy88BjTUpf8K5ImN4g4uDXyBJCxvNrqlN4PEXz2CflftdTBqDSk71cC9+
	 nBBOB0pOpis86iohGXrxEkxXhx5jCYtswugXw/Za3//v45QzwZ08MZEK6gxVfP9Tif
	 CpwngOKfFPeGg==
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
Subject: [RFC PATCH v2 6/8] Docs/mm/damon/design: update for hugepage_size probe filter
Date: Mon, 14 Sep 2026 07:44:43 -0700
Message-ID: <20260914144448.93732-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914144448.93732-1-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
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
