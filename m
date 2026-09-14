Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580347ECDC;
	Mon, 14 Sep 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395611; cv=none; b=X8VXVRauwyLeSg4M6bitMH8W/RvEU/p1Fgx2XElhmcBJ2aJSBwqEqvHBwVe2JaaE2Z+Jq0Wyg/T98Vm5F1BFkDSG2xj0IbJQ8QIeUJzJh14apuz34YEjo+lNgleWrBkynoHrd59PKiMpiX4gIKzhfqfZG74qmjzpll4XJy+Tv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395611; c=relaxed/simple;
	bh=oWpASUYUf1MQMHW4bMHsGYFavW7vYaxsR0F3qU5hKqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsZl9xziwKFm3WiSC2Tnzu1PXU+pSdq6SaIo8xo7iVFT5+410ci0KB+LptDz8VMTUGSEX/5uKNvrFBCk+w3ntRjhx4uYf3QZqaOBnV5nJT8g0meGYtvkM13C/9ox/tgTllFurGp7yL8D+CCIxCwrJv6s5EW3wck0hMpvtFrqES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLAJKd3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLAJKd3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA581F0089C;
	Mon, 14 Sep 2026 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395603;
	bh=dgI5/uHVhGU/u/lFuomzDRYuBHWw9s688+WF+gpTSJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LLAJKd3PZfZJLA2mghR2o10iU2ZFbouGRqCNO/Ce//Yu5KWtT1Fb38VyB0L08FCuA
	 ncSquZ0pmtNWj09L9+9wH2JgvSpzPbs7SgODgo6YgH3GSKvF/qjQlYeTePa6G5siUg
	 Bdkg6gHk7rP4yAUkljf3cR/u0FwM7Cj2fwmJgMDjiFuBju+cdwiJREDEMEH9yQgYbO
	 ET0CLVkg/JmOcmT9J9rFgy34S3fSuxjIQ0YUeeiTvpQJ9720JaTYJ+mHvdGA6WdHWp
	 90jegwteY51FeTim7QjFIXDEhCh7EoyJQSAdw/7FXomE+LQsrBn3qMa+PV60IZjwTR
	 9hmHyPPPeai3g==
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
Subject: [PATCH 5/6] Docs/mm/damon/design: clarify when qt_exceeds increases
Date: Mon, 14 Sep 2026 07:19:50 -0700
Message-ID: <20260914141952.91465-6-sj@kernel.org>
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

qt_exceeds counts how many times a scheme's quota has been exceeded.

When using the temporal auto-tuning algorithm, the effective size quota
becomes zero once the goal is [over-]achieved.  In this case, the quotas
are still set, so qt_exceeds keeps increasing once per quota reset
interval while the goal stays achieved.

Clarify this behavior in the design document.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260910112255.157012-1-aethernet65535@gmail.com
- Collect R-b: From SJ.
- Rebase to latest mm-new.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/damon/20260908175105.42558-2-aethernet65535@gmail.com
- Simplify the explanation.  Do not provide a complete definition of
  qt_exceeds, but rather explain only the increment condition when using
  temporal auto-tuning algorithm, simply to prevent users from becoming
  confused and being unable to find any explanation.

 Documentation/mm/damon/design.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index cb116a82ff20b..ad09416dfb21a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -696,7 +696,9 @@ There are two such tuning algorithms that users can select as they need.
   fast as possible, using maximum allowed quota, but only for a temporal short
   time.  When the quota is under-achieved, this algorithm keeps tuning quota to
   a maximum allowed one.  Once the quota is [over]-achieved, this sets the
-  quota zero.  Useful for deterministic control required environments.
+  quota zero.  Useful for deterministic control required environments.  Note
+  that the zero quota is a valid quota, and therefore ``qt_exceeds`` :ref:`stat
+  <damon_design_damos_stat>` will keep increasing in this case.
 
 The goal can be specified with five parameters, namely ``target_metric``,
 ``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
-- 
2.47.3
