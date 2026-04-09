Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2D3DCD91;
	Thu,  9 Apr 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744522; cv=none; b=nIEIehr+diA3epjI5P2SfU4/NABdpI/wYR1y4dZgfw67TUWIU26xK+sC2weRzNjf3beRlq3TbOO3wCY4FQjePkaCfX6hoC+JQPx6TTNl8iMBBElM7lgU+deC7JzgHLKmSrDwRLhj40XYS7GAg/Vk9Ao4lt+9kgdulOIqGhm0g9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744522; c=relaxed/simple;
	bh=6J24o91UAsIJGEgFo2jYtnFEeYvJuiRUU82+7XJIPqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN6/wRmZS+Y6k4GDqvKUzYMLUwDDE6cAph62Q/vtIDd8zLOByx++EVmP9+vwAvVmmXMtIJb/brWFHU2ByIS6NQc/EguL6f/apnSfjVLsp4k4FLE2Jt5eIuY+sEn5VfL81sjpy0sQQvi+MTbODAoyDT7lc3cNKfPcgoiK3yoqyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdiA08nz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdiA08nz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D0AC2BCB1;
	Thu,  9 Apr 2026 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775744522;
	bh=6J24o91UAsIJGEgFo2jYtnFEeYvJuiRUU82+7XJIPqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdiA08nzY42W5gcsPSMmrHmqg2Bmqq7dj8BUACOLHrnk6Kn0JuA+Ia3qL5/Jq8oDl
	 qJWRVf8VpFZr72rvs8jL9ylsiOx+kIvhPfMFllxLYCXRmEp8GSmKB8Lg8T2l335XHm
	 5UdTqOUm8Q25h/ErEiJC7XOQ+6Fv7Lvg1fzsvf/NcUSINQxhbEyya1A9LxCUtjsEhK
	 7i/eVA+ESe+DHqiopwO4nnOdnqBmPXAfsKAe1US1P92EmZJNoycW+fBNRhwXOuEwIF
	 GSanZCI4Ux/10Ecf0eKSk3iGO1ZT+pV4DaV91rh0WKaPRvnQAFdCZjKX+77UL5lKkX
	 /PdNjYpxW1rmQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 11/11] selftests/damon/sysfs.py: test failed region quota charge ratio
Date: Thu,  9 Apr 2026 07:21:46 -0700
Message-ID: <20260409142148.60652-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260409142148.60652-1-sj@kernel.org>
References: <20260409142148.60652-1-sj@kernel.org>
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
