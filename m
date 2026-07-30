Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094382BEC2A;
	Thu, 30 Jul 2026 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386404; cv=none; b=PJq0WPX5QTlIqRew5B6Gu72j2ghjO6UlDo5bSCEDTTeLZMJSDHAo1FVB6VlhGq9VJ/bq86VCS5eE8rJdfWWWFknr1NbbKg46ZAxFjVuaWGHcby6prV5pt49mOcq7uNgy30BkLxjVC7tZ92hZscuzNSlJKmxESga7zc9ChSmSbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386404; c=relaxed/simple;
	bh=fxU+kl/M3exfDLzFkdNJVMJXwSy1c6L92KGmpdS7j5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bifWFIdyrg5WvTrOCsu6BsF3nLoQtTuR22SHur8pRcE/ndFqeiV49U7LlA87mGZGlEv62suzYVMBp2RHKnRF138/uMNgN0eQzMwFaHYyefwpccptFNYLyprWN67w1LrKHx3xQhfB/4yseYIAh0st02Ht/yfi1DR+wmTvED7LLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX7CteAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX7CteAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5891F00AC4;
	Thu, 30 Jul 2026 04:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386397;
	bh=PRRcJRQPR3buBmMaDcVwulWeVM6qSbo735r2+CfQnW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MX7CteAlQAT5vgl3TbIhGQK+ASQYMO9ml8Sfx4iTLr+6fRM4u22WYD5qTDS7ctPam
	 libpPlwZnJmgtYgP/rPAd7EPf2B6LC0LvxEh1eeZkRr+RFSgr04XGqrY0GxZTDd74u
	 UMNnKri81St0IyLHiplr5f/Wt0YqHwh6J21BigfSGtOKVDGtkLzdoYSsF3UBzfOwOX
	 RYile5ciWowCFc82keiNlQ799IURoZieEh12fOlAES5vaU+Rl1AcG2lxZq1xF2We7D
	 417nz5OrPTwUgiVwL6LP5OR/euG6cMCRM6sE+d44SO8xee3XZBstuAaajakV+w0eLU
	 COTHHkoM7Youg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 6/6] selftests/damon/sysfs.py: test damon probes
Date: Wed, 29 Jul 2026 21:39:43 -0700
Message-ID: <20260730043944.146030-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260730043944.146030-1-sj@kernel.org>
References: <20260730043944.146030-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend sysfs.py to commit DAMON probes via sysfs, and see if it changed
in-kernel DAMON status as expected using drgn.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 159cbeac067f8..66c826189320d 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -319,7 +319,21 @@ def main():
                 intervals_goal=_damon_sysfs.IntervalsGoal(
                     access_bp=400, aggrs=3, min_sample_us=5000,
                     max_sample_us=10000000),
-                update_us=2000000),
+                update_us=2000000,
+                probes=_damon_sysfs.DamonProbes(
+                    probes=[_damon_sysfs.DamonProbe(
+                        weight=42,
+                        filters=_damon_sysfs.DamonFilters(
+                            filters=[
+                                _damon_sysfs.DamonFilter(
+                                    type_='anon',
+                                    matching=True,
+                                    allow=True,
+                                    ),
+                                ]),
+                            ),
+                            ]),
+                    ),
             schemes=[_damon_sysfs.Damos(
                 action='pageout',
                 access_pattern=_damon_sysfs.DamosAccessPattern(
-- 
2.47.3
