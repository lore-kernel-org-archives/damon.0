Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE1332918;
	Mon, 27 Apr 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302764; cv=none; b=hkbnF7WnuLrQrOVhnimjJ8pY5/uX/kbRdgRrlL7dwd7L0c+McTACAhTIf66IOzyrT/D4rPRPNTgF2o5DgNBuoXV62MVLxAfsqLKSZIaom3ZY/YF4gxvZ/mT2YB9cdqfKOBmnont3m/scyseWRDvcPB4fz90jfMvMelFg39MpKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302764; c=relaxed/simple;
	bh=+CPx6XCIAlUTHv2UDUveibU84QomoA79cOtNOXMz0F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYR31QikO1ICimMkV8VLUU/u2qq5IItLsmOFChr32ATcMr7ncYY31R6Qt0IErKCUK7oy9PLQFkTsrnmqSscGotkaUOWIGVT5i/qr5Oq6wt71o4sGYpyP3Dpfi8EKyiaNqZOGmf3HMKKC3WZ3JPqiadbLAhEOZycB79IzL7y3jYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0+kdXmE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0+kdXmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA46C19425;
	Mon, 27 Apr 2026 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302764;
	bh=+CPx6XCIAlUTHv2UDUveibU84QomoA79cOtNOXMz0F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0+kdXmEj4DQIjQ/GIyo9wxd8IEjbDZ4/fFiVGkdnvnCZVRdIJARPqoBKpGn1Kli5
	 jzMdP3lqYhIzek0d/6R9OibhGx72nqPv9oxC0wnqPZiSp+DkmbPop8aUNlTfiv+wsd
	 PK6590bNuJBWUCVz+j1ywLYHQqV4l3RzvUdDM7dhGvrWXe5Shmi050HXgYZ28iDpGY
	 HTXBYeLFzYcdKGd14guukErq7f5ccq0b1jYoIjCjGgNSU5KLdpmlMXG0nmusX+zD/g
	 QwIfvkO6LT4/961FgTWgpy9v+DwzUQYqbVvVCOx2xJIMXy80UAtaipfnxIJc3JNXAW
	 xNJVWjzPLYw8A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 09/10] selftests/damon/sysfs.py: check pause on assert_ctx_committed()
Date: Mon, 27 Apr 2026 08:12:28 -0700
Message-ID: <20260427151231.113429-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260427151231.113429-1-sj@kernel.org>
References: <20260427151231.113429-1-sj@kernel.org>
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
index 72f53180c6a88..5a5d2f2774566 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -191,6 +191,7 @@ def assert_ctx_committed(ctx, dump):
     assert_monitoring_attrs_committed(ctx.monitoring_attrs, dump['attrs'])
     assert_monitoring_targets_committed(ctx.targets, dump['adaptive_targets'])
     assert_schemes_committed(ctx.schemes, dump['schemes'])
+    assert_true(dump['pause'] == ctx.pause, 'pause', dump)
 
 def assert_ctxs_committed(kdamonds):
     status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
-- 
2.47.3
