Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C594192B96;
	Thu,  2 Jan 2025 19:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844506; cv=none; b=TBx2jJD5SCM3wAl0Y+MnXMqTp2eyH7TYdCms/rqM6uoVTOp1sUz5mRRgqiUkTKrCiVwGwYInwFM47XsNwV00oeLCtPEb+6igGHRg5kibUtf9qHiutVfFlES1Siqj5+h7QpBXr1/9XB5HN9uubCOVs/HYFIWGLhxYL55rkpi1iZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844506; c=relaxed/simple;
	bh=4/XblnIScbbgUAgFK7pLL4JlbO5Pquped+azNdLMH04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JUkBuDvKWmr8Ghi7gHxkTQB+On3bDsser+PdiX4S5YYrl8VFtGDhSAiOhcr/c8m1Fz3xzJv9EnNMgsS8MEDSW2vhtSv/YRT/ytg4YNHjxI5JZ0SLhhK8wutkNZzCos/3HOzatfEY5bnKOZ3rHRoZIws1SO+8aiDfyHp6PWEDBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlaNlt1q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlaNlt1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8238C4CEDC;
	Thu,  2 Jan 2025 19:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735844506;
	bh=4/XblnIScbbgUAgFK7pLL4JlbO5Pquped+azNdLMH04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KlaNlt1q/Xrnqg9KnIF0LC2RgX+Ac0rYTpw11hklMkfAH+IxAsVsRuJCJ5h4yXHLe
	 IfhtvCRALqjhqW1nvvDtp0Q/us47BbG5lAbxh8wH8u7+CdOGvO95WwZFNwSp3pdgV2
	 iKxRQ9X6q7XuGXlR/GV07BAQuIzTCQsqRrBwvUyqqdBbBJoYZ0OML/bIDrPJRTYwGS
	 5+9/kuIUoWmzE9be7bb1pLwsA7T5I5TSK2V6wUag6gE4vzlnBZFYe0UmHrTDD1p8ym
	 oFlbv/P89jGbMgaBZkNDW4oWBg/aD4tuUQbzw/sz3/DpxjFtbUHrPiWaQkOZIvHm3Q
	 hNAbNN++fIYbQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/5] Docs/mm/damon/design: add monitoring parameters tuning guide
Date: Thu,  2 Jan 2025 11:01:34 -0800
Message-Id: <20250102190138.47258-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250102190138.47258-1-sj@kernel.org>
References: <20250102190138.47258-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON monitoring parameters including sampling and aggregation intervals
require tunings for given workloads.  However, the fact is not
explicitly documented.  Also there is no official guide to help the
tuning.  This apparently confused a number of people[1].  Add a guide on
the design document.

[1] https://lore.kernel.org/20241202175459.2005526-1-sj@kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 48 +++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 0265aaef2544..cc405e15d1b2 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -203,6 +203,8 @@ This scheme, however, cannot preserve the quality of the output if the
 assumption is not guaranteed.
 
 
+.. _damon_design_adaptive_regions_adjustment:
+
 Adaptive Regions Adjustment
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -264,6 +266,52 @@ tracepoints.  For more details, please refer to the documentations for
 respectively.
 
 
+Monitoring Parameters Tuning Guide
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+In short, set ``aggregation interval`` to capture meaningful amount of accesses
+for the purpose.  The amount of accesses can be measured using ``nr_accesses``
+and ``age`` of regions in the aggregated monitoring results snapshot.  The
+default value of the interval, ``100ms``, turns out to be too short in many
+cases.  Set ``sampling interval`` proportional to ``aggregation interval``.  By
+default, ``1/20`` is recommended as the ratio.
+
+``Aggregation interval`` should be set as the time interval that the workload
+can make an amount of accesses for the monitoring purpose, within the interval.
+If the interval is too short, only small number of accesses are captured.  As a
+result, the monitoring results look everything is samely accessed only rarely.
+For many purposes, that would be useless.  If it is too long, however, the time
+to converge regions with the :ref:`regions adjustment mechanism
+<damon_design_adaptive_regions_adjustment>` can be too long, depending on the
+time scale of the given purpose.  This could happen if the workload is actually
+making only rare accesses but the user thinks the amount of accesses for the
+monitoring purpose too high.  For such cases, the target amount of access to
+capture per ``aggregation interval`` should carefully reconsidered.  Also, note
+that the captured amount of accesses is represented with not only
+``nr_accesses``, but also ``age``.  For example, even if every region on the
+monitoring results show zero ``nr_accesses``, regions could still be
+distinguished using ``age`` values as the recency information.
+
+Hence the optimum value of ``aggregation interval`` depends on the access
+intensiveness of the workload.  The user should tune the interval based on the
+amount of access that captured on each aggregated snapshot of the monitoring
+results.
+
+Note that the default value of the interval is 100 milliseconds, which is too
+short in many cases, especially on large systems.
+
+``Sampling interval`` defines the resolution of each aggregation.  If it is set
+too large, monitoring results will look like every region was samely rarely
+accessed, or samely frequently accessed.  That is, regions become
+undistinguishable based on access pattern, and therefore the results will be
+useless in many use cases.  If ``sampling interval`` is too small, it will not
+degrade the resolution, but will increase the monitoring overhead.  If it is
+appropriate enough to provide a resolution of the monitoring results that
+sufficient for the given purpose, it shouldn't be unnecessarily further
+lowered.  It is recommended to be set proportional to ``aggregation interval``.
+By default, the ratio is set as ``1/20``, and it is still recommended.
+
+
 .. _damon_design_damos:
 
 Operation Schemes
-- 
2.39.5
