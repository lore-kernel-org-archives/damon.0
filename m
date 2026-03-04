Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751203803D0;
	Wed,  4 Mar 2026 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599290; cv=none; b=fAIo3dZNBOpw3zyLb446sUlFOMii/JSQORt8BeJxmFlHPCj7B3F61ouPXuGLm6CKwJW6oEGyBIuwoJIchaP2pmEjvxPYUd8yMiYGYeNmjPwSQjCrY3bn86kbvlc+eAN27Mb2rKOVL+NBuopwf+jrkjvh0HCJue62VNq5HuewzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599290; c=relaxed/simple;
	bh=AVTjUet9MVkl4nT/vo+5gBPPg8P0HSyE/9BxBCU3HWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTi1K3NQY56dyrD0lqTfys87G/b3Vnhx/ow+BlAgUGUUbEpE9Mu0ylVqlAukQnfUWKUUhmX+vT+VWHlGdwC0aDfhYC31gfqbuP4EM4FOE6BYtQTwgP/fpDw/hBtsk10LmElF5brHF7cqONr+OXgf++kDujFHHOtT9Mrrjl5Lpr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owu092Bd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owu092Bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41343C2BCAF;
	Wed,  4 Mar 2026 04:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772599290;
	bh=AVTjUet9MVkl4nT/vo+5gBPPg8P0HSyE/9BxBCU3HWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=owu092BdW9Ght3CUa+CqgGkZcipfpcKbiZKHQwtZs5mwggraKUlXSfK5aQE1ryiWO
	 kRy1S4peBQ2sKet+Q9ZKi8PzIxPpRE3ENPgEudPWnO7WRXv5tQIuBtbp2kpp6b3P+s
	 bUAcY7mvUnqXAMtx7mJAeIOwX2+C1IHfRXBE7GR8rW41Is0CHb47g6JxO56Ip8vtTo
	 10WiSO0k8VVuH1f955KMYieZqcF8T0jT+LEi4VG3XI0jjrb3XZ0WcYlj74/GtihrnE
	 WuyQFxKATb+Y3u6rM5p93iCur43EgVmQ9ZGHwYyVFXlOQgB17P0S92YAn5xn3vEo38
	 SXkk6NOVEqFAA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 10/10] selftests/damon/sysfs.py: test goal_tuner commit
Date: Tue,  3 Mar 2026 20:41:19 -0800
Message-ID: <20260304044122.79394-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304044122.79394-1-sj@kernel.org>
References: <20260304044122.79394-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the near-full DAMON parameters commit selftest to commit
goal_tuner and confirm the internal status is updated as expected.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 9cca71eb0325e..3aa5c91548a53 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -67,6 +67,12 @@ def assert_quota_committed(quota, dump):
     assert_true(dump['sz'] == quota.sz, 'sz', dump)
     for idx, qgoal in enumerate(quota.goals):
         assert_quota_goal_committed(qgoal, dump['goals'][idx])
+    tuner_val = {
+            'consist': 0,
+            'temporal': 1,
+            }
+    assert_true(dump['goal_tuner'] == tuner_val[quota.goal_tuner],
+                'goal_tuner', dump)
     assert_true(dump['weight_sz'] == quota.weight_sz_permil, 'weight_sz', dump)
     assert_true(dump['weight_nr_accesses'] == quota.weight_nr_accesses_permil,
                 'weight_nr_accesses', dump)
@@ -231,6 +237,7 @@ def main():
                         metric='node_mem_used_bp',
                         target_value=9950,
                         nid=1)],
+                    goal_tuner='temporal',
                     reset_interval_ms=1500,
                     weight_sz_permil=20,
                     weight_nr_accesses_permil=200,
-- 
2.47.3
