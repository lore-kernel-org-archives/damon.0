Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF53AB288;
	Thu, 10 Sep 2026 04:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013368; cv=none; b=tqP6Gwo9LrleC0Juh+66f8mr+amEOiNy+890ghaGmEMQFqOFG8ROWQyeffOq0rPNctziy64TmX2YFQwCrZjn83Sgryy6Uzf34XNEyIkMnv4gWRfBUv4OSCN8afSgTVwjwIhE+SFWJ7QQL0NTMJq+Bv2bIklG2HTtpqtLbkAINSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013368; c=relaxed/simple;
	bh=KCZ0Yk5WQx6KDsQSc5ywq2cca89SEG4MnZVTSMJg/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUDxS9Zo3ic4cn7258l+SrzxtX4rAbE91kYa9ipsx58INKEGsjinTCrhAP+gG/GuTyFboJ6TfUssEyB7NFYwc9JVaSihU1H/KF207guWDvmoIp9L8gz4Cw2bnc+PHjrFlIc0BTJcztWtN8D53r7qpjadxg1ao8j+dx0akPgApR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T74ZWSkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T74ZWSkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FBE1F0089C;
	Thu, 10 Sep 2026 04:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013366;
	bh=YGHkp73SOXJ8OAqpC14uJPbey8Nk7EBIVu4GrdElavM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T74ZWSkNJGxb/rEDsWUcATa7kBm3vaR5wctOIL0VkTCuMzG16cfJTs5879VEQn+ry
	 Gexsnph5pgy0D5tA9g/+AWNddDRx0k6La+DONOFFhLcLewMicFWyY08zSHoam3zdZr
	 +f/ueO8e9g5vyDBc0zLdkgXIUCTUF9tJXZribfU92tzdbadOOWYcUBp50cPgBQHfM1
	 aKqh7KoES3Sa7JffhYavHuq2moVktpmDiYh3bY8GLWptRahRwmExGp+fhrzGC7qimu
	 KAIbuDFVP7URM3U20yG/hQMoL3X+LOaGqelYhrpLCqNJ5xsYoq5LZW0WQbXUcuGGdM
	 cHoXLVGRS5ucw==
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
Subject: [RFC PATCH v1.1 5/5] Docs/mm/damon/design: update for pgidle_set probe filter
Date: Wed,  9 Sep 2026 21:09:07 -0700
Message-ID: <20260910040911.148273-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910040911.148273-1-sj@kernel.org>
References: <20260910040911.148273-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added pgidle_set probe filter
type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8e980dde362de..cb116a82ff20b 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -299,6 +299,7 @@ filter types.  Currently below filter types are supported.
 - ``memcg``: Same to that for DAMOS filters.
 - ``pgidle_unset``: Matches if the page for the memory is marked as not
   access-idle.
+- ``pgidle_set``: Matches if the page for the memory is marked as access-idle.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
@@ -314,7 +315,7 @@ actions are registered, DAMON applies the actions to each region's sampling
 memory before starting the next sampling interval.  Currently only one action,
 ``set_pgidle`` is supported.  The action marks the page for the probing target
 memory as access-idle.  This can be useful to be used together with
-``pgidle_unset`` probe filter.
+``pgidle_unset`` or ``pgidle_set`` probe filter.
 
 This is a sampling based mechanism.  Hence, it is lightweight but the output
 may include some measurement errors.  The output should be used with good
-- 
2.47.3
