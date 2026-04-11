Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D63BD242;
	Sat, 11 Apr 2026 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775926171; cv=none; b=KD3jEDThV98bO3bfr2grzzl8Fd+ih0FOGSN493p8G+LizKSfLClnrUpE9Yee+KX9csgasF1d5CzthfQexCsPpEfHgDSy1MICsMkWYQqfWguC/BQDjD3hBqrLXpQWidHKly/giLAbkVzEROnNyItIPDOHbH8BTNEjDupbs5aZQkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775926171; c=relaxed/simple;
	bh=t5zJdXrSXfUqeg8E0cFC/+8XELPbXvEetq+3G/tXFao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxLDaq2yIBeQLA0EUURNJqinwKNr+KAalySR50sfhrWwlbyFs/OvY5cddYeYk7qQF9NtgrCI/BZRDoFOoQlEvsC3/EG1S8lhvZGmz8IMu6uxGql/f4yp0uK3PS5U1TG1NaA9PSFRIL4gnQZX0auJXNtKIRepzeBDQmL/+vJ1lL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO1ZhQqa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO1ZhQqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1385EC2BC9E;
	Sat, 11 Apr 2026 16:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775926171;
	bh=t5zJdXrSXfUqeg8E0cFC/+8XELPbXvEetq+3G/tXFao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XO1ZhQqa+OnISM9rimWnjQKOpGTos1mrv87Cyt6aA1eIHbOBOyqBAASaeNPjbjsNJ
	 AkU/2tLKsI9/IE4LgCjK29GbCm8MrkrU/09034kNQKYEutm4rd/XUwfSz1BKM+dOLz
	 DOUbfmRkPg4FTjjJIm+Sy8voSRBc5UsWiAwb/15BNmVXIn2ykWImwYF188bKlHWzfh
	 D+HK99+iRyNguw0FHTYytRx822Po1gDTzNLAOXvFTLi/GYTRMLckql4WFFuklnzo5c
	 AkXg2lLQ6qAOatAVvhY2zlR3zOlIFuNgXedJ9jM1iXx7BDuDZXEFv81ysLNiXtpHtJ
	 w9W59dhBj1WCQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5.1 11/11] selftests/damon/sysfs.py: test failed region quota charge ratio
Date: Sat, 11 Apr 2026 09:49:04 -0700
Message-ID: <20260411164908.77189-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411164908.77189-1-sj@kernel.org>
References: <20260411164908.77189-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend sysfs.py DAMON selftest to setup DAMOS action failed region quota
charge ratio and assert the setup is made into DAMON internal state.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 387286dc449d5..cd4d82c852113 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -73,6 +73,10 @@ def assert_quota_committed(quota, dump):
             }
     assert_true(dump['goal_tuner'] == tuner_val[quota.goal_tuner],
                 'goal_tuner', dump)
+    assert_true(dump['fail_charge_num'] == quota.fail_charge_num,
+                'fail_charge_num', dump)
+    assert_true(dump['fail_charge_denom'] == quota.fail_charge_denom,
+                'fail_charge_denom', dump)
     assert_true(dump['weight_sz'] == quota.weight_sz_permil, 'weight_sz', dump)
     assert_true(dump['weight_nr_accesses'] == quota.weight_nr_accesses_permil,
                 'weight_nr_accesses', dump)
@@ -278,6 +282,8 @@ def main():
                         nid=1)],
                     goal_tuner='temporal',
                     reset_interval_ms=1500,
+                    fail_charge_num=1,
+                    fail_charge_denom=4096,
                     weight_sz_permil=20,
                     weight_nr_accesses_permil=200,
                     weight_age_permil=1000),
-- 
2.47.3
