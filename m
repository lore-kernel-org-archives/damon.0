Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F824B22A;
	Fri, 10 Jan 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736535161; cv=none; b=CBG/v9sLKEvBMicVW+MEmaLOtMlYLA8Fwliaqm7QZFvGxMuwuTJspysAummi2P6nDyuKsBdHx8sqAvUxg42wveOX8SWMxB9nwYz/PE0wyxa91AoS+xEjQrODRSYlIfImfHZGqLgq0OdHO7B73LyzYfJbFVZ5K4ICaRZ6qJdB+js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736535161; c=relaxed/simple;
	bh=OhiJLdYW/SZA1DPs4LYjgcwHYXKVNp0i99jYURYdR3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NwRbfqXVJCfiXSOXhgd6mIjkTVwHlxTm/thm8HsL7kROKFgOVcSJzoB1J9lzkWgVA3BpBXxaYlzHthMIINr26i4R0WbVmJdcQNvzmgMB927ydtYsgLYO4Bzo2veFUXeVm+Ro8WaHINOVc9HXEwvHjDeprlXIcc7zWbNjEnHvcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSdkNg38; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSdkNg38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D497C4CED6;
	Fri, 10 Jan 2025 18:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736535161;
	bh=OhiJLdYW/SZA1DPs4LYjgcwHYXKVNp0i99jYURYdR3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSdkNg38oRiYAiL0Y2handSc2PdlVRbvyiaLZ/O+joMpFP6bCxqOTZdMJ5SG+GfrO
	 XfzJamDF8rQnvYjJ7D4HltWOKGUCIb66WUyFp1oKFt0Mo8+zKE/r8llSzwzu+YKsb0
	 RFoHWE5V76uFUCn9zWR/t82ufSz3FeHDOM++OkbOqaGIFMsPR+ed2OrVTbf57+TTEI
	 CWlLTHtOo+skOX/YkTP2g8cfRkhhFJf0B5SULirlOaBuF4JPmJK/Lr9zO2Drl+4sse
	 UwQSQwpxXb4D7Z8VGFofM64eHuOQi7Opdm5hKv9kSJgEFbCn2ioMowaXfoeoX2NbwO
	 iwTc+D67NdTow==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/5] Docs/mm/damon/design: add monitoring parameters tuning guide
Date: Fri, 10 Jan 2025 10:52:28 -0800
Message-Id: <20250110185232.54907-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110185232.54907-1-sj@kernel.org>
References: <20250110185232.54907-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON monitoring parameters including sampling and aggregation intervals
should be tuned for given workloads.  However, the fact is not
explicitly documented.  Also there is no official guide to help the
tuning.  This apparently confused a number of people[1] at best, or made
people forgive DAMON without tuning.  Add a guide on the design
document.

[1] https://lore.kernel.org/20241202175459.2005526-1-sj@kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 48 +++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 667775bab86c..dd7e0f63a69a 100644
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
