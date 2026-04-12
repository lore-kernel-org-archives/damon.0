Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A643164C3;
	Sun, 12 Apr 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010806; cv=none; b=JDiHohOdYlikO2NcpG7/fA4pNYtfALDABtXDnGUgB4B/7d9RRFKTNpQ2XqoJqGIsWcleabV79bFc6DhNsfn0VjzS6cJw3HIiqQ/2u4/CLv58oB3erBzj56/J1OlFcUkVLE5uCHuf2hRsthMgSvosrH+WBqFmBLhSFyANC02eXgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010806; c=relaxed/simple;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3JMO8g9MAYsnHNqJlb79EPEqd/I+F8VDsvZA7zV2GrjC/mFG7iY2MsOBDMbb3iAcZhyKra9Db7sQ682s5+9UB8ZnBBJElTj3MKnF0Nt/I691f1vWmUdtysWbvVoHv2WZ3XICYf0PHy6GwvTj+e/YMerBxDu0oEs5f86NYKjF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf+a2hVD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf+a2hVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF2AC32781;
	Sun, 12 Apr 2026 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010806;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jf+a2hVDjrVEvCGNr6lCjPwS4jHq/0cEijEDJBeVzwrnsicQAQFsWzgYDNBLgmpLw
	 JZFy5ZIuVp3VPwczOeJxiB/R3KbaUqyz+8ST9N3sz2bgpaa75i9EM2A7aQrKlHIQr6
	 AYLlLkOXB0FJ5pXp2BodwDO6mh2YJjoiadkxZKO05Nty/s/gj8qB1GNI1ebsvrvp6V
	 4OX1R08hIznpWvvRb4PGnOGI0wpVZ2+gLBdXRjtgj9jAvSuT9zavW+7wc4ZXZhoYHz
	 4kTWcY5S5MDSm5ELXfLy6CqdfI66M5G8fvLDFY/Sqox9YHPvsGhjYi86YlAD1KJdPg
	 eEfdVGUwn4Khw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5.2 10/11] selftests/damon/drgn_dump_damon_status: support failed region quota charge ratio
Date: Sun, 12 Apr 2026 09:19:53 -0700
Message-ID: <20260412161957.82835-11-sj@kernel.org>
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
