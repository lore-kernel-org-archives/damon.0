Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA91B376A16;
	Wed, 20 May 2026 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258553; cv=none; b=pSD+vMBnnJhgKmYK75F7hGma/ZmKA+VXb2i9DdmFSEcuF2YndcFv8W5/vDlYVrvfk8xvVcl1XA9nBGSZ7QzAzJ/i6Zas8GeSr1PdhYqACo0cByW8E7+1Akk3F5ywerTu0YDA4LijgGS6qikWkfT+tnM2kxZfx+lhWDZ43L8cabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258553; c=relaxed/simple;
	bh=GCwpp9tVndKgfB2xT0JiM24CGov0zLgkMw/jizl1l1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAcItLv+YsGmMq7T8cQjRbxJYsUwesHTjxuhZBrQEYKfE8KsMP4uT4vmhmLlUKPJak4qyJM45aNIYzRmHWffbMgaycvZbvkYwukbmZcRzWWpsmdFwRjjD+iVB2lyBRt+rMJ7fqbpwY9c1M/JzNt04G/F/UnjMGMkZN8b/rsGKEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1WFFQ1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1WFFQ1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DBF1F00893;
	Wed, 20 May 2026 06:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258551;
	bh=iEjjWBHpUcq7nMlrb1+WzxDoNOgxUnUZ3YjegNS7FQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y1WFFQ1peG1tdIc3tQ50EmCXo96cI7B6rJPGaL/vd+YGsCEzAZMkk+XZs+tMCNzJ0
	 jdn2kyc7ycDQbESb2J8FhToujJgW7PNwRH7q45GZv6tRgBm8ycyrHjw8e80lIBg6vm
	 3qw4LIszIavLo3NzkMvWQ1i59RwE85f40znoRhs+3BMeRNAaa8gPYbuSvOHpUWS1H3
	 c3szwCnoAJ+5H9HRKLUeqnOGPFmZFspsIq71KKwLjgrfOeDgnDMLt1mSN2J27GP70E
	 p0icxGS+ftxRo5hzBHwUFg/TOwTdrQ18LdHMm8yMgRGzuQo52JiflzR5b3QJQZ155N
	 Q+Cc0p28kyE2A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 11/14] selftests/damon/sysfs.py: stop kdamonds before failing
Date: Tue, 19 May 2026 23:28:43 -0700
Message-ID: <20260520062858.167011-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520062858.167011-1-sj@kernel.org>
References: <20260520062858.167011-1-sj@kernel.org>
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
