Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6A3382CF;
	Mon, 27 Apr 2026 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302764; cv=none; b=IRHdgShZFr/uSzRWeLVZQc3z0ZQQlBLtSOdo9UXHyaQxeCHdngFeoM7OlICBFkSuGMFasgbG6I78+1hkxLfHSRxotyiVJt35sw7KQmj55lGejrdEXG8ezfQoC+y/CvVDn7HJQja+L1X7W0AyoocS2eoajIfKjkOm05M6n0q8Y8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302764; c=relaxed/simple;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnDpnstpaDE3HlQ+JfB55CjVDOOM9Lp2hmRV7GzvwygF6NiaohBfce/dgkuLtmUYRjolcSZ3h9Cgc+yidBx6RYKmP4+/KKBYS9fzbKi7LmSKeVqmk/ZIgD0fwjFR1BRkS8EakvM07bMx6xPVlrS57NFZmVCo2gjRnmQ19ATJIog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHvaeA9B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHvaeA9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB30C2BCB7;
	Mon, 27 Apr 2026 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302763;
	bh=9O26QoN+V9tNeSexEgjKx5Rwm+ySmwIIy3Pdsz7ovf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHvaeA9B29EOfNwhZ2BklSXm4t/Hcqa3SiTUb2DUOZDFGSxRDTO6B7qmoBVRub2Ve
	 O0HzutMREEg6GOFwc0InVJ4mlzGmbxWNwybN/i5sFNh9wWa5PSqIuBiUiUApIeQQdz
	 NZF5YN36/bPjjd5NttoNMCbxS88s2WUmdm3P91MzNlr/mMOFth39DNGPpnFjC1dR7f
	 7CuKeGpOaylKpV11mk2LwNVJRALqRuhdlAUpVKkMyEb6PaqbTLaOHei8Dg8PvLTYhw
	 hRIoESfZzSpHRUwj3Nl2DMgbzC2rdZjwm7ncKz3Y1MNPYp2MRfQ9GOc1gsyvSvjIWc
	 Aj4ogr0+dgIIw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 08/10] selftests/damon/drgn_dump_damon_status: dump pause
Date: Mon, 27 Apr 2026 08:12:27 -0700
Message-ID: <20260427151231.113429-9-sj@kernel.org>
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
