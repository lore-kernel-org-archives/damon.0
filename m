Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27250386C2C;
	Thu, 21 May 2026 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335645; cv=none; b=sDphQoScoHqLVoQobv3AomfLEIPZgJkFlbQjN65QV7ennf/ahNW1XtGnrtcvdH9zI2rLcT9rQKxTiH87WsHQZH7PXr5/yONVfUS2d8l7/R+gDgP2VuLUdFhgylySlMXkRECDZfUYEljPWFWHzKNMjRulKfGl/EeYer8uTTIESOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335645; c=relaxed/simple;
	bh=GCwpp9tVndKgfB2xT0JiM24CGov0zLgkMw/jizl1l1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/nacjZTtm8FejJ+X9kiGfBNH8900otm0WIkXgrDGWXzZExOnlrcUQo9u1g6MXldDAh2Hrzb6CXQi/d56Q3jn49f0m4jadCl8exYOrdVysWFDjhHvJUrpdPYqG9Nmv9lr8GCeAImB3CsO9YgLXnUQu12dZSkGUDJG0aiUmSfaJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwHwqvHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwHwqvHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2781F00A3D;
	Thu, 21 May 2026 03:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779335644;
	bh=iEjjWBHpUcq7nMlrb1+WzxDoNOgxUnUZ3YjegNS7FQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HwHwqvHuE4iTfUsnnGzJKOLH2zxQ1Q5yirNcCod+GrrmVHGO2v64bu3g1g238SavM
	 OQq0i4Ws4Vd/Lyy0ObdczzVDaJnhfyqDd6H+q5arx4JqcbYBV6Im4Dz3OnJvU0++3t
	 lfSe1wD+jGIdQRiIGaGIVFdDj76DLqQfkoOj6qqAGwHDHvYKSq0q3kEeU9fD9fzc6U
	 fklMske90bAOKzi4wg/EGRuPLFPe8o/hn8CN8u6KgSxEIAUkuqh8m3RuQwWmSxIjGA
	 taGG63gGd6YHO3DDxQfhorsKo5AtqG+PEfX8pBKW9nmSyfcjTtHiTZXVOBHT2FjQOu
	 g76bvhaXeoikw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 11/14] selftests/damon/sysfs.py: stop kdamonds before failing
Date: Wed, 20 May 2026 20:53:45 -0700
Message-ID: <20260521035349.87565-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521035349.87565-1-sj@kernel.org>
References: <20260521035349.87565-1-sj@kernel.org>
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
