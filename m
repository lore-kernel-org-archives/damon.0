Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C723D5659;
	Fri, 10 Apr 2026 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830849; cv=none; b=TMNItEnR8LksRAn5lEWiVkXZQD1mSF7lpz5PfeUiSfr4pUM7GQAJTk2bPnzTtXy3lW8zNYJi1m0n2b73mXUUN/eTGYDS2kLNyCKVDOdx0Ajydt5SIb1LdGw534xqqQAbYGzF8aEaWvuS4mUZbEg6pF98jdLdBNyVbKsIN7ghPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830849; c=relaxed/simple;
	bh=t5zJdXrSXfUqeg8E0cFC/+8XELPbXvEetq+3G/tXFao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dm+bwEgcMibcYzaQhK7TExOqbWGAHqkc1Pl7GM3AwV2n7cFpxMoQHlRGkK3O7z56NwbgTO22T87ZEruFmh7upRtGOYG5P1A+F1d9rx1uBt/+8uaYL/CxYt0f4fXUJrIW5N9B/HkXlaPlcui4qD+2nTU5cbMvOgSLGUt60wHxLnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8rIT6g9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8rIT6g9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB940C2BCB3;
	Fri, 10 Apr 2026 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775830849;
	bh=t5zJdXrSXfUqeg8E0cFC/+8XELPbXvEetq+3G/tXFao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j8rIT6g9MoC6gWi0YoXdTGZJ+Mj4RyQ2nPugKSU7F4vLAllG9GA18qoRQPjGp0hFM
	 CPa4oNRltpHL31jqq6Q/gNyEvh9DWo9kAQ2gybxgUEyGJR0FmmQxEztoA9tZevMtYC
	 0zBjKdAdetGEo8Yka41esJRrCdtRETVCmyAjfvosdmmZOXR+JgwtmyN7F2QDt5JFb1
	 bsUyWjNGlqewo1JdJNtVhwvfjvvz5hI1b8U8FLIXwSDfdvUyNXQ9nIUI1BVPQZ0dW/
	 +jIwqbi/wFQQQpZVltZo1Qcxc3f/Bwxs8hQWEARwhbhX7m9t/+NtTOlpa0XEdRHtbO
	 bqwxbiW2KL76Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 11/11] selftests/damon/sysfs.py: test failed region quota charge ratio
Date: Fri, 10 Apr 2026 07:20:32 -0700
Message-ID: <20260410142034.83798-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410142034.83798-1-sj@kernel.org>
References: <20260410142034.83798-1-sj@kernel.org>
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
