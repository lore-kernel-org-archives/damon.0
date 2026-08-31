Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B50466B70;
	Mon, 31 Aug 2026 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188819; cv=none; b=Cm2oQSY7jA7TmbDYT1AuU71sg0MTMJZ5F6SbV+pDc7kr/hFL0Ff/ZgoFEjz6eBf9vvilPW+mo2ASQjGAdZKIiCPGlQfDFzU35Y0uPzrK106fxwGEeVDiZ5Q5u+M5xXTwFGrjG35eJspefgDed8Kp3DsVw/HAZX8HBGzGLXQS3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188819; c=relaxed/simple;
	bh=wFnNt2jgm5r5DXiy28WZjbTPGQEheVu08ejp0XmG7mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ddAQxTyAsZHpd8QOCQNMRXhgmkt/1fdOkrhKzMwSmYCwL6i0QR1OY8yLQxiYmyygQgUevQJ76I/6DG7Wy3jLUJgaIvt542zvpjGPXO7oBlNQg68qZl+7bxlO/6i1BGHhcrp6FJGoPAHYLE+rxufGvmCXh+cwy7Amo9oHXw8DHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UETTYhjR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UETTYhjR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2641A1F000E9;
	Mon, 31 Aug 2026 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188818;
	bh=f4iZoQApQIfopJT8EkqZwFe8+jFo1ysNs7WLaErjg9A=;
	h=From:To:Cc:Subject:Date;
	b=UETTYhjR1rTXv97DdzXd4cNx6xYLQVULNS4zG+oBtyJsqv+07TzNV73TUu3nwkFXA
	 AVtE6H6Pmjk8cWrfo7SDBCOO/ZcQQEuHEuE94YCQiv6k5ZWVuXhNbwboKuxck9hCeZ
	 kYuVySqZCoD/Tfw5wlqkrsTr0QcwiDLiz51k3uieIDmCdOtYn2t41OrjeaPIeZqCzC
	 Bde08XvKxrSddVM3nnD1+hxa2koiRvD6z8Oloh1M4esG6f8GVlzumukBP9N85+VFfq
	 Tnz56xumE6HiEqo/+VVgbxCz1Pc3eN7OEPoPxUSsTEDoY+ivpog0KyzQE2N4VWz6Bh
	 I3e/5a5w4YYGg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/2] mm/damon: add kunit tests for probe_hits handling and probe params validation
Date: Mon, 31 Aug 2026 08:06:47 -0700
Message-ID: <20260831150650.84829-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON recently introduced probes and probe weights. Add kunit tests
for the propagation of probe_hits at region split and merge, and the
rejection of invalid probe parameters by damon_valid_probe_params().

Changes from v1
- v1: https://lore.kernel.org/20260818034552.11975-1-jasonangelov@ucla.edu
- Collec R-b: from SJ.
- Rebase to latest mm-new.

Jason Angelov (2):
  mm/damon/core-kunit: test probe_hits handling at region split and
    merge
  mm/damon/core-kunit: test damon_valid_probe_params()

 mm/damon/tests/core-kunit.h | 64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)


base-commit: e87656db0d5bae45056740ce6fc5d41e182013f4
-- 
2.47.3
