Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450F3AB28E;
	Sat,  4 Apr 2026 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320797; cv=none; b=HmDUD4gPPhfTV1py1FWQtHh/uaKPCd85unvepxUatuS4iBVMahW+e6cvbmauEq1DBM+1DvFpgvHv7UxIk6AHAsr/NNNoikCyxphWPIqJfBO6bPXyF+SXcXJY83POwH0+wh/s/L684ArDjl7eL82AiigJOGn044A7TS77i7G8PiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320797; c=relaxed/simple;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWXcfQ1N0QejN7ni0wuJywhtP3HIm1FPjna0l4eNGg+hSJtmA/pw0NJCAZNmGWXd/Y1r8cyQKRDRdqLEpCdcqxIqabQ2kSbIG3UWdsRi6BDe+kmOaypyiK33AKzS7RqCYmdFl4eJN70qbAU7hXsiKYqMHCWsy1/PGV3oBUzRxAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT6/ux6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT6/ux6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B48C19424;
	Sat,  4 Apr 2026 16:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775320797;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XT6/ux6/kNBlrwe1htvhTNCAIEdGvUZB675ShF8WnwYV69I4kEYGumhF8fcLM30nt
	 pLu+X+dtJ29r04akzFiQ2klABoTn5RG5O3+LmflOWKWb2TkgPtH6tAkXqguD73SgdR
	 sNm/Z7PTonuFopFRXQwNi2OX+x+v19d5mXesf+e09vo3pe3U1411KDNPWlyVjphDcK
	 5puN9zg5KkLAmINXErz3Q5/PFFPSPzR4zIdWAlW5wyZ+dZ8uEWtrShQ4aw+kW585it
	 nWcy2XMmmfMR9Mjtqe9hX+E9Nl1Xw2NPMBWTSekLQ5OQgt7jqRPShyRB96KRuoBV9A
	 3baCqkZJLGBIA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 8/9] selftests/damon/drgn_dump_damon_status: support failed region quota charge ratio
Date: Sat,  4 Apr 2026 09:39:38 -0700
Message-ID: <20260404163943.89278-9-sj@kernel.org>
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
