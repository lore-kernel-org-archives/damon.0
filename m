Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A627E39BFED;
	Thu, 19 Mar 2026 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897729; cv=none; b=U5/RgD8N+rbzdh56VA4h6eMgyoVhdLBcoFOqpcRqlRMjdb7cMHAnkL5stzhPfLFgGOZsL/gsr/YoRUWHTIEtF2Ba08IAUrn/DxF3Js5xIO/ejDdjyyMOh/0IbfBsfdFR7uD4kW4RAM6BZox41B4Nbz670x3ELj6qrQfUiidp94o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897729; c=relaxed/simple;
	bh=O/0+EEFKC+kJrViTx1hpFrUcUp3ITetgY1I7Ly2ASvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN5qIyO9gLf/BHPtqRzpkJM4Y5fojo3meTzF6j57r2+iiFDpJQsch6bAl42hHqVvGhpeZ9qoVP+ZlrDJq/fdF0cbU5n53lJH5k54v2qCch3WgJjiQXWe049AmNAksdzXsK3CBPGKHE9aQLL/TL6Zi1ZoDTfOMeh6n6wzseolSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkAeejlL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkAeejlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B41DC2BCB7;
	Thu, 19 Mar 2026 05:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773897729;
	bh=O/0+EEFKC+kJrViTx1hpFrUcUp3ITetgY1I7Ly2ASvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkAeejlLb2INZGMTagXHPmD0+O8ZKjh5Fd/EXV1aG2pLl/g6jZPq1Mrvo6C3VVz3j
	 Dtoq9xah3y+18e9JrM6ZFUsBbhxCivwTPWNWIF6kjZM7na4WuYT1sGb30QQFU1uk5b
	 1DP7vpyqeTlB91DbbkaQNDCOtT28PYNWqaoS2ZomHCPkaUKmsTteNIEgMeHcK9NXj4
	 ONRxfJTwwUpw92w/suTNZEna0WTn3Bwso985LWfWJCHIr3HwOSSUcPlYaUd9vdHEo9
	 F+rKzY9X/L7ayyFot0FhpuPsVyQfRUw1eWZp6UczBsqqJJAoicDXrOanc3624URkSY
	 4hLVq2xQdY0Sw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 09/10] selftests/damon/sysfs.py: check pause on assert_ctx_committed()
Date: Wed, 18 Mar 2026 22:21:52 -0700
Message-ID: <20260319052157.99433-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260319052157.99433-1-sj@kernel.org>
References: <20260319052157.99433-1-sj@kernel.org>
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
