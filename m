Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EA36AB44;
	Sun, 22 Mar 2026 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774195060; cv=none; b=I3U1ZUwbOn0ZHGj6POt27qK8rC13RHSuPz1YjlHcPkyXYl6NIRBgtrsa/fdm3llCk1M+SAiL9cuZGeQ2lxHnnjysNr7upuFmUJowzL1swOCTYO6hx9eTWXTUC+tMs5WLYsWzFN3vClZy7qPEklI+po4bVS2hGv2srRujqvBKaO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774195060; c=relaxed/simple;
	bh=O/0+EEFKC+kJrViTx1hpFrUcUp3ITetgY1I7Ly2ASvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJ2czDvFERvApaBHqlSAGiqJL5rnkF/QgcRCASYB/0cRM5DpTgMz4Mcu+6aJlAM3fJQolvE9bl16O6DWydtNdrovXiV5EWL+zKkHWcnizg/hI1Y6uZmekdy6qoOkUGv4yZdvUBXc+q8XFT9klMQoGKF3lB+6DPWNgR9l2WPPjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4tXJxPI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4tXJxPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B00C2BCB9;
	Sun, 22 Mar 2026 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774195060;
	bh=O/0+EEFKC+kJrViTx1hpFrUcUp3ITetgY1I7Ly2ASvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4tXJxPIPrgz0CadeeV7+7KT1aMY9uLIhl5HCKpRzpqzSGjW12GXNEuiwIXCSkVdI
	 G+GbWzUPAPKTpVEDQ94rIl5J6EUQR52cqdL0OlkhbkTs2Zj3nphXZkaJ2TOusMXTV9
	 4TtvRyaufrJ91n3SSgAIAOqgM+68NVJCMhPx4EFexaSQWsKIji6qElSsdmKH7lLrHg
	 xKSQ4MEnOuG8/l4dZ4ItJKs+QbigXNWfx4KnROiF3wXYYOzDcPjsIZDjdzQ8vV5Bam
	 WDF+OecFSRN616EZtOHNjvFI03c1mQgh3Bj5ZufdAV0lgEiSdb083ZfkvhAWiskfeu
	 hg33jb0OmHBLg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 09/10] selftests/damon/sysfs.py: check pause on assert_ctx_committed()
Date: Sun, 22 Mar 2026 08:57:23 -0700
Message-ID: <20260322155728.81434-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322155728.81434-1-sj@kernel.org>
References: <20260322155728.81434-1-sj@kernel.org>
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
