Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DB03B19D1;
	Fri, 19 Jun 2026 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897683; cv=none; b=EqALGPXFCjwWSTvwTMlKL4jAMx1m3J6Pw8TBeP2zF0PULsj09yPV1LcyGH6PVae0vh2My91AxSWOqELkzBujnwxX9z44SoI771ye0wO6hmeSDhEMAhIplyzPJ+XI5G6efJl/Znz5JjYWMPPFXepR2kJVJPAuRFOJJDUtj9gAW6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897683; c=relaxed/simple;
	bh=ckmKQgjNP1Y3L76JDcK/l1LXO+8dsi+M33MXj+hcDAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGHNo/N65HWDhs2hRORhmvEpGCg1sGLzl1SeCz4awgfin9eyE+0xB2vq8LgFPu75GRTkal4yDjM6Eznu/o1Fpxh3MilAnyi90QLLzp5RQcNp2XcFLBXdk6ez7k4CURzlAlo2VUTYKU343v5s53AFAPL2UV0leylDZqd5k2WfMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny9+Kznl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny9+Kznl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224321F000E9;
	Fri, 19 Jun 2026 19:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897682;
	bh=XBlT7kxUiLnizW5xmXI1w/7C7n4H7InmdeB786HKy9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ny9+KznlYEP6SchJflaCoUtX0tHqTw8X59gRCxW29e3y2GXD3eajvaPWBqRqmKnQH
	 UcV4l/LfDwxJ1qA4Ay5mqsiSzwdMr6IeZmKPsNMOMVbjtwl9+rsOVPojvSaHVIRTzk
	 J5fsWDLwZnC6MpCudVoFauMxnjPQXAAONS3moSabddLfuJxiOQHZnScWrrXtLI5QmT
	 OUn+ypavd7XqEILXFF0wHOCPiAzjv9pB7xdvzoD8NyFMcvIZRfy5alevPKlntSxL7X
	 lGsQsQic01lUfwSDwQDF0prZBZ4vekvoQZhsKdOZ/26a9ntu2zzqaQI8Bjck1HCl5w
	 fR34e1mBtc3XA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/13] selftests/damon/drgn_dump_damon_status: do not dump nr_accesses_bp
Date: Fri, 19 Jun 2026 12:33:55 -0700
Message-ID: <20260619193415.73833-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619193415.73833-1-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
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
