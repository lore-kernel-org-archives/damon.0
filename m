Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094DC39AD33;
	Thu, 30 Jul 2026 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386403; cv=none; b=u9FraiCpUD7u3r9gX+HZlethK7jaosnuTzkoHuRiNCysG9eMzFPFQi/avai7eo/pdFP9JtK/HDiZVzsRG25s8y0WQCJaPuahBquM4JKtdrTWWkbLGKcuhyBqBmXsqjEoboa/TrLdzsaVQPPHMltSlZnGJNYxCxKbGo/kUtnoKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386403; c=relaxed/simple;
	bh=EyGYe1pU3SXAfXTYD4+UZCYXK73KxuSHWUw08aCr/9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9oB8tSVni86WMWFLjfgcoazw8z7n0NEqo3PlkOyWSp2sNTWzfNWGAnkNG20gHDgnIap4rWTVecvzvmKgdNN1AUaa4s6duPr1RFRs7lwajl8PcMKjqRpkYf71MOJrBePgnfV9yr9Lk3wl+NzJOpTbGdi425ELQbHu8drpzN8+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjyJPEFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjyJPEFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1541F00A3D;
	Thu, 30 Jul 2026 04:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386397;
	bh=nGhv1+JUPjQ740yCFrpuYKel7DV1kBFhSIfzEnBWQIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WjyJPEFd/o9hBdMuLnGy15VcNiR8AzeUgr+UnNXvRmFjT0rw2Xc5e/AJkzD0LVbVa
	 1t2s/YRQi+2njnmQNXnp4VzdQm5pNVZIyVUtLwg76y3uK9qLOg0fze5IFTzX8YB5B4
	 YjpokReYdY6kZk/wWNZnv3RfTsbor4MpOSw7/w2rN30f8qxpSurH/lKdNTV8AcwwdG
	 1L9kmE8HdHYAFDAt1uw/XICPDgghst03R0likIzJuoiRzMaNT6UAIc3OElIphlDSyT
	 If39ZmbEtNvW0ShVFBVSq17TYgTMG09A29EJojepJB54HVCvV5+MJAx8q2ifeCRLiG
	 UHrdM/G2SFlBQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 5/6] selftests/damon/sysfs.py: extend commit assertion function for probes
Date: Wed, 29 Jul 2026 21:39:42 -0700
Message-ID: <20260730043944.146030-6-sj@kernel.org>
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

Extend DAMON sysfs testing commit assertion helper function to check
probes too.

Signed-off-by: SJ Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 88a26422ff44c..159cbeac067f8 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -178,6 +178,24 @@ def assert_monitoring_attrs_committed(attrs, dump):
     assert_true(dump['max_nr_regions'] == attrs.max_nr_regions,
                 'max_nr_regions', dump)
 
+def assert_damon_filters_committed(filters, dump):
+    assert_true(len(dump) == len(filters.filters), 'probe filters', dump)
+    for idx, damon_filter in enumerate(filters.filters):
+        filter_dump = dump[idx]
+        assert_true(filter_dump['type'] == damon_filter.type_, 'type',
+                    filter_dump)
+        assert_true(filter_dump['matching'] == damon_filter.matching,
+                    'matching', filter_dump)
+        assert_true(filter_dump['allow'] == damon_filter.allow, 'allow',
+                    filter_dump)
+
+def assert_probes_committed(probes, dump):
+    assert_true(len(dump) == len(probes.probes), 'probes length', dump)
+    for idx, probe in enumerate(probes.probes):
+        probe_dump = dump[idx]
+        assert_true(probe.weight == probe_dump['weight'], 'weight', probe_dump)
+        assert_damon_filters_committed(probe.filters, probe_dump['filters'])
+
 def assert_monitoring_target_committed(target, dump):
     # target.pid is the pid "number", while dump['pid'] is 'struct pid'
     # pointer, and hence cannot be compared.
@@ -196,6 +214,7 @@ def assert_ctx_committed(ctx, dump):
             }
     assert_true(dump['ops']['id'] == ops_val[ctx.ops], 'ops_id', dump)
     assert_monitoring_attrs_committed(ctx.monitoring_attrs, dump['attrs'])
+    assert_probes_committed(ctx.monitoring_attrs.probes, dump['probes'])
     assert_monitoring_targets_committed(ctx.targets, dump['adaptive_targets'])
     assert_schemes_committed(ctx.schemes, dump['schemes'])
     assert_true(dump['pause'] == ctx.pause, 'pause', dump)
-- 
2.47.3
