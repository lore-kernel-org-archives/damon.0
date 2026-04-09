Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675103DC4D6;
	Thu,  9 Apr 2026 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744522; cv=none; b=SSvDkEU4+I0MXYO97rROTpCP1VJrUZ6QnQTfGvFou9MUShYrwAbpoWou3v0kdNce05rQGoVVjorroIwfGyH1+eZpLi6zuQNIh2dPyd7XCM7OGW7T8Spy5v0sQmYUbKWNXPey6wRJrJW0Oo+lEBW/S2pqH7e40BCq7pZ/cO2kdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744522; c=relaxed/simple;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nkk54mKEZK5CRh5lzsfw5XXpnllK0gEM6g7TGsB7hXJtHPlb6vB6rDmvVRPj/Z49waw0nzJhtTIoNLct6ST++dllNIzF5OZve2qBIaO1jckOPpJfwqTKNqfnX7ywcNe3W633vdWHcK5fiRahR9wSIYCQ1bWd2Lt+whqKOS995RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oalTStXa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oalTStXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0233EC4CEF7;
	Thu,  9 Apr 2026 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775744522;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oalTStXa4K5sBORw1mgSQoL+F9f6rKw3CicXIy7SO+yYgNunmNGoW5ehkeP7pc3Uz
	 XmkeAD9uXFl3BVeVNireldkfkTGWCdmdCC4rrDMnmDtdEACASjPNQ7WqwZsKQlWeg5
	 qkNMhwrsCV3TNRI/PDe+o7bFihoabLQlFdsb22SbyHI0VB9/msGKWrVqpysKfM0SFw
	 lubyQ0MPzvoi+oby8P2uIEtlDoZaItQeQY3Wr9Ec/3V+O2CkyWYm/GC80X50YWGuZC
	 pc55uYmPg3yoEMO6Fuix059rBMVLLN8kDFnWm/TO/QZPYsnQHx3y/Dn8jdDRaIGX9Z
	 FPgvBHB2iKNvQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 10/11] selftests/damon/drgn_dump_damon_status: support failed region quota charge ratio
Date: Thu,  9 Apr 2026 07:21:45 -0700
Message-ID: <20260409142148.60652-11-sj@kernel.org>
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
