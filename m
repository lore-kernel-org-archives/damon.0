Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793853883;
	b=oH/syvuS33SuHDPMthlEh4l828XJzwa5P/ds4Q4kngW83C05VFzkVYSOJcSzN6Wz0wrZ
	 YF/aTax7IyxVG9AnkWm0w+PsIVnkkMdKDDwF0g5ZJakrrSeo2vl3UYB6QXiSO0x7HpZCQ
	 tlrfysv9xIxbIn8O09TwWU0WWwST2BRZMt0PXa5Uv+OQDGc1JSQZKdsBnYrlTo92ue0/q
	 nSJf0ky3ItCbsKZsgEVIQgsC+sYm6Vf1GnGGocYq8r5F/EQWVMzS8cV6K7HczJOn69xn3
	 P/v3J6GfKMZXJycCPdhZ9a0P8mllx5b1pWJWP3raIZ5kPBuu0nH1ispHynvG2HcE6AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3wzoM/i5blqpVa0PHI6iBHhA/UaoyUK0u2TZ2889m7Q=;
	b=k1OAQBVP37wbxUkpx8bfSxZ5MoHqAVC7zt2QlOkVwKJ2VkV69OZlzr9FJaM+arUNc1Ls
	 K8DROFOFPxImmdkL/7y8l81SHB25BOJibWt5FNatPvBxKjvBYIpsdgyaXJ0VFPiehqFFX
	 aKVYb/SyKdamtLgE7D6j+nDfmfC2eMvBBmQlsYVuBz4CrxY35LiNaVxEdGiKdoNKsyPoa
	 fMVgXkmAGRtoGpUjHXDuq7h/ZBgL7po4YrU/TbcSi9T4E8nKWAUjH4px5NR580IQFUJfB
	 FV6Ku0zpVkawxbro07cJWgWFy9XQhxLiu4/Pf5WL7xIWXKKPzOqyfxd4WCmL1jRKFhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyumF8Du;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17201606A326;
	Thu,  5 Nov 2026 04:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyumF8Du
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5421F000C1;
	Thu,  5 Nov 2026 04:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793853882;
	bh=3wzoM/i5blqpVa0PHI6iBHhA/UaoyUK0u2TZ2889m7Q=;
	h=From:To:Cc:Subject:Date;
	b=SyumF8DuwB1mhQ7DKcJKoThrAl/2XnlZWVntfbW+1Iam7h5p6/p8wDzO4vsnUamxr
	 f2vjQ9gyDJp0aOk6/I1pCgZ+otIdVxM9sGHXCpzjqAP2d7Yf7Vll+84mgj6WjItQYB
	 rgjG2nmh77sMq1poDCRz0Bk5HDTzWeZxn2aqQvlMEN/VoR3YoD8IgXhGX+7Q8Qrx5Q
	 4R+llb5pKV1EUHx9ml9sQVDOa+TD4jOYwWDtnNAqSKGF802SOh3SFGq36KYCIKRmld
	 doT8uF+6VPVW84ueqyanMl7HH1x97rs49DbAXNVoEm0mtgTTWxfx4mJ+vdLFycf6d5
	 QWpSIc2gYi7rQ==
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
Subject: [RFC PATCH v2 0/4] mm/damon: introduce age_ms damos core filter type
Date: Wed,  4 Nov 2026 20:44:20 -0800
Message-ID: <20261105044425.87142-1-sj@kernel.org>
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

DAMOS access pattern supports selecting regions to apply a given
operation to, based on their age (access frequency stability).  The age
is specified in the aggregation intervals unit.  The aggregation
interval can be changed by users or intervals auto-tuning features.  If
the intention is to specify the age in a deterministic way (e.g., 2
minutes), it should be updated for each aggregation interval update.
Doing so is cumbersome and challenging, particularly in the interval
auto-tuning case.

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

Changes from RFC
- RFC: https://lore.kernel.org/20261104153645.82945-1-sj@kernel.org
- Use div_u64() to avoid 32 bit overflow of age_ms in core.

SJ Park (4):
  mm/damon/core: add DAMOS_FILTER_TYPE_AGE_MS
  mm/damon/sysfs-schemes: support DAMOS_FILTER_TYPE_AGE_MS
  Docs/mm/damon/design: update for age_ms damos core filter type
  Docs/admin-guide/mm/damon/usage: update for age_ms damos core filter

 Documentation/admin-guide/mm/damon/usage.rst |  3 +++
 Documentation/mm/damon/design.rst            |  3 +++
 include/linux/damon.h                        | 16 ++++++++++------
 mm/damon/core.c                              | 10 +++++++++-
 mm/damon/sysfs-schemes.c                     |  5 +++++
 5 files changed, 30 insertions(+), 7 deletions(-)


base-commit: b8894fdd591f7e789182cabd6b6a2aefd3d35c3d
-- 
2.47.3
