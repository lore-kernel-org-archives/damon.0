Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536103;
	b=QCAJKbteSEOVdXCZwDq98KQltmpnSjJvYmpQh9qNvNaYhL376XXtw8MHEZQbFLxYCOnl
	 3z8OTdQ+VHVGRdzBwA2hb3zcwTsVl+T7VUT4DwZ+bGdKbVlNTPh59C2gskD7JoPG4BmEY
	 0EVkR4tEeiMBqqhm/nZ+0Ds43g8hG/YK7XEYeOfFGwG0MbL1BclpDWRsjbzAbPMO7LMPH
	 Yk1dl8lXijbXUp+bW5JpnU9UgehJgulXmx5st19oyMwMG6TCxINDwEV6bsWWpm53qrSYH
	 eelLBJ9qfgSvXDR2f68xDwwn3DuFovhaCjwA1NubZ2eU9pwo0FYtGhcOzUfsGp/tdpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9mWj74VB0kUOTyAfecmTtKijm9c/bCkxbRVrYTWR0WM=;
	b=37On4J5mLEcmrjodazeyIF6KiZzHDXLTiyWyqDMXdezMAJA7OvOWxq9uttycqo/Miz/p
	 OQsnDIyp9DMOXjxSpQPAm6octqDyooBxae8qQX7qShVo5FZQvYPlfbmim5njvtpn7mT8r
	 AHkMylcDLicxheeXuSAPJXJE6IOtvIcgD9SgKUr/cQCa1LzyMgfxUdn+dH0/5OewVSU0+
	 MZkxpsAzgAiqekpul8IUXz497/JxLiL5O4ne+m/sNySd82wrEP6gGP3bM1KGiKwvbCQhQ
	 /q255pZg8vChjikwU9L7APbzw+QjOJnyZqZvRoF6q7ehp69M8xhC282aPNE5bN6mOJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoQr7SUV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8101606A32C;
	Tue, 24 Nov 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoQr7SUV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83CA1F000D0;
	Tue, 24 Nov 2026 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795536102;
	bh=9mWj74VB0kUOTyAfecmTtKijm9c/bCkxbRVrYTWR0WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZoQr7SUVcRQap2yuBvwxxP4A34h6k+ANMkLkPjL5sA2i6pfnV13DEyi5+Ss5PLYDD
	 0GNC0XD7zsu4nTh7zUHwtTAo8axJhTRADXECfqbXMWAPyS8Wr0NjBsjTAYeaBd26er
	 9YHRorqiAzHtdO1RtRjfoCE/aLkdtJr3KnGQhIF5ksN1lM9zYRVirAS8x7INfdp28w
	 V3FuwQoiR0j2Y56JkNaV5xgeefwk2CTvUTR4a45EenvTEM1R6oCi00lwCZtGl9EdIo
	 eiCk5S/jLrKFHZM/0wWSxpHCT/of3pcq5mWnUwo7BS65fqCgct/sElpSl+x2kkaW7f
	 coGoeL1iVXWcw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-new 2/4] Docs/mm/damon/maintainer-profile: use damon.git for patch baselines
Date: Tue, 24 Nov 2026 08:01:20 -0800
Message-ID: <20261124160124.93482-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124160124.93482-1-sj@kernel.org>
References: <20261124160124.93482-1-sj@kernel.org>
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

Right after 7.5-rc1, DAMON will onboard the mm-next transition [1].
Update DAMON maintainer-profile document to suggest using damon.git [2]
for-next and for-next-fixes trees as baselines, following the mm-next
process guideline.  Together, update the DAMON section name to match
that on the MAINTAINERS file.

[1] https://lore.kernel.org/bed81e01-7303-4957-bd7d-38e3a094e96f@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mm/damon.git/

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index c482690320249..cc6b79c066a64 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -3,13 +3,20 @@
 DAMON Maintainer Entry Profile
 ==============================
 
-The DAMON subsystem covers the files that are listed in 'DAMON' section of
-'MAINTAINERS' file.
+The DAMON subsystem covers the files that are listed in 'MEMORY MANAGEMENT -
+DAMON' section of 'MAINTAINERS' file.
 
 The mailing lists for the subsystem are damon@lists.linux.dev and
-linux-mm@kvack.org.  Patches should be made against the `mm-new tree
-<https://git.kernel.org/akpm/mm/h/mm-new>`_ whenever possible and posted to the
-mailing lists.
+linux-mm@kvack.org.
+
+Non-urgent patches should be made against the damon.git `for-next
+<https://git.kernel.org/mm/damon/h/for-next>`_ tree.  Urgent patches should be
+made against the damon.git `for-next-fixes
+<https://git.kernel.org/mm/damon/h/for-next-fixes>`_ tree.  If there is a
+reason to not use those branches as the baseline of the patch, please explain
+the reason and what baseline is used.
+
+Patches should be posted to the mailing lists whenever possible.
 
 SCM Trees
 ---------
-- 
2.47.3
