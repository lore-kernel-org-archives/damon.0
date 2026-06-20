Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E52632ED5C;
	Sat, 20 Jun 2026 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976189; cv=none; b=LD7Pr83yrKedTKyqlcX5bU2l+ni/KLL8MIAptR3zVZFNLPMFKxtK2oidZ9r1yz7P8Bt1RdfJpPTUw7dSpx63vv7MKkkv0+lk7fUmfF8Xc7jOO8u0mKYEf8VyyvITdvG8fA9UKXgKuXD8c0qSV2Orfcw1OG5tZgRYjcHJtALrdKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976189; c=relaxed/simple;
	bh=ckmKQgjNP1Y3L76JDcK/l1LXO+8dsi+M33MXj+hcDAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTxzK2Uy87RXT7XdPEOJINGouPVgebiPcCEii4gPb5tC3wcZESne9Z1ziEXnRO6t2xAKGO9U9oF6XCu0ZuDWh65nTEFTjdCr6uJHUsWTWWp9izw/I9XiYiUek1HBreD6SV1OdkyZxlvDmHDe/OMXcku+wyfd14R++EYBUCbRqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY0EmP9k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY0EmP9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C37F1F00A3A;
	Sat, 20 Jun 2026 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976187;
	bh=XBlT7kxUiLnizW5xmXI1w/7C7n4H7InmdeB786HKy9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bY0EmP9kHKILCZpDoJ/3Zyoj2+PSjbj6oiY+gylfLmpCGMnhNESxUQbEWw56XJFXP
	 MOREufxvvgg2cL+WghgGR821aPum2ROYWCpD3VRxnDQEkCdNkg5r9Y2i7V2MD/hXCc
	 vvoowu/lh9mzLGCKrrUujNNDkpctYFTvaxiFJdy+Epx9S7UnPAiNu7ypkPjbydKi2i
	 FHKWR4qVbEN8hn6jRlDJD0s5DeSD4luNBZ6iyZDwFBtCUPTNjOkflI/p5Xr3DysFIB
	 ak0RgUS7CXULgbONJIFljrCY0yyZ5ZGSn1RU7IQSLuixM8mkT8mNL1/LcKIX+ycdSM
	 6qk7Ur93QGkzQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 10/13] selftests/damon/drgn_dump_damon_status: do not dump nr_accesses_bp
Date: Sat, 20 Jun 2026 10:22:40 -0700
Message-ID: <20260620172244.90953-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260620172244.90953-1-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drgn_dump_damon_status is dumping nr_accesses_bp field for future use
case.  nr_accesses_bp is not being used for a real purpose, though.
Hence there will be no future test for it.  Do not dump it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 26b207e44268d..09552e91bc782 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -59,7 +59,6 @@ def region_to_dict(region):
         ['ar', addr_range_to_dict],
         ['sampling_addr', int],
         ['nr_accesses', int],
-        ['nr_accesses_bp', int],
         ['age', int],
         ])
 
-- 
2.47.3
