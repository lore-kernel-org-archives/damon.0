Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217543845B4;
	Mon, 23 Mar 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307745; cv=none; b=gRBGCUjY7J9OqTeohzy6Du86dJ/oCcCDFXwax9DzQzhgiGhH094NPx0lz71uccTb6wOwas1NgBz1XSS9/U3FMz1EK/srISpAuglToBGwocDK0UGC9R7L1nAboZPwICx1Ttx04htva9sIgibLGSMm1YCmB+1J1ZfRL0ujj0IpDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307745; c=relaxed/simple;
	bh=O/0+EEFKC+kJrViTx1hpFrUcUp3ITetgY1I7Ly2ASvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3RoMsIoj1zVvYOsUJyEG6YifJHkL8zcVmUwib4kfcbOmPMG2sz63swGod7n8zJCkjsZBlaGqESvgc0M9MJzuvM/lL5SxfPPy6u06nluV48T7uc6+kmgLicNEC7lBccUlwQWENmvBnCDXUMdDQjJrkJhy3TsFHtdNWVBWll79cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPKMVkDO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPKMVkDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF53BC2BCC4;
	Mon, 23 Mar 2026 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774307744;
	bh=O/0+EEFKC+kJrViTx1hpFrUcUp3ITetgY1I7Ly2ASvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPKMVkDOLtco3B7ZLPWAa2M8E1Ji3gZ2aXUcvMFntuLnLoYLD8/IJ/KasrOEe1jVU
	 Zva7aSnjH4FY3VCXaA5PM/39iceh62guADzcpUrE7xkQa5ziIHHv1E90uONN2BVvhK
	 SEu2mFYHCYtNmGOZrPWf3UARAkKM81Bk1wpM8D2Q+yLE8/aRvvlmzw6qxePYZtGKXR
	 jyb9DKLk2vk1Bo7rHriQ6pZNjaldjP3Jmyu6j9nTLVSdB5gR+Yd3x+1nAPpfCUPPGB
	 3h9AIKo3zyzqRlyu3J5l0pmodG/xArbIuEd7T9IQoi0tgD6Tsb9xm6O3MDZwzmAgGQ
	 2U5cqTpz6dc0w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 09/10] selftests/damon/sysfs.py: check pause on assert_ctx_committed()
Date: Mon, 23 Mar 2026 16:15:34 -0700
Message-ID: <20260323231538.84452-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323231538.84452-1-sj@kernel.org>
References: <20260323231538.84452-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend sysfs.py tests to confirm damon_ctx->pause can be set using the
pause sysfs file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 3aa5c91548a53..e6d34ba05893f 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -190,6 +190,7 @@ def assert_ctx_committed(ctx, dump):
     assert_monitoring_attrs_committed(ctx.monitoring_attrs, dump['attrs'])
     assert_monitoring_targets_committed(ctx.targets, dump['adaptive_targets'])
     assert_schemes_committed(ctx.schemes, dump['schemes'])
+    assert_true(dump['pause'] == ctx.pause, 'pause', dump)
 
 def assert_ctxs_committed(kdamonds):
     status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
-- 
2.47.3
