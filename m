Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E83D954C;
	Sun, 26 Jul 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087591; cv=none; b=YDFmz4S0FZxL/je+BqmzCalPafBCwVpQmBKPWs+mUt6n+nK7m3pt34jM5R5mklH7NeWYKqOb6lt5SGHlxczUxuDzVE2L04ZAkRyvcxrLG2yYehFwe5HBCi9K4j4Je58IBczAQoir6ofdebOefB0Xw70OqBDnbbjAaBVDhgZINR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087591; c=relaxed/simple;
	bh=xcWvcxTShuREolgVeaNKxOb9JPpBPwIcsH+2uXlYsDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDoDk3JgsK1Q8X5PYV8iuA/6mZj9frDjiePp54B9oh/6fau0gwKVo05hIaRTc2gE3d/WpxfCsgbog2biLh7nha9BaXOwjUmkL53Z2gaXBqGYSkLgCDB/uWp5nXe3p14aaTkVlvtX+51zNdSqD5g2VrCP3H6z1ADYEnyRxQklmi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfGf5ZjC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfGf5ZjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1ED1F00AC4;
	Sun, 26 Jul 2026 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087589;
	bh=W5EHzuEPBttna1pHulKblhjSxz0ZvxjVFhC8U+crJAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NfGf5ZjCoPczUVUyo2w9UWlRR7cTcOzBj4vEF4PRENKaDmWTXkTty3M54wnKIIj5G
	 widdhobeVKiPvaP0hy3o3TOvF3f122pG42A53/Ndg5BmF9qY+HUb8b39fiXx6zVUGx
	 jiKTniwxzg/35RE0zXe60F5iE6YqGShJTAnJsJTLhBEvn4yrCplWUamNFu8Fz49wz3
	 wNc5joT+EdngFdatJ/AXkac723R2pgSPmkKAVpx+kUB4r5pkpBjuTyC2YIlqws/mbn
	 ywp6HRHa5v6spJ4f+fK2TIjl5bAHIupbLkkmK2AYuiO8rWBq4pIyG3BoJ2BfG0RLRx
	 qDmSbq26LG37w==
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
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 15/17] Docs/mm/damon/design: document probe preps
Date: Sun, 26 Jul 2026 10:39:31 -0700
Message-ID: <20260726173935.94046-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added DAMON probe preps
feature.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index c4830bd09498d..7f983e0c39b80 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -309,6 +309,13 @@ Users can therefore know how much of a given DAMON region has a specific data
 attribute by reading the per-region per-probe probe hits counter after each
 aggregation interval.
 
+Users can optionally register probing preparation actions per probe.  If such
+actions are registered, DAMON applies the actions to each region's sampling
+memory before starting the next sampling interval.  Currently only one action,
+``set_pgidle`` is supported.  The action marks the page for the probing target
+memory as access-idle.  This can be useful to be used together with
+``pgidle_unset`` probe filter.
+
 This is a sampling based mechanism.  Hence, it is lightweight but the output
 may include some measurement errors.  The output should be used with good
 understanding of statistics.
-- 
2.47.3
