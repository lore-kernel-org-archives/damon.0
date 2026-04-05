Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADF31326C;
	Sun,  5 Apr 2026 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775401960; cv=none; b=UUEsqoosYIAqE9IYUWKBt53BoiHbgwm3uPVz8HrVJjo8yBa8rbmGVYoT8yC39ZHmXNAcmWcje5pQntsKsdE5cTd/4dKrWetsnuwiUo+Ij8bx1UIclWCoaE6/2Y39Nv2oF6hwW7RFO89/xwKRLAHvkUIkubG+yYZYB99jAf1nBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775401960; c=relaxed/simple;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfAwNQKBJGrTlI3lUk/RLWXGzSLOIGgKfrdxyABbfTCzFcaa9jZEtYu3CgPXc+Nl6wAMAtQmKaUovPKKd/naFHTG2bg710Z4iQzfln6tZra+1EBBKgimmgmlNJdmmm6Q1t1lSpZWZeX+1ngkweTjQiiukI9dNbU5Na5C8eWltBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAhxzr1b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAhxzr1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A86EC2BCB3;
	Sun,  5 Apr 2026 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775401960;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OAhxzr1bnG9SRGkzpc/ub0X2fD7lRQkA+jDr+LOlf82Il7d0WZ0uWYwGgfTUH5VZu
	 0nhkRRCNPT85pSaMyrB5mGedggPtTX94tKYtlUFPsW96kt55LLkDr4vjQ/R6MQvNpZ
	 aifQQXagGzKeQVGaRM3W/UJ2lYk/O88enXmPRbAUl+9iIM7O7+6U3j4vDCASpdj3b3
	 bSLDvTtrjkJTAxO0DCeS1igoS1EGBNjUu3K6TAB/nm6jEb/j98dYMuG+v1HdFoQISE
	 ABX+N33zGMNfSyZgbCZdou0BWAbEUCXr9KOgoo1HX9E0hdvQftzxQ2LPs0MkIcIPoJ
	 hMWehmld3pwHg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 8/9] selftests/damon/drgn_dump_damon_status: support failed region quota charge ratio
Date: Sun,  5 Apr 2026 08:12:26 -0700
Message-ID: <20260405151232.102690-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260405151232.102690-1-sj@kernel.org>
References: <20260405151232.102690-1-sj@kernel.org>
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
