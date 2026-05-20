Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1E2DF719;
	Wed, 20 May 2026 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240085; cv=none; b=Eh/rXgZzXa3e+x7BrBAiqCyAf7FgiiuAuG18sMGYcn0j6FoQQIYxcCvv5sy25HumE8Ki8Nl1341bWnlH3EQhSlu66RIDhTDXQnrH57rvA1L+3hmBYohV1+Yl0T19I1+67HIfvHS2N/lvRqTSZNS3UysMBTweP0RyCNH7kBv7Nk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240085; c=relaxed/simple;
	bh=pnGDXvd7RBcHHrxe6ZCdktDvhj8f7041d9RlsNx4PJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4UOLEULhkqk0/biPulHwCoxeYNdjulmpR1aHKrPGKLEtdFmeAWoyHTNpF8pZUet/PkqzBnXqOXF7mzmpETAAJxoZyN5W87gxaJrOdqNAVveN0HwXvO/WsdpbmQ5WpC24PBFxVmWdiS1vPJPwuUvLQdTGrd3Hc2lOGXmvI7DAnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8C90cYh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8C90cYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0671F00894;
	Wed, 20 May 2026 01:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779240084;
	bh=8DIDlUu8aFd2dbl3UTvG+BWXcnjPd+VsOywP93qiOuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m8C90cYhbtNtnQjxj3IDNo0d3iQhHzuQC2kF9hEyB4hjs/vc1cfJkyfVFm9/wa9t2
	 X9tChHOu3vN8T+EPmRMuCmVYIcEizWz0vAz8BG5LnegqOdlHQ9Vu1JVPBZP+JwOhde
	 CGxKxWUrhnAPlVmnuNRNgryETukOJCg+Ilag2eB8fyrQ2ESF119upzvXAeOzgRDkeE
	 iy0zHqMLvdwfHFGguUs4pWh9Y2gZWKzS8dbFgFl27dYzM0nBGl9iD7SCTy2ds3ziTY
	 tarG8cdr03rP+4QLD388y6sBItezOma/hL9Eq0YdqYJda1ov/wv+WQ1eK+G+ql/cGe
	 1DCeRzKfoFrnw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sakurai Shun <ssh1326@icloud.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RESEND 2/3] Docs/mm/damon/design: fix three typos
Date: Tue, 19 May 2026 18:21:00 -0700
Message-ID: <20260520012104.93602-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520012104.93602-1-sj@kernel.org>
References: <20260520012104.93602-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakurai Shun <ssh1326@icloud.com>

L140: "unsinged" -> "unsigned"
L371: "sampleing" -> "sampling"
L387: "multipled" -> "multiplied"

Signed-off-by: Sakurai Shun <ssh1326@icloud.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/20260517073433.3015-1-ssh1326@icloud.com
- Collect Reviewed-by: and Acked-by: tags.
- Update commit subject prefix.
- Rebase to latest mm-new.
Changes from v1
- v1: https://lore.kernel.org/20260516093552.8404-1-cheesecake2960@icloud.com
- Use real author name.

 Documentation/mm/damon/design.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index a24f9f00d1837..2da7ca0d3d17a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -147,7 +147,7 @@ as Idle page tracking does.
 Address Unit
 ------------
 
-DAMON core layer uses ``unsinged long`` type for monitoring target address
+DAMON core layer uses ``unsigned long`` type for monitoring target address
 ranges.  In some cases, the address space for a given operations set could be
 too large to be handled with the type.  ARM (32-bit) with large physical
 address extension is an example.  For such cases, a per-operations set
@@ -417,7 +417,7 @@ with theoretical maximum ``nr_accesses``, which can be calculated as
 ``aggregation interval / sampling interval``.
 
 The mechanism calculates the ratio of access events for ``aggrs`` aggregations,
-and increases or decrease the ``sampleing interval`` and ``aggregation
+and increases or decrease the ``sampling interval`` and ``aggregation
 interval`` in same ratio, if the observed access ratio is lower or higher than
 the target, respectively.  The ratio of the intervals change is decided in
 proportion to the distance between current samples ratio and the target ratio.
@@ -433,7 +433,7 @@ The tuning is turned off by default, and need to be set explicitly by the user.
 As a rule of thumbs and the Parreto principle, 4% access samples ratio target
 is recommended.  Note that Parreto principle (80/20 rule) has applied twice.
 That is, assumes 4% (20% of 20%) DAMON-observed access events ratio (source)
-to capture 64% (80% multipled by 80%) real access events (outcomes).
+to capture 64% (80% multiplied by 80%) real access events (outcomes).
 
 To know how user-space can use this feature via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:`intervals_goal
-- 
2.47.3
