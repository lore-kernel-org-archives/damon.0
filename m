Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7C317160;
	Sun, 12 Apr 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010806; cv=none; b=FAyiay3ksB75/Ny2akYJG8B5grvrmDkRuE/Fnj33gaPHvsHirZtss6biclmD6TyAw81+0Cbz7oAwok/+xglpcVkLDqyQOGoEbeloT/jaQHF+jNpj44RihKw6yGkyNvnnwyzU9d3UwbRkg0zTRqlTMWzP73NULA8MSoQ2SljlR8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010806; c=relaxed/simple;
	bh=t5zJdXrSXfUqeg8E0cFC/+8XELPbXvEetq+3G/tXFao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XypoSWFsRmZ7pslV+XZRxLe3B5t5qTLBBSnzgSmi7UEuCkWSSh7uD3bToJ1ljZijrLndxpv+bcgHUB5NJHsILwVR9ICLyFh1gj+tRJ1piaj8ypGsHmUc1GnQHB7r/+parilHnctbi16YIoIDZOP56aNb+MzrH1V2yQ9D7z3ugpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgIR1Wnq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgIR1Wnq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4177AC19425;
	Sun, 12 Apr 2026 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010806;
	bh=t5zJdXrSXfUqeg8E0cFC/+8XELPbXvEetq+3G/tXFao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgIR1WnqGlS/2JgAAt4SyAiI6Mz6Y24ftLG/3lSrscUXV/UXc4lXwh0b3GVFWZx0d
	 PV6spn2SBCkf8mWpGADK9YnpY5LQLfvjx1gt0qD2qyirArEICcyWADdmKGqyX3phFX
	 bWQldELArzcWTUlyUpJayPkdy7p/0aNzNYP+KonViexTh0ZtwfQ+W52mshdEzf2o6j
	 JD6GlmQ72pJhXaST5RvDdqee0Virrk4YUmsxnqXBcGfN/sggfuKfwx0oxRqDm3sFmh
	 G8koSn6IO8GNVq956ZzMpPMglmZr55ZoJHdGBcXEh7KwiV7drYA+N3pGi13AF0XjMk
	 vrCnbIgJ0E0ig==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5.2 11/11] selftests/damon/sysfs.py: test failed region quota charge ratio
Date: Sun, 12 Apr 2026 09:19:54 -0700
Message-ID: <20260412161957.82835-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412161957.82835-1-sj@kernel.org>
References: <20260412161957.82835-1-sj@kernel.org>
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
