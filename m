Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806619;
	b=tvJkbHXC+o1gg3i9OFwx9mUtaMv59SjCAqi04d/pr6m8EdCFMRU1bEWVBcwy5FXQG4R+
	 KHB48bvahcfuhuKZzznUEjDu2VxtBX0LyZ9zvZyECrkBENvLrhhaf3FpCcPyFw3RNGMur
	 7RWByHHdhLPTB2UszL2T8hOEho1nYlbwKGZ+vy0w6XTotW03q60oIXmKwzBaOxK23xxqU
	 x1N3fnHWY9SJ4qaWjbl3kreGSUgABRk0XyJ7rHNpKoFbEwoavdYE5/zPeEoKDlNXZ47si
	 h3PU8D4LzFHCBOBrOt7s3SeKgZiO2yeRNTHZc/c50ml/U2Rrl1cc5b3JEKMvf66YDsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806619;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+ifUpgMT6EQwsUbOKCDjOEEW6HfkKKK5IRMwF1JmJ+M=;
	b=pHhkZHoco7hG2AnTXlZnyDU6GLy4AUKgc+ZoTF0n1NXIZq5kS9bpq34IjjLmmbwt5FqN
	 x8ha19bWbK/AfDyMt/088Cv5tCcD1sTYgt9d4rJhnAt3s+sjN/M93vHEMNN4y8222wvOe
	 pU8Vi1ikllYu8mvbbYfUEhNFNETkfmWOUfgGT6CUR6cVWpjbX6pIPZjB/Q3IgnOpjlgP1
	 IG9FKqESod2QAiOS2XevGvqgZip7KBEwWdb8rR3Y22/lnd1hg+QYo6Y0Fhi7IC/WsbmAY
	 5GwOW1b7VelVTf0hGW39Ysoj+tqrx8Kc6ONDcPvVRyIFgXvBPM6H/a4otQjvop6CIyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjVHjVCX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D90606A32E;
	Wed,  4 Nov 2026 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PjVHjVCX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530891F0093A;
	Wed,  4 Nov 2026 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806618;
	bh=+ifUpgMT6EQwsUbOKCDjOEEW6HfkKKK5IRMwF1JmJ+M=;
	h=From:To:Cc:Subject:Date;
	b=PjVHjVCXwsQleO9uRLbpJSinsi5d3LRFo/G9J1Bzv1LPVBoTHgcokBBKC6jpRHBCV
	 +BsePRwfbD6YkfPBM9D2HPn9SeDvkXkMlrWPR1AsHT4eCEdom2o9rks0hN4KWwo18f
	 VeRI9RtocuzWtehKYcIbxJmabPCa8GwJ9fUS6PgUAia+83qqO20BgbeTIrm+QHtn+H
	 aWevTdrtu5rVzbJ/LCnSHdX2OMk8dMFPWzNJ2zfVmOEI50a11LuNEHunryfzSfEu5a
	 lmNZmWzLNDpMt7FyBWE4Vfmu9KCCwsdA2L90m5CKEitRnGw8sezdjpPOp55AcfbI9I
	 CNyUHbDJjZ2qQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/4] DAMOS access pattern supports selecting regions to apply a given
Date: Wed,  4 Nov 2026 07:36:39 -0800
Message-ID: <20261104153645.82945-1-sj@kernel.org>
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

One straightforward solution is extending the DAMOS access pattern for
specific deterministic time based age specification.  However, DAMOS
core filter is a better option.  It is playing a similar role in a more
flexible way.  It can be used for both accepting and rejecting regions
based on if they matched or unmatched to a given criteria.  Multiple
filters can also be combined for more flexible and detailed rules.

Extend DAMOS core filter to support milliseconds unit based age
criteria.

Implement a new DAMOS core filter type, DAMOS_FILTER_TYPE_AGE_MS, in
core layer and expose to DAMON API, via patch 1.  Add the support of the
feature on DAMON sysfs ABI with patch 2.  Update the design and usage
documents to explain the new features with patches 3 and 4,
respectively.

SJ Park (4):
  mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
  mm/damon/sysfs-schemes: support DAMOS_FILTER_TYPE_AGE_MS
  Docs/mm/damon/design: update for age_ms damos core filter type
  Docs/admin-guide/mm/damon/usage: update for age_ms damos core filter

 Documentation/admin-guide/mm/damon/usage.rst |  3 +++
 Documentation/mm/damon/design.rst            |  3 +++
 include/linux/damon.h                        | 16 ++++++++++------
 mm/damon/core.c                              |  9 ++++++++-
 mm/damon/sysfs-schemes.c                     |  5 +++++
 5 files changed, 29 insertions(+), 7 deletions(-)


base-commit: 32e967f279b24f952a5482e2c427894787848ee0
-- 
2.47.3
