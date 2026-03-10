Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0530E84F;
	Tue, 10 Mar 2026 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104741; cv=none; b=PNyVMn60Eo+Jwv4oLF69g5cWSYMB3ZQLAkQW4pUZnOvxhbdm6RiZGEGXeIdAwv792sLVeNbIcyUu4ICCb+7zTt24r9ysNi0FQxPHuYxCd+Oo8jGvIo0y1HeQq3wS1bG8TKkINsVNYVM/aEH0RSAPvJGAZEJjteqBbskI36wErpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104741; c=relaxed/simple;
	bh=AVTjUet9MVkl4nT/vo+5gBPPg8P0HSyE/9BxBCU3HWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YutMvdc5Beex4VUi6SaV2B5cDJEC0OPAt1FS1GKJVd1OyBNF9NT1Zvw31dzMaGDCYsdcULIW34e1fLlVouhmTQcVsEKmB17O4tat/vHLXLbvS5IzQSedGkSxGOoyCYLlQXbR/OKWzD++phuLHIUmEd5fmgls5Uk+nWWp9wisrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIvhq/+h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIvhq/+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5CBC4CEF7;
	Tue, 10 Mar 2026 01:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104741;
	bh=AVTjUet9MVkl4nT/vo+5gBPPg8P0HSyE/9BxBCU3HWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIvhq/+hQeYCPKpUSP8TXJy821rg4ytdFyEXUI+ixQkl0TJQTits7tVebKPesxw/G
	 Z5HLBb+unJAdHwBLWUZ9NwpWhy9/nbURcBYGy4TFR+nTWjz0Op1C4yNLZqB5xrHNAa
	 9GICtl/JDQ8jxO83MGZlTlmcP2I/qfoadPJ1D6tQBnZlPwFa313go/OyB/OZR8Hwvp
	 XnRGjlKY9wLyxksizKapi9IEDDkcQXL0KvvgurJursHtUbUWla7/5ieBF7RFh8aJBo
	 YkX+ppKXbjeghAvFx20l1dQSBYCfG6GcBb6AHtYhALLXmiUxGRTQA+lf6oq3UGN5YR
	 c5La8jwN0cClQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/11] selftests/damon/sysfs.py: test goal_tuner commit
Date: Mon,  9 Mar 2026 18:05:27 -0700
Message-ID: <20260310010529.91162-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310010529.91162-1-sj@kernel.org>
References: <20260310010529.91162-1-sj@kernel.org>
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
