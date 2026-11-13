Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547041;
	b=mHccBNcyYHxtpvPzF0JmdQtKv6KJwrDfV0ns7FaMHrumRM1a4CsP1/cs8u/hVYq1fkbi
	 xEZ36moF7q/qpPRog/johlARYpHMuzlWzC3ogLd3uPJn17kE/bL/9o/qsT0PBr2X+tvRN
	 9CQNc3bU+Yn0tpvY7OkcMlJy26kmS+QdxTGY+Y4OEGNhw2oTiVoma6QASBxPwQTEcLjD+
	 YBMGHM/BaHYTzrqQT2/bLsQG9oIJ15+09K35qRGeTZHySApRXx9IeaQFQHGl+8ZPq5ymd
	 cYtKymTYdmwdW8pgfxPZNF9xr5brM24uYcghrraX9fcPSOOVw7b+P16aEigSDPnDTMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547041;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EeP31xDwtklkLCBDsJsARx3xlsMptNDNnDQPe92kOMU=;
	b=pZKsYveLSrDeJIHRJbj6j2OmBBLsGTmuK8twYXTWrlsjFD69if05r+4MXLgx/MsNjnZv
	 Nqgl5NCxQ2O0wiaiPJ7BJKLTbDYPFOVD9SsaOQ/lW1eUi3gLODePk2AtZDv6YaOg/nyRA
	 5vLL+o3eZIWDdrdS1sLDTbIOQh8Mc5iDTcYrXLA6snNIwM75gsfm89a4XmKfDOLUOQQSc
	 H7C//WTTzOq1BuNOxLnfsKcu3WU2N78lnHKnNUpf7kHUKEfwxXyn0iXwLNo6+xJs9rysN
	 UYbyQ6meTrnlhSyFFuRmAXyjOY4BfTeluz2yhN5zBbb8g0IevMPUN1tIXg4WYpX0PfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DI6cec1l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA3606A888;
	Fri, 13 Nov 2026 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DI6cec1l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBE41F000C7;
	Fri, 13 Nov 2026 05:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794547041;
	bh=EeP31xDwtklkLCBDsJsARx3xlsMptNDNnDQPe92kOMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DI6cec1lFt8nmjrGEBO06CLJUfSSC0a4BWkepHbUenLfF+pTjP4iHYOLkmB8PSAA4
	 r5pUMB7bEhqPBrtWR/RmojjvJ0vlKVEDNcYG01IOBUSbRefGRBCFdnxwif74ZyMLqE
	 BaeG+uliSCOC09CuaZQeCsCw/efjvQgDfSmEaP/qhwVdN6YqoZmCyp0w7AoMRqdhFU
	 1cV4AxixDcFvYbDHKiiP5vewGsfSkAUAD8reJhbdvD7AWipadBUlnU5ybqNUkTMlK1
	 WJF4npA/BAcQkbM+yr4SLM1skaBp5R4fNs6IL6ezmVfxGA404PYlgtFOykjaSnLtuL
	 L6hzl0asMCdhw==
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
Subject: [PATCH 4/4] Docs/mm/damon/design: update for DAMON_FILTER_TYPE_ACTIVE
Date: Thu, 12 Nov 2026 21:17:10 -0800
Message-ID: <20261113051711.89274-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113051711.89274-1-sj@kernel.org>
References: <20261113051711.89274-1-sj@kernel.org>
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

Update DAMON design document for the newly added LRU-activeness DAMON
filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8440c4954090e..b676be6971589 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -302,6 +302,7 @@ filter types.  Currently below filter types are supported.
 - ``pgidle_set``: Matches if the page for the memory is marked as access-idle.
 - ``hugepage_size``: Matches if the page for the memory is a part of a hugepage
   of a given size range.
+- ``active``: Same to that for DAMOS filters.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
-- 
2.47.3
