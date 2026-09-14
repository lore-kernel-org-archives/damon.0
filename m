Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904345FFA7;
	Mon, 14 Sep 2026 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395613; cv=none; b=Es+PbQ5gP9L9nQaw47k42QWjCSKNb9XJgmUvKx6osaVeXNeM633Lmk8h81t4d+w3AIXSz45o48qrmV5+pY/R/qSeNMMzDsPNCEm/2AEsVgW3mmLFOgwciPTQuiI/jM7kYbTFLsKt0HdelU4xcPD9UJHfmuhWLPrzzc7igXKsbc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395613; c=relaxed/simple;
	bh=nZ8sBxNQ7YWHi0+fi/Xtx2/lJzrripQVnCvJiQy9XLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBIIXV00DlFoIVIgi5O6J7f3a8PLJlP1E2Di5qgqJxWO0VAHsJ8plDeDG7TNC4aINafAFeUZRvDKQWJYNOGAHAIGkLmOOoOaJgLvG67pyECSdiQzcen76sOdPbVN9OuqNcWwoGM0080cCG21kKpinHFvXvh9Hti5gbwlc7JZdYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j05Pspcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j05Pspcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0891F0089D;
	Mon, 14 Sep 2026 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395604;
	bh=CPk8Tagd5GI3QkdQHiiyppe9/WTPuBoNQc9NjPN9Oyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j05PspcwD1dJGHyH/LYdc9O3hnSqtNkv2srUWvg+1Ke742GffM1skFmC9H3+a3ee9
	 b3fCr4TLPknIhl/o9FRyBYY+GDPpKomdzzROhn0xparyhpMRR3I8/Vs8AksRmrFxZV
	 X/u8bVnDC6UtTFFit8QqPZ9t8+fWwOo/PUyH3ErHCMJw+gGEtTfaQ8/1gjUCzNlfu8
	 cg0KsMyqJX94mbtU5GVIaTkUzPbWBDNVvYKGuPBnaIisCQ/H9j05pxUCDyUUBhO6EZ
	 l72feSfY7rOlHro2WMR01XgBStY8l+QwpVgFtmcd2z5bc66UU8Do8YGQ5wubhdUByu
	 WEyEkLQNdOd8w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liew Rui Yan <aethernet65535@gmail.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/6] Docs/mm/damon/design: fix typos in temporal auto-tuning algorithm section
Date: Mon, 14 Sep 2026 07:19:51 -0700
Message-ID: <20260914141952.91465-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914141952.91465-1-sj@kernel.org>
References: <20260914141952.91465-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

Correct incorrect references of "quota" to "goal" in the temporal
auto-tuning algorithm description and fix the square bracket formatting.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260911093314.156875-1-aethernet65535@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.

 Documentation/mm/damon/design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index ad09416dfb21a..707170bcd1b33 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -694,8 +694,8 @@ There are two such tuning algorithms that users can select as they need.
   This is the default selection.  If unsure, use this.
 - ``temporal``: More straightforward algorithm.  Tries to achieve the goal as
   fast as possible, using maximum allowed quota, but only for a temporal short
-  time.  When the quota is under-achieved, this algorithm keeps tuning quota to
-  a maximum allowed one.  Once the quota is [over]-achieved, this sets the
+  time.  When the goal is under-achieved, this algorithm keeps tuning quota to
+  a maximum allowed one.  Once the goal is [over-]achieved, this sets the
   quota zero.  Useful for deterministic control required environments.  Note
   that the zero quota is a valid quota, and therefore ``qt_exceeds`` :ref:`stat
   <damon_design_damos_stat>` will keep increasing in this case.
-- 
2.47.3
