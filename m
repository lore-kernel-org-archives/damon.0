Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36823B9D90;
	Sat, 11 Apr 2026 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775926171; cv=none; b=AMz68Rq1sHdm5SylJtLzWJdzUhoPizzyjLo3sNQ9N7AiDLziUeYyZmFRUYCu6DarsF8ecPIJJXWUi+Q4RHHT4lcb3/bPn4n/W1qbNEzKGHqFashAZ47Umvsdq2Qcbre5VCP/9qn3kicLdXGLcjH2Q/UchdeOH2iXdeqCJbA5qL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775926171; c=relaxed/simple;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C35DDoKTBaguvKEgTQM2zJpX4kSq6hTV/f0gkaxVuAvXHbRtp8Jw4JpSYyiiy7jr6eNyp2uqRa2CvE9vrJlrbw95EiMPVnKOWrBMnXS/P6iY84ch7an5+3zby5exIGJJsf7WDyijd7jgd/Mo/AyIiFaie9N+JCZjw0F7jN1LdZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSRb7Nlj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSRb7Nlj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC73DC2BCB2;
	Sat, 11 Apr 2026 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775926170;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSRb7Nlj0CEuMqdwPiUtYj22j+aidCrKfQCC8QHJuMvsYqksw1GmtpdoD/xP/t0QC
	 CF1SK210iYJtgmuzwF47hQco2usECeUMcf+yUG8Wk73AoFuHT13Wi49y5BeyqWEDDJ
	 1I69N0PCOvRgjvZSlZvIDPYBchqKxkw1UBXzZdsQRF/Tq9G6Xvfxo9duVtWnlwdjjB
	 UPZMEDsBdeV9f7CdPZyszS5Ahiuj7P6L97HMm1gvy70VqQ6tQ6SDrK+/Py7sUEdD9Z
	 jpTmaXLfZ7PHYkUZh1kB3sysKvnlhthcam0DTrK8AuVeapnowo7VFO72p+lGPtreCU
	 JoR821Rqic3XA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5.1 10/11] selftests/damon/drgn_dump_damon_status: support failed region quota charge ratio
Date: Sat, 11 Apr 2026 09:49:03 -0700
Message-ID: <20260411164908.77189-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260411164908.77189-1-sj@kernel.org>
References: <20260411164908.77189-1-sj@kernel.org>
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
