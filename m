Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAC51356B;
	Mon, 31 Aug 2026 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188558; cv=none; b=AGnXZc41YtMHlhmz5D+2qeRf2nPR63s39+vgD/ROuG87/uMH5wZZXStmQcTESE8L3FJv5xCK+ZhZORo3pBP5brSNC2ffGk6orFx3f4YeCPvZGG5zXlp6w0G0zJqzI3xJ+hVZMpr2Yb2aS9qO4jERofkw2wNYM1HAAxe/sShu5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188558; c=relaxed/simple;
	bh=WS9IkyLIoDhqnmtPMHzmEZHH+zFH+nqwXWryqrjT36I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8iPkPf33N/HJv/yPcyV/IsdkIejGklxEL8QMPdrpw0bX2nGfzeNtxf/TFvf2WE3SeCi/Km1JrH+KgvRgpstqBti495N1W+q9Cdzt0S4Goo0ciKFPqhmDmSDon0gREjPIERUXqxSgjqeBGgnwe1czVREtCHwr4sAtwcwi8XwjV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLIlB6Sf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLIlB6Sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1F01F00A3E;
	Mon, 31 Aug 2026 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188557;
	bh=fP0OmW7AaCN1UBBu3eieNVT1hiNAdPr1GoBH/nwPos4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLIlB6SfpA8AmTf/M6tefYj3BeCtREJ4QvfdwfP4DPz6DdnexLbsxZLrTiYPJSBfW
	 KUYuEPlc4eGJ2e1oa7uaeuyF/DoZROmih/gY+20vA4Tzi90xWYOfwzC0+E7VL0/lDf
	 qu51ty0064PMl8WzWR0NSawth/Gf/7cyzZOeDoREMjLq80zC3I0mF4ZraAkAN7yv1d
	 NBaT3GkT/9lqzirq9o/PvpDmqya4XEoQxSkyz9Nzd7i4sPxsbJlfrfrUFkXzh+Ur/+
	 Gq/8OCXK62Eh+dayewVvEJDr+uhwHiEYQS3dDKfMmYa7ruPI5BkESAVGPtFo8xR7g8
	 i0LaH7vzQ3+vw==
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
Subject: [PATCH v3 3/3] docs/mm/damon/design: fix typo of max_nr_snapshots
Date: Mon, 31 Aug 2026 08:02:26 -0700
Message-ID: <20260831150227.83416-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831150227.83416-1-sj@kernel.org>
References: <20260831150227.83416-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liew Rui Yan <aethernet65535@gmail.com>

Fixes a typo (nr_snapshots -> max_nr_snapshots) and corrects a grammar
error.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 4 ++--
 include/linux/damon.h             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 74170a2285501..63cbb7b536da2 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -873,8 +873,8 @@ action is ``pageout`` while all pages of the region are unreclaimable, applying
 the action to the region will fail.
 
 Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
-non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots``, the
-scheme is deactivated.  Note that, unlike watermarks, even if a scheme's
+non-zero and ``nr_snapshots`` equals or is greater than ``max_nr_snapshots``,
+the scheme is deactivated.  Note that, unlike watermarks, even if a scheme's
 ``nr_snapshots`` reaches ``max_nr_snapshots``, monitoring will not stop.
 
 To know how user-space can read the stats via :ref:`DAMON sysfs interface
diff --git a/include/linux/damon.h b/include/linux/damon.h
index d3f45f4dcdafa..7b1b6050a8286 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -551,7 +551,7 @@ struct damos_migrate_dests {
  *
  * After applying the &action to each region, &stat is updated.
  *
- * If &max_nr_snapshots is set as non-zero and &stat.nr_snapshots be same to or
+ * If &max_nr_snapshots is set as non-zero and &stat.nr_snapshots equals or is
  * greater than it, the scheme is deactivated.
  */
 struct damos {
-- 
2.47.3
