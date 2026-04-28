Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA630C372;
	Tue, 28 Apr 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340075; cv=none; b=IW9vPr/G5EBgbiWoR+zACZd8/wPU2UVuM55JXpPwBR2/P4LPmi2WOVbEjd7TpHqKKmHk8JgQMDLcIchNyY1Z/IbFj2HxP/jQN+xHmb98y48jdFK0izgfEvonV5nydXlIifjihuWcHzzTxKKb2TNj6rqWPXP3X6WglIlzmaxakNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340075; c=relaxed/simple;
	bh=t5zJdXrSXfUqeg8E0cFC/+8XELPbXvEetq+3G/tXFao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1AbmmqR6SluVyyxUDMkw/JosF7sd31mPZBNtMxthhdEupxDZ95VlUy5ID3DhVhKWfLAvTqjNJaCtCN9ydkkJPeTlK6XpoHBguW8kQlDEP9z8c5dVSe/wDFAW5fodAD00KQxVbCoeeTD4h/cE6Ln4LhhkXlWYVujz672nCiGvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4mrjTaJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4mrjTaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFA3C2BCB4;
	Tue, 28 Apr 2026 01:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777340074;
	bh=t5zJdXrSXfUqeg8E0cFC/+8XELPbXvEetq+3G/tXFao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4mrjTaJBTN0LzIRNCZj7pwECqk7KOMJnhlOtYO97I5PT+9fPxsDE/ysqobr7nWJ0
	 qbXfihTA4bcntw0PWuME1t4oJHc8ORBXew391Z/AL0oCpDDFjY9ugusHUixJlT4woj
	 Rq7joVjF+dQ3mWhvML7nPXUTEvV/geWePDQm3CE+BcTeAD1b5AI722A1C+U0scEf+M
	 gVcTladCAVdvf/ESfw60+Z5TtgwPgb6ZX9tB1ZQKHOvqVXvPHtM5ge88lxwn/ZZPvX
	 YYHgHh8hjxVSEKzmVn/B3IV+yfXjify48hbRUvnTdd6j6kgiWf4jWG8dgbDR32C28G
	 sb6qtS5S+kRWw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/11] selftests/damon/sysfs.py: test failed region quota charge ratio
Date: Mon, 27 Apr 2026 18:34:00 -0700
Message-ID: <20260428013402.115171-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428013402.115171-1-sj@kernel.org>
References: <20260428013402.115171-1-sj@kernel.org>
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
