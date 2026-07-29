Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A29495538;
	Wed, 29 Jul 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336468; cv=none; b=VUePziSVCzhRCQC7l2wmQkQYS4RbDpdS4A45B0GsgbxkeINQZMV2tAGG8DYwtDBop8vQZtohG7SrQbiiDYcG2fV9cWDrxZjRK67pIYctNHedmWRYOP2IcGWl94o4Fenkl0e8+83kzhzZydkyR2eX/xf0hDYBTa8uEyk6H/ILAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336468; c=relaxed/simple;
	bh=fxU+kl/M3exfDLzFkdNJVMJXwSy1c6L92KGmpdS7j5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePAKt94+Nf7QVU7KoRZNU6jDE0GarvgpUAzHwECKDa4zMFnHnVBS+mwdkyLQjNuxCzYMk4uFtsSQMDbzLeq0PZQn/pbH6/o9kUVZK2fFP82YFHf2CcUEFsnIwBCryWDnwGWfaWDWyp0eGA9NX2MbTjn7CpX995uZ7vyyRgoYP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgotZjgc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgotZjgc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38321F00ADF;
	Wed, 29 Jul 2026 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336465;
	bh=PRRcJRQPR3buBmMaDcVwulWeVM6qSbo735r2+CfQnW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZgotZjgcWhh/HHekUuR450+WnuFoBpIEPEnKN/COLJ7BI9rXBJRIIn2VOMwHETiPT
	 pi1qlDGztuEvmHpHXKH7i5gSQYMBEcLFpA7OpyFiFsW/24Ae0SqkQtAgRrW1DPd+Wu
	 7kdzvMnr/4GYdvm/S0YWdkbTnK95LhZ2hpVZVRarabtDYZh8JVaGWXmQ2GvPQ+OUHi
	 Isa7HoW/9S/LKiPxJOWAfRwTBxp1nZ/OWdFO1aEGHjBSG4sAPk3HyFbZH98EZmRK8t
	 BIHt6bcuWqXwaX1kp7mASyVBut0Zmj2O5I76SE8yLSUaB51XvzA67RETFrwcPkwAuo
	 LdZOLORa0Py+Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 6/6] selftests/damon/sysfs.py: test damon probes
Date: Wed, 29 Jul 2026 07:47:37 -0700
Message-ID: <20260729144738.90895-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729144738.90895-1-sj@kernel.org>
References: <20260729144738.90895-1-sj@kernel.org>
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
