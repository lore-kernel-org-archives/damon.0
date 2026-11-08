Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165384;
	b=JtzGgTbH4vTIPPM5gINq8vYFQVeZBZBUwixO4zyidO9mok7CZ/CE9Dj1uJANU+nsPUK/
	 tHi+jn5By+qlluD8bbgI09F2bJ1p+Q6KchiIYFr6zpRLl7NHhuDWGnTlnj474K2QOJGpX
	 xcejBz5/uCjHyxrNHbTLKpAZQA/wGOBTxlKIp3pvNrjAyA54oeS7KN35FIEXw0HyKjE2S
	 O0KBDTW5H2RoIpRXTOKZPGD8gdcY7KzSL5NmPyvmC/s6OAA2BMxCfTgt4deVyiXsnh3dx
	 FykfwnIwnJ+PbVV5N/EbpSh6uEtIXTcHmNDixRhVoY3/FmIpcdj3UVBDzqVwdEXNosw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y4WeU3u33cGe+s7G0SsXEEKF8+yYSzclx+9C+kGPhlM=;
	b=fdPasuHL7CcRNMs+3JKSlS1fYxOiBKxgIxVB63zYAZEeYdSeT+BEG7GjXz9vbl8RSfSG
	 a9kVrTXqZQBgrJeFD8+cSowXPRykWvE2jDnbPJtQ580UkzXuRBSVo3PkzgNxK9E58jnxR
	 pXhAOkC87Q6Y3u5m9UsU+hgkxl7k4E3cxFlxj9dWO33zCqV1uovo5ettk5sSEf5wbfKi3
	 mgHbQ3So9bEW/suFFLHIO/nMJz6vpbl8C7pURVjeXEpmIM43ltHs0ZKVp2pdyj9N5eT5R
	 kuWwi1zaU+hWixyaAZBVpNbUMsyndfor3mlXaDPRjhFxgcxNNChtOqQjXsAbqcRGu/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnMyYoU3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121E606A320;
	Sun,  8 Nov 2026 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnMyYoU3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30B41F0089F;
	Sun,  8 Nov 2026 19:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165383;
	bh=Y4WeU3u33cGe+s7G0SsXEEKF8+yYSzclx+9C+kGPhlM=;
	h=From:To:Cc:Subject:Date;
	b=fnMyYoU38fjQNgOxD8Z/0S/MN/PHEPKvBrcNhfLKoqbM3PjR366nEGNqwsUnBsxvo
	 SbL9KvYiw/kEr/QGOroqzLmdwTwXL2mywZqJLc5qv6PGvEb2IJb8a4h7sadJmeoNLx
	 tNdU+yfpVulrx5cJzidQiyhJRdgjclF/8MOIaqrE1Ydd7aCWAhfOG/BEo/Y3yrw02K
	 F4vEK7mrH6uFpg16tiFsc6DduNZd2ZVA3sR7RWXC2tslSTY0XBjZuFZGmhgzcwSMGR
	 Q/M4g9FqMmRyl6sB5HHnezjPW9RbM6fSUZ5qNA0uBEJJjuEQLXXhS3MheRd8XA0MzR
	 LGRmrlR7Y63kQ==
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
Subject: [RFC PATCH 0/4] mm/damon: add lru-active probe filter type
Date: Sun,  8 Nov 2026 11:16:10 -0800
Message-ID: <20261108191615.113362-1-sj@kernel.org>
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

The LRU-activeness of folios is useful information for understanding and
optimizing the system.  DAMOS ops filter therefore supports filtering
memory based on the information.  Using it, the information can be
extracted in the folio granularity.  It is precise but expensive.  DAMON
probe filter is the complementary way for getting the information in
region granularity with much cheaper cost.  DAMON filter does not
support LRU-activeness based filtering, though.  Add the support.

Define new DAMON filter type, DAMON_FILTER_TYPE_ACTIVE, on core API
(patch 1).  Add support for it on both vaddr and paddr operation set
(patch 2).  Extend DAMON filter sysfs ABI to let users configure DAMON
filters of the type using a new keyword, "active" (patch 3).  Finally,
update the DAMON design document to explain the new type (patch 4).

SJ Park (4):
  mm/damon/api: define DAMON_FILTER_TYPE_ACTIVE
  mm/damon/ops-common: implement DAMON_FILTER_TYPE_ACTIVE operation
  mm/damon/sysfs: support LRU-activeness based DAMON filter setup
  Docs/mm/damon/design: update for DAMON_FILTER_TYPE_ACTIVE

 Documentation/mm/damon/design.rst | 1 +
 include/linux/damon.h             | 2 ++
 mm/damon/ops-common.c             | 7 +++++++
 mm/damon/sysfs.c                  | 4 ++++
 4 files changed, 14 insertions(+)


base-commit: 50061821991431146db6bd16b571742c06146d30
-- 
2.47.3
