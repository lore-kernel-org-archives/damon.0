Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FAB3D47C4;
	Fri, 10 Apr 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830848; cv=none; b=hyt62FCTm1BIXCbbUU0iNpr9jxPVos3qidyXsAPH17gJOHWb3FoVWfKouRM2HqaWLTn7ZqDiRnMQtk4rQoxqnyvE9+/cNvCWNOhjMVqIpIizp5cfHbXO8WTku2zCVtIZwJkO0GsnsNgj60DHRn/XL7MyijDjTGq8LYfqAY2zLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830848; c=relaxed/simple;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SE8+H3+L6T9sPyrMmsgE5euA8kB+EQR/4EXQEpGEZ1f8n46zsIg8OcRuPFrGnjLUYPUmEL709YLx4XXuYgZj/7oklN68KI+hGXiTv0DFeDcWdHYwdCLIwRnzszKO9rYxmSM+4mIIQ1iXseB9wqUipeFPvyVX7J6X459JbYxp73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuGsGZkb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuGsGZkb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74922C4AF0B;
	Fri, 10 Apr 2026 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775830848;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VuGsGZkbe1hyR3qzbqlU38ZYoXwXJoT4kYB4ZCGYtauU1lIdqm80Tjr1DWCcZcd7T
	 fHwb4PVQO+JW+f2fNJbJjlnHTQuyd0RbQONudS7qTdZgo7hc3fr3j+ak6bYW/iSpE0
	 5V0/Xo1KEAvRTyJHbU0yMQpF0A9qXDIZT0+9Ix2kvTk7nhbas0bVUh9/IVmHxs1c+Y
	 l0b6txmImREDfHCT6qd7r1lBz20A5Thoflf2H15FPLG6ZC9PWxU95tcuFEC7Skflv0
	 t6T2oaJtGZ896sgU51fhPYMiwoE2oOM18UQPSMY7FuAd46rZSmXUevqvdVbYOb4nm3
	 wTn77/XW68ZYQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 10/11] selftests/damon/drgn_dump_damon_status: support failed region quota charge ratio
Date: Fri, 10 Apr 2026 07:20:31 -0700
Message-ID: <20260410142034.83798-11-sj@kernel.org>
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
