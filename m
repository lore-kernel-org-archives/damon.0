Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3223AC0ED;
	Sat,  4 Apr 2026 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320797; cv=none; b=YKSRcvO3kXYqLtOD5uWANTYZvEScvVk87GY+lw+RLVX1lRAOj4bzSdDk5Zax5jS9zoR/45n9/okl4XZWeowL4YX7j/IiOl945FEUWDPYKm1+bBKj0iDwmQDkdLoSQv0F6cXiowJaT1+QZpWt2kWFZP82DOkMygDUDSNSx82bAHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320797; c=relaxed/simple;
	bh=6J24o91UAsIJGEgFo2jYtnFEeYvJuiRUU82+7XJIPqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxZ0wM8w98DH0bT1bDWmx5xLiqaeTJdabdqxne8ZYZ4fywHcOmpMN4gwCSJoBP00CKDF2TFZSIly6J2AUzFFovAMVqzYLLqM4yVQEAbF/tIGJzgtoFWeS/F9ilqMaZVZNqodXadm6XoCp6mfNt8ukzswfkJC4SZOveMe9SH7i1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQUJmd2X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQUJmd2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80035C19421;
	Sat,  4 Apr 2026 16:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775320797;
	bh=6J24o91UAsIJGEgFo2jYtnFEeYvJuiRUU82+7XJIPqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQUJmd2Xs9M6NmI0n1SDk8BUYsVgCqaSaiNWNu70aAJi2l3s6ppw+2vDbfzGCQZvA
	 Bp2nlhzoASKNWldlyeab3ffe0LXbIgPQbbKQX4kSHkL7k//sNISwgSUUR0DK+XqroU
	 tGKc5Gmv01Kd6SROExK1U05lQzJtgYcdhu3pFT619YC6l+1v+XQImoDQkWKVC4K0b4
	 7EDG0g0bUrYBThu7eQ9S94p4l0zPdjXAXGzpzQlkh7eQB/aBCpSJTdAIYOxaeZFqcd
	 sKF0jmy5nS/42uN47SK4pA1cARMWIVNV3n2HgWaSg5wKMh9W3VrrWnFNv0Udi295s/
	 Od9vjjHXQ+Jyg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 9/9] selftets/damon/sysfs.py: test failed region quota charge ratio
Date: Sat,  4 Apr 2026 09:39:39 -0700
Message-ID: <20260404163943.89278-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-1-sj@kernel.org>
References: <20260404163943.89278-1-sj@kernel.org>
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
index b8d6e0f8fd906..d8d4717128898 100755
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
@@ -277,6 +281,8 @@ def main():
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
