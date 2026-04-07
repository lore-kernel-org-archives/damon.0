Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27AF23AE9B;
	Tue,  7 Apr 2026 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775523944; cv=none; b=muKa74tCTsOgv7y4Skctnf2CsYEtO1a7vwb+6YbJ6MNr9wIUy6OBQytBA13L0myjZqEgX9yvBf5uUEp4TWz/CC9aqrHHVcsz4pZ8Gsbb97YdY7l4euzafMo+O2sZT8FnoXSNNN6HrVIzP8r1a4HErAQaiFtVciD6dr80eZldNWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775523944; c=relaxed/simple;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzLY5UnTnjicMwr6nDXtwzo0ivbqymSZ4HNxX88mVUMpM4m5Y06+N5bQy79opvdj8lvEmV/gvURVwrqq9BIRJnmzoLVfw48idjvK1S+6qK1QZNh+GyWlun3jw+gJg6bU+XtdT/x9RetpVkmp0WDIzvGClqzB0qHdljQGHMm3n1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcfFgWl0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcfFgWl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E792C2BC9E;
	Tue,  7 Apr 2026 01:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775523943;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcfFgWl0wSbjxpNVJs8/dkU9XnwsM/Trq3uFVxnc/VzfDu/QnRptO3YCzH1Nd6bKk
	 Sdhu1R79eFEDSYMWVIcXjDRUaV/4HqF0/5FGh1oDPuL/hniuPauNKU56AKFhilUs6h
	 Qd/wzKUY5jZ2GYuiCxde6sEKTFSoUDBUGHxAxj8yurENvKcNLTSEKQugviIyVB1Xgr
	 BgrTRjpsz2pIvswFyA+M37irFMTduQSZ43w/KegrS5uWj60aX/xfnsuQH0HlKtYjFx
	 BQot8LH7qSHFBTK7kVfIXj8b0hy+7A0JiTv7SQgreod8grZMUQyoy8gUZsxaGkf2IH
	 wVGOdLY1mGHGg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 09/10] selftests/damon/drgn_dump_damon_status: support failed region quota charge ratio
Date: Mon,  6 Apr 2026 18:05:31 -0700
Message-ID: <20260407010536.83603-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407010536.83603-1-sj@kernel.org>
References: <20260407010536.83603-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend drgn_dump_damon_status.py to dump DAMON internal state for DAMOS
action failed regions quota charge ratio, to be able to show if the
internal state for the feature is working, with future DAMON selftests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 5b90eb8e7ef88..972948e6215f1 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -112,6 +112,8 @@ def damos_quota_to_dict(quota):
         ['goals', damos_quota_goals_to_list],
         ['goal_tuner', int],
         ['esz', int],
+        ['fail_charge_num', int],
+        ['fail_charge_denom', int],
         ['weight_sz', int],
         ['weight_nr_accesses', int],
         ['weight_age', int],
-- 
2.47.3
