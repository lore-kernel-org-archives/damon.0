Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1831282F;
	Fri, 11 Sep 2026 01:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089232; cv=none; b=kq95kdIDipMgmzXANnttby6fJPLGvWE6g8du5DafDiN51c308qUfemZcpYXOwcGG8mnuISFxQUcKOwQk15GyHcc/7XYIaqn8OMqqYsimv2zFrIV80B/Yz2gdgO9wQ67D/zwmFR85S5iadde8zwwvUVZ1LkUDyUyQZfpS5bmFi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089232; c=relaxed/simple;
	bh=+pwt7ytLNv7N/tXD0TT/aWOG89chC7GSwPZ5TDexaSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kg9+EABNFWIIUxnpjc4VFkudYLHQ4YAGLABL+Yig/zkS5MEU7LyDk+VnB32rWyrGZtntXvfri+lC2eWXmfPKrlmCCwqUm3TVTxkjHY8KLF3j23tKMHXcXGKyIIdhtP7ejnqpkslZigqwjVWr8CNwRH7cUfdkFPVCFKas1ozbht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg2mazDx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg2mazDx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071401F0089A;
	Fri, 11 Sep 2026 01:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089220;
	bh=3QelAmhdJ8KPxvwLkmNC9X/53BNSeYX//IkIfked+Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fg2mazDxtko1NJs5ZAtSFvkDkDiew0FG9K+ghDuUOMhDB9PA2cT/E5CPJJVlhpe0t
	 T1hpw8QkyEnmA78rSVSn0OXR2OOddYyfEbch/4plgRJwff4HWE4fQJEPMk59nNqIjl
	 xn7/ynmGmUGnU/Xszv3mbMax4sFreVELh9Aw/JuCWv1u6M2XP/zv/bmj9NPQg72XgN
	 oUGQe2/u9XngeI0scTHJZ/drVtNoGQ009+TtotaldLT2nMlgmglgz82cNuvOh7sDZ9
	 PSDTR55CI5VtyTXVdQM+gG8D3oTrLDFBw7MyUkK5+2EGovdYfhfhERKayWfzKctf0G
	 xMzozyY05iczw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC PATCH v2.2 6/7] Docs/mm/damon/design: update for probe_hits_wsum DAMOS core filter
Date: Thu, 10 Sep 2026 18:13:27 -0700
Message-ID: <20260911011330.93678-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911011330.93678-1-sj@kernel.org>
References: <20260911011330.93678-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added probe hits weighted sum
based DAMOS core filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aac84de261aa8..8e980dde362de 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -822,6 +822,9 @@ Below ``type`` of filters are currently supported.
         - Applied to pages that belonging to a given address range.
     - target
         - Applied to pages that belonging to a given DAMON monitoring target.
+    - probe_hits_wsum
+        - Matches to monitoring regions having a given range of :ref:`probe
+          hits weighted sum <damon_design_attrs_only_monitoring>` value.
 - Operations layer handled, supported by only ``paddr`` operations set.
     - anon
         - Applied to pages that containing data that not stored in files.
-- 
2.47.3
