Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841865;
	b=wFy8w0NTEvpXqbXNygaCDKgWLHM4uF3jTfcRmkQuNX2UzWclK9nDei/IPQl64b6rWb67
	 I3tkeRw4ZDPFaKbv0vJGGCT1lMQuqA44GOLub6boTBhf21GUBKc6yRbXUGtxme67MbOgi
	 qLn1owhIvHUJoI4R5THhjP13BZV/uM93cSb9UZ2jcBG8Ngb6TU+YHTPo/tPb8i+qKJtBR
	 91S6oW/3N8e6GXHZb+m3Ufpuc49qVShW8tbU1nHJ1wKh10trciRp7+PpmEzlhYR3vBFtO
	 XK8ps1LCVQJJjvJO0NJWHM9uKEveqr90D03jbYh7t9tjHMB63U9U22bqH/pqgSneY0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7mWcfXvCYIw89d+NBnSrfBHxcVlNxUCtusz5wZcedUk=;
	b=zediMtqGWR6PdKtCygtV6FrcKcRCchf7LN6N3wfgZl0Oj5U3vxULyreLOSGQ97jgfkRU
	 DOGLMo3gmA63EU4GBpuNb2egAjy+5CvBxZjIFLo4eX1XrsKyWoV9SeM469AX+LEY/ZNTe
	 wSwq7pPKOtJ9SQxTbTMLovasMsb04ExBZlA8+b3hP1PWpQAW4mlB3tTaSpCoBNFRMiho+
	 TIB1ZbSgZECXjaxUSoGrvWiWCmdQW2gRLRadWTQL1nHDtf9eOIUXf3mAC/RQNpuW2nqSP
	 VEVjIUaTh20+g1hVUasF2JJ9k1RZlaNWyOCUgC3gYlwpQQpsZiZ6bzdgUFbCW++bslQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AP+OQPlv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F5606A882;
	Mon, 16 Nov 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AP+OQPlv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855711F000C5;
	Mon, 16 Nov 2026 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841864;
	bh=7mWcfXvCYIw89d+NBnSrfBHxcVlNxUCtusz5wZcedUk=;
	h=From:To:Cc:Subject:Date;
	b=AP+OQPlv2wvV1qeCtUx/znTHrgoKV+f0KbfrsZZGcfLYckkSwJ6t74XWV4AtDHgh3
	 srjoKg6jamqK3ieGfmSx0T1w8XiaqCKkFMi4ZU0Ixt6yM7mzSz/Evof9O3/VpOAWWl
	 vehR6Tlp+j2pO6dwG7QCf6PbXutOr+PW0I85sAg4rWVR+JXl/loLJQCZXIqIj9Mj+3
	 FO5UVRMJmCGj+O7L0fxKeLhAImFPzbDmY0lNSPYv8PR1Izz9eVjJAmHDv01dqF8NNG
	 H2dlqYCcDXAVCUkk1Mumy7T1cRFQy5Q9FKjhBgUBEb3WS6gfaSHKrgjPWyJyRbIy0t
	 DktBVCQ2WH/mw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon: add paddr kunit and replace weird "same to" uses in design doc
Date: Mon, 16 Nov 2026 07:10:50 -0800
Message-ID: <20261116151057.81692-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kunit tests for physical address space DAMON operation set, via
patch 1 from Avelin Noir.  Use idiomatic "same as" instead of weird
"same to" in design doc, via patch 2 from Enze Li.

This is a batched reposting of DAMON patches for mm.git merge request.
Refer to changelog in each patch for their real changelog.

Aveline Noir (1):
  mm/damon/paddr: add KUnit tests for addr_unit conversion

Enze Li (1):
  Docs/mm/damon/design: replace "same to" with "same as"

 Documentation/mm/damon/design.rst | 14 ++++----
 mm/damon/Kconfig                  | 12 +++++++
 mm/damon/paddr.c                  |  2 ++
 mm/damon/tests/.kunitconfig       |  4 +++
 mm/damon/tests/paddr-kunit.h      | 55 +++++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+), 7 deletions(-)
 create mode 100644 mm/damon/tests/paddr-kunit.h


base-commit: 4789d52076c67ff1ce4c66fe7ee17718a48b3bec
-- 
2.47.3
