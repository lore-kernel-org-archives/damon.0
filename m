Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D01B808
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789950653; cv=none; b=EyUQOHCDKtNcDr73kmUev5Vu3Bk+st1NPxmFONp/W/6iORY+pSjLL5pb10wdZeoZF2Y8PAmPwt6KWqolVmVecgUcow5UTnbJVvmkKE/DDoJAkf/63/PSqAT53z1Qb2+Go9y4Fr1ff2gVbYZ2wZ9Msu9ZVnDKOd/MTZ9L0Ovg8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789950653; c=relaxed/simple;
	bh=4Dgw1zCRHDEtgIGxmbZQtufHRqGIxj+BJYBhqMcRX9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oLXv1ODdTl11tgG1yeVI1xhlnJZS2cxqyI8u0cwndHOOuF51kcvl6wnBAUb0oxh3GwKPh3ND7HONhBZV3wQjJZtL6iFo6ojImNFNDzWz+V0/a3gLVXF92WTu9QiBczgAhDxINEbPz5h8KNxs5Rqsk5+r0rgdknjOrwemBeDrB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSqOUvdH; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSqOUvdH"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso32650815e9.2
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789950651; x=1790555451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9gh1EhGas2z2opfanmdNTY/ZLd4Wr396PDY9OySpgHE=;
        b=BSqOUvdHMwqqV41lKLUOWcF6PdBvKppwjN+MLbQuIzmvTyHsrLRBm1uVz3nxrxCsD8
         TBA5Ql2pUq+I5HK++Hzma+N+j2231AfbZ7K97CZwONraQHais8kSscG4WS5+Iu0iYqXT
         bLyvK7OjjTJTNi9yjpqe4/anmOlM/+81X70RMR8s8hNk5WykwqnDfxtFc2eWeD3EQHvr
         0B3zGZOKl0zpNGDfTCGPdtllxiPi1/0WaLI71J9vPXelR5ruMcyeszz1VF2MTQHQ42a3
         FoONTSXkzJik2S7QUTF9Y0waC7E53r8Xop+uVNLavcl6g/vbX57mYBsWQMiS6bEuBBUe
         +cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789950651; x=1790555451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9gh1EhGas2z2opfanmdNTY/ZLd4Wr396PDY9OySpgHE=;
        b=K1RRpQXr0mVod+IX/XiI8bA+kann4mzTFRk6CKIfdI9rEcr3+T6HvVDW36SGmEGwoJ
         1Ggt3gEKzGvjo/n8nGkrpVdJjkWSLf2xAVfp/UK5iFepx3gvI2Kv3vBn09RTRspQgetB
         Gll/U2ypZOdRkyuhTRXl1vrAyFswUychMcZMYe5A0shhItAAG0IYDGa/ICuJxGVQ96bw
         HdDNwGnYhXQHD1pWDcfDvvztrTVrpRTUy4LurgScOF6m8s7h087+g3DhsUDhOMLLGDe0
         Gw/ztYcWAk+rl0OjscxdaVvvEvayR4+28gqsZmTWKJIbg8oqNdCdzr7vydQHuromnleh
         ualA==
X-Forwarded-Encrypted: i=1; AKwUvBym1m4DKWx5Ngl+B+GW34bn4GZdkaFLQ8cJh8nLT2j1c3/QusqQO5iygbrMSO5Ut/zI22WpuA==@lists.linux.dev
X-Gm-Message-State: AFuF++nsKhpsLg7x4Fm7vr2rNbwSpRjxsUtsYXauzwaLb8e81uVpCqxO
	1mimgmEWtLN9xIz/LGn99+d48mPhYsOoOEPZAjRLfuEoo7DE/tyzKjMX
X-Gm-Gg: AYBFou0o9NIuuaarLXe/km2j12fEfZCTykkssydQKiOL76/WbNOJSupakch3NZcMjIt
	LbSP2NQ/YdnopfoSTD/niNUJ4BsP3yaMw0TiPOK8WFcUZa688ib1olkR2OFVhR+QC87FwItkG0/
	ORrxLiVLYqxm0he6ME/gIkTGp35n57xl5HVzyM1Ior4Y1hkG1IQridB/bjhV0QwMRVAEk00z9F8
	WqiytQCu3HPQcUQeaZ7s2xKG/gDfcaSMkzCy5n8PmeFjlPUNVM60cGw9m7B4rLrt0tZI4wFz2x6
	fHwBWa5cLO9Ld7uRL9LBbZPxeH58wzHeFxf6O/6TRFJ6IwxeEtIDpiLz94kE89bb1Yyg8V/pjB9
	Is199KvTyuau6qTZjl4+b5eCNG2SnOrgutKXaVhTTf02qAWzarGBWbDsAqOMU9F0bo7EEOjDgG8
	YmovKUzl54wWe9xHf9Q8HddIvDCl6YdLcsB0sN3LSpTcZttxu9qqdUW03EJw+yI/FQKLI66farO
	bYoCHypVJa3n2A1JxrmFH8myrq1D5FnzVqrjk8nYhxVMk07j/t1vkydzg6a/rNS3D5ItoM0+0EV
	CO5A8xUGrSLCJk6/aUqc6WJyCur8tL+f70T/pQcGwphfjrRkDOmkOrT0TtnZCzhZKL25doLYT2C
	NVw==
X-Received: by 2002:a05:600c:8b8b:b0:49e:663c:c69f with SMTP id 5b1f17b1804b1-49fc56d170dmr118923645e9.15.1789950650423;
        Sun, 20 Sep 2026 17:30:50 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a012-6c01-e0c2-ccc1-7acc-3570.310.pool.telefonica.de. [2a02:3100:a012:6c01:e0c2:ccc1:7acc:3570])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48724583fffsm17515695f8f.23.2026.09.20.17.30.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 17:30:49 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mm/damon: preserve quota state when constructing schemes
Date: Mon, 21 Sep 2026 02:30:45 +0200
Message-Id: <20260921003047.12041-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_new_scheme() initializes the caller's quota in place before copying
it. When damon_commit_ctx() clones the running context for validation,
the quota pointer belongs to a running scheme. Constructing the temporary
scheme therefore clears the running scheme's quota state, even if the
proposed update is later rejected with -EINVAL.

Initialize the new scheme's copy instead, and add KUnit tests for the
constructor and for accepted and rejected context updates.

In a live test with damo, a scheme with a plain 64 KiB size quota and a
60-second reset interval uses its quota, and a full "damo tune" with
unchanged parameters then lets it try another 64 KiB within the same
window. With the fix, sz_tried stays at 64 KiB.

With only patch 2 applied, the two new tests fail on x86-64 and i386.
With the fix, all 43 DAMON KUnit tests pass on both, and the DAMON
selftests show no new failures (QEMU TCG guest; the wss_estimation test
misses its accuracy bounds with and without the fix).

Karl Mehltretter (2):
  mm/damon/core: preserve the caller's quota in damon_new_scheme()
  mm/damon/tests/core-kunit: test preservation of caller quota state

 mm/damon/core.c             |   6 +-
 mm/damon/tests/core-kunit.h | 107 ++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 3 deletions(-)


base-commit: 185111f116aabf202d12ce440c0f6e9bae073514
-- 
2.53.0

