Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B23C81BE;
	Tue, 15 Sep 2026 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482851; cv=none; b=iiYMYqx/EK/2sGF3NUhoeJIqFBOy5bKEJvE6QzlhU2GzgJbyWyLwxx19th0GWBTGiLiMlzntRFtrx8WB7Jk05s0roSAjnBP1sQsw00hxd7eMdlbdzbHJjIzojplyvoXbUMPKEU0oQQq3Eiu2nTFGz/j1Ssnvde52b2gCKWj+G+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482851; c=relaxed/simple;
	bh=6622FqAoJyylnw82hdIzdoflo9b7IhzEAZqdmcHMO9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaT+pMqQp/ozHDeYEEGSvS6IsZ3So1PvUxuFhStf8/sGg/SFZVcRL0bi44KcWZNQFo7L0KqX5/yRUdYM+B0F+drvd3dwmITsTZ9Wj5HtnoRTz3pnpDVCON4tlTT+BVA6VYqslylsnRw0YDWp9l5IfH5W5ANoMe35v7hrZkW8dI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR7JWe2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR7JWe2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4BA1F000FF;
	Tue, 15 Sep 2026 14:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482849;
	bh=KlTkThYMNDC2bLrO2MA1hCJuFVsV7BXLwZ+Px5RpEUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cR7JWe2zcCQzbzw/3IUbtt6LlH6sxUB1CaBML78zP72aDs3bdE2z3u5y2S5kv5nca
	 Gkqaczsf3sV2zpyPAxB40mALEbAhCIDKi7+dyz5Yfuxd9fF9CwByOqmqEl1LTOZmvf
	 t9hL/XmYVGduQkZUUuzm6ZYrfKb6LANkn5EsdO+aJR5NiAmHwqLZV50Fpmc8060MUW
	 7jZHf9fyU30Vsxh68ReppviRZ4n5t0cLbbxz6WLEKOoKuEtRmB38FmWtSpLr66YYmr
	 lFUvml+ZfbI+v+P3RFgY1ZB58sHJqiIqMCoAG7290MGJSoEjqDcdAoSaiSWuJxXknp
	 IfOU5xVFxNf8A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] Docs/mm/damon/design: update for hugepage_size probe filter
Date: Tue, 15 Sep 2026 07:33:55 -0700
Message-ID: <20260915143359.91472-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915143359.91472-1-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added hugepage_size data
attribute probe filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 707170bcd1b33..0a86792f90a18 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -300,6 +300,8 @@ filter types.  Currently below filter types are supported.
 - ``pgidle_unset``: Matches if the page for the memory is marked as not
   access-idle.
 - ``pgidle_set``: Matches if the page for the memory is marked as access-idle.
+- ``hugepage_size``: Matches if the page for the memory is a part of a hugepage
+  of a given size range.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
-- 
2.47.3
