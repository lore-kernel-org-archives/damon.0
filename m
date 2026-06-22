Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35353B9D91;
	Mon, 22 Jun 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138124; cv=none; b=JDbnbazK4nZ+k4YPsd3+ShkJk7I2w/poei7ZlPAaRYCg22qCaixgoWStJd9EntQ0QbA50U0pO+ab7+GQJ+AKCpcF8K+DIWUzvU2/w69N/GzQA2SN+bnICoaZTuepD8VEPj407IA6s8qE9fSWByNZzW123r72pK2ZOG+F1A2y6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138124; c=relaxed/simple;
	bh=ckmKQgjNP1Y3L76JDcK/l1LXO+8dsi+M33MXj+hcDAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKqoImhYgBWo7dW9D+ee7ftLzqqj3Wi4WLmBsRaHLnt6a/78SKaWzfSeSv+YtpBbbq6fxlz4jzv0VS62+NrtMK85VM/qh3jTP3Ictr7B7XvnOJw+6SL6tC7CU6WoGNP0cUkvi4CRnLezoLP0S976/ehRwtrhgnntWOvQwOC/Knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1GeE3Ri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1GeE3Ri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C085E1F00A3D;
	Mon, 22 Jun 2026 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138123;
	bh=XBlT7kxUiLnizW5xmXI1w/7C7n4H7InmdeB786HKy9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N1GeE3Rimhm90PTpmyBYjuH0I+UeI83Zq1rxWm6kga1EygE/D68j1xB+g72I5aPxB
	 f9WrqoyHHcxDOqkLKyKr8sVwLglum9wY2C6XlpbPxRSf9pzydo621hII/VCJVqLoq6
	 +iZmKeNu02F/RnRw1l8k1oDliYBNlcjTod07ZfX4nWtgVpkJeSlG0Ivqk5xKtPx3Fj
	 k6Cm1rKnqyd0AWggYoQzWt0HAEc9hp10YPVX0jtbacROTpGTGDixlsOdyxuWlzd/X+
	 kuCPfvZ9BePdyamSw/KzSkEZ9RjveN3pe+Ytb0qMMG2FP5i+596pqsWQ4zQ++4QTmw
	 nCjD3Pun6sIiQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 12/18] selftests/damon/drgn_dump_damon_status: do not dump nr_accesses_bp
Date: Mon, 22 Jun 2026 07:21:32 -0700
Message-ID: <20260622142139.30269-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622142139.30269-1-sj@kernel.org>
References: <20260622142139.30269-1-sj@kernel.org>
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
