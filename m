Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77DA40911C;
	Thu, 21 May 2026 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374083; cv=none; b=XuFbSQv7TlrmmlR2hh4CtMkuCjYbGF6+WXLuKOICU6ODr/EhY4qi+2rViqcCqzPEwcqVSMCSVMmzGgOV8L5e0hhk8hcmj070aNxhMzy0VECAP+LP6q7q5AQwyriY4syuC7UmvddrSgg2cHasIelceHc3OAY5DaBMud/a1TYtNNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374083; c=relaxed/simple;
	bh=GCwpp9tVndKgfB2xT0JiM24CGov0zLgkMw/jizl1l1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7PpoL5HUJy1g2jSDXG1Rc2/z/Gemg76A6BO2IprCti233lx6sqWbmuXcu26TkFLN1mdwC/5EinmpY61TFQJuSVaTVEJuLPjRK4SlFTDEcK3y1b+544n3tL/rvYx9YPvRSCsAaEUOszv1qXVaxJnD3mC6SD/Ps7tBcMqT6m4G0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F69e6r6B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F69e6r6B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6751F00A3D;
	Thu, 21 May 2026 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374081;
	bh=iEjjWBHpUcq7nMlrb1+WzxDoNOgxUnUZ3YjegNS7FQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F69e6r6BcRcQCE51aqZBQpHoeSZl4Kfu2dFiXgBh98s5RaO+Yn6I4gbHLk3B5vRX5
	 u8tLxKzx9/UVR+7qSApZxy6U1dP/Zbl7MIRYjdMy2UAnkRcd7Y9wog2fdFIyjHSg3G
	 7or+svTc+QKWIeUgNlnrqBuxykLisG9dL/1e+3ob3Jf0zrgY/YzEGKSprH3Ja+SPIO
	 O0f9feCV3NsgjC+qDaXUlHKkLqn6WbtMp2tlVQ6iF4UJ6KlBSmSTB8BG2g8320Bd8E
	 u1aHkZi8MVTrj9+29V5q0CG5V/6bzpsGCIGzumJck+xqaktUxXUvUyidlf71gkqcYt
	 foM+WcAz25B0Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 11/14] selftests/damon/sysfs.py: stop kdamonds before failing
Date: Thu, 21 May 2026 07:34:21 -0700
Message-ID: <20260521143428.83157-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521143428.83157-1-sj@kernel.org>
References: <20260521143428.83157-1-sj@kernel.org>
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
