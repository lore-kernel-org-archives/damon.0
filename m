Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39278351C0C;
	Sat, 21 Mar 2026 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774116835; cv=none; b=sxVg7kQg12b0OpEELMsVd1QrWX4UrZbR7CENbOwmBNgDpbzY8bstrqjHAihQmSg5klHPk+QtfI8hIkPry+0e95misp+OBpUDuEEpFvBqSrT6mbRebO02rOu7wOF8ladQhnmzAd9PE3Abk6dVOSw0jlM6/TOCUGf6lFYqU6snekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774116835; c=relaxed/simple;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIFHAY5hDFenFMYn1ISUrUr5k6+4esQOS94t+AfWHRl5ZV4MTzkLRUt4aP4DbHK3QD0JlnBbu90bqmvwb+eS+kZMNLQuyoOtbC5mLO2lBburtE9Acyuxm5O72Xr5WsquF3Ik11Nd3mtqdfSimHUEwdYnT00lkCJW3X2+5dBNyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dT8d3GyB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dT8d3GyB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27ACC19421;
	Sat, 21 Mar 2026 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774116835;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dT8d3GyB6zVZkEyl72/a+qTGJXfgfCsJ9j16RcnhPKe/l0LMckmgt3mfnxQXxc+Rc
	 kKaUABp3Gr66ZXxL6g3/l/RA/8Vr0gNkOVXBZsLY2kPMiRTwCLdujJk17JHfWEnnFA
	 HeuUHtqKpvqiouN+7utYbwby20NbUcR9QMICVuSByCvG8+evIQhRfdXcCJ6C8ZYjgC
	 MU3JTo3mozQarP1bCTMdRuWiWPfj4FzCEpdda3dEzKeMOVI93BSApy++T51sahwq8H
	 6HaYMkAcoWpG1qhvxuoohx+HHko8iWEJmeuwpsw9/TPcfwo+FLOuQKLru9GeN1SXzR
	 Zacd51aK8ZiaQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/10] selftests/damon/drgn_dump_damon_status: dump pause
Date: Sat, 21 Mar 2026 11:13:38 -0700
Message-ID: <20260321181343.93971-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321181343.93971-1-sj@kernel.org>
References: <20260321181343.93971-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drgn_dump_damon_status is not dumping the damon_ctx->pause parameter
value, so it cannot be tested.  Dump it for future tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index af99b07a4f565..5b90eb8e7ef88 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -200,6 +200,7 @@ def damon_ctx_to_dict(ctx):
         ['attrs', attrs_to_dict],
         ['adaptive_targets', targets_to_list],
         ['schemes', schemes_to_list],
+        ['pause', bool],
         ])
 
 def main():
-- 
2.47.3
