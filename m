Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A687447886D;
	Fri, 22 May 2026 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464440; cv=none; b=PvMQ+kGU4TvXCKXTM4gyuyDsu0LpksXxd5ZG5Xm78ZPMkxwO6mYOym9N/KRUFMKDCTarDRZGkgiPBKk/iLR0q/XMXXDNGk81ou6WNO/z6/FrKcy9hNRMtjhg9q2TirJ+UHVn/C2g1FyrSWpuS0JCXqa6tDYy0Hhg0vJT3xpoyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464440; c=relaxed/simple;
	bh=GCwpp9tVndKgfB2xT0JiM24CGov0zLgkMw/jizl1l1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+KKs5vi28P+NKULdNUfwX04NbwbuBaf2qeasPM4WNgRUDIBJcQxWnAEBBL1ObtdCOqIgWlbXLPHfBnHu5iT12f7c8gPBVNN5+rEdCm9sm9owzJEZckEqxMMfHQfYKN5gPIUX+n6J+ov9tPRXN4xZa/+LlV5QJ1z4jQc/MLW++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVwqsxAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVwqsxAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559E71F00A3E;
	Fri, 22 May 2026 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464438;
	bh=iEjjWBHpUcq7nMlrb1+WzxDoNOgxUnUZ3YjegNS7FQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TVwqsxAI4/lGot8Xjb2P/G3c9J9Sx3LWGIwYxVqK0iN46+14cuXahZPlKbf4vzFKj
	 SODgre67n8HKv7rlkp/4p5c9NLvTgo2Il+k40IDDUho0sYSVZVCoQojDCljAZRve3f
	 07NaH7dNJxSV2jLhaHrzDqJMp2s/VFnqf8F5eH2LtZmp+fZQvtNPKSW4R8c9pv2zlg
	 86EE7ssiA/FF852zflSN3lS2worR9rs7wNsoHjPIGNRGUCgUuv57XiySpyzkN15caw
	 cCCwOs8ivYUj3w+FO2xWmg8XWTNuWocMUZW9Unf3CAwETj32hXz6u21o7xFuu08B4K
	 ycfGKnpwqEHLg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/14] selftests/damon/sysfs.py: stop kdamonds before failing
Date: Fri, 22 May 2026 08:40:22 -0700
Message-ID: <20260522154026.80546-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260522154026.80546-1-sj@kernel.org>
References: <20260522154026.80546-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an assertion is failed, sysfs.py DAMON selftest immediately exits
the test program leaving the DAMON running behind.  Many of the
following tests need to start DAMON on their own.  But because DAMON
that was started by sysfs.py is still running, those start attempts
fail, and the tests are failed or skipped.  Update sysfs.py to stop
DAMON before exiting the test program due to the assertion failure.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index cd4d82c852113..aa03a1187489f 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -24,9 +24,12 @@ def dump_damon_status_dict(pid):
     except Exception as e:
         return None, 'json.load fail (%s)' % e
 
+kdamonds = None
 def fail(expectation, status):
     print('unexpected %s' % expectation)
     print(json.dumps(status, indent=4))
+    if kdamonds is not None:
+        kdamonds.stop()
     exit(1)
 
 def assert_true(condition, expectation, status):
@@ -248,6 +251,7 @@ def assert_ctxs_committed(kdamonds):
                 ctx.pause = False
 
 def main():
+    global kdamonds
     kdamonds = _damon_sysfs.Kdamonds(
             [_damon_sysfs.Kdamond(
                 contexts=[_damon_sysfs.DamonCtx(
-- 
2.47.3
